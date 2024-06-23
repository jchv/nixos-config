{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {
    jchw.mullvadNs.enable = lib.mkEnableOption "mullvad namespace";
  };

  config =
    let
      mullvadNamespace = "mullvad";
      mullvadInterface = "wgmullvad";
      mullvadNameserver = "10.64.0.1";
      mullvadExec = pkgs.writeC "mullvad-exec" { destination = "/bin/mullvad-exec.orig"; } ''
        #define _GNU_SOURCE
        #define NAME_OF_NETWORK_NAMESPACE "${mullvadNamespace}"
        #define PATH_TO_NAMESPACE "/run/netns/" NAME_OF_NETWORK_NAMESPACE
        #define PATH_TO_SYS_RESOLV "/etc/resolv.conf"
        #define PATH_TO_NS_RESOLV "/etc/netns/" NAME_OF_NETWORK_NAMESPACE "/resolv.conf"
        #include <fcntl.h>
        #include <sched.h>
        #include <sys/types.h>
        #include <sys/stat.h>
        #include <sys/mount.h>
        #include <unistd.h>
        #include <stdlib.h>
        #include <stdio.h>
        int die(const char *message) {
          fprintf(stderr, "%s", message);
          exit(-1);
          return -1;
        }
        int main(int argc, char ** argv) {
          if (getuid() == 0 || getgid() == 0)
            return die("must not be ran as root");
          if (geteuid() != 0)
            return die("must be ran as setuid root");
          int fd = open(PATH_TO_NAMESPACE, O_RDONLY);
          if (fd == -1)
            return die("failed to open netns");
          if (setns(fd, CLONE_NEWNET) != 0)
            return die("setns call failed");
          if (close(fd) != 0)
            return die("closing netns fd failed");
          if (unshare(CLONE_NEWNS) != 0)
            return die("unsharing fs failed");
          if (mount("none", "/", NULL, MS_REC | MS_PRIVATE, NULL) != 0)
            return die("moving to private root mount failed");
          if (mount(PATH_TO_NS_RESOLV, PATH_TO_SYS_RESOLV,
                    NULL, MS_BIND | MS_PRIVATE, NULL) != 0)
            return die("mounting netns /etc/resolv.conf failed");
          if (mount("/var/empty", "/var/run/nscd", NULL,
                    MS_BIND | MS_PRIVATE, NULL) != 0)
            return die("clobbering nscd socket failed");
          if (setgid(getgid()) != 0 || setuid(getuid()) != 0)
            return die("dropping root failed");
          if (getuid() == 0 || getgid() == 0 || geteuid() == 0 || getegid() == 0)
            return die("unexpected root permissions after dropping root");
          if (argc > 1)
            execvpe(argv[1], argv + 1, environ);
          return die("no command provided");
        }
      '';
    in
    lib.mkIf config.jchw.mullvadNs.enable {
      sops.secrets = {
        "mullvad/account" = { };
        "mullvad/device" = { };
        "mullvad/privateKey" = { };
        "mullvad/server" = { };
      };

      environment.systemPackages = [ pkgs.wireguard-tools ];

      security.wrappers.mullvad-exec = {
        source = "${mullvadExec}/bin/mullvad-exec.orig";
        setuid = true;
        owner = "root";
        group = "users";
        permissions = "u+wrx,g+x";
      };

      systemd.services.setup-mullvad-netns = {
        description = "Set Up Mullvad Network Namespace";
        path = [
          pkgs.iproute
          pkgs.wireguard-tools
          pkgs.iptables
          pkgs.curl
          pkgs.jq
        ];
        after = [ "network-online.target" ];
        wants = [ "network-online.target" ];
        wantedBy = [ "multi-user.target" ];

        serviceConfig = {
          Type = "oneshot";
        };

        script = ''
          set -e
          NAMESPACE="${mullvadNamespace}"
          INTERFACE="${mullvadInterface}"
          PRIVATEKEY_PATH="${config.sops.secrets."mullvad/privateKey".path}"
          PUBLICKEY="$(cat $PRIVATEKEY_PATH | ${pkgs.wireguard-tools}/bin/wg pubkey)"
          SERVER="$(cat ${config.sops.secrets."mullvad/server".path})"
          DEVICE="$(cat ${config.sops.secrets."mullvad/device".path})"
          ACCOUNT="$(cat ${config.sops.secrets."mullvad/account".path})"

          echo "[+] Network namespace script started."

          echo "[+] Fetching Mullvad endpoint information for server."
          SERVERS="$(curl -LsS https://api.mullvad.net/public/relays/wireguard/v1/)"
          SERVER_DATA="$(<<<"$SERVERS" jq ".countries[].cities[].relays[] | select (.hostname == \"$SERVER\")")"
          SERVER_PUBLICKEY="$(<<<"$SERVER_DATA" jq -r .public_key)"
          SERVER_ENDPOINT_IPV4="$(<<<"$SERVER_DATA" jq -r .ipv4_addr_in):51820"
          SERVER_ENDPOINT_IPV6="$(<<<"$SERVER_DATA" jq -r .ipv6_addr_in):51820"

          echo "[+] Fetching Mullvad endpoint information for account."
          ENDPOINT="$(curl -sSL https://api.mullvad.net/wg -d account="$ACCOUNT" --data-urlencode pubkey="$PUBLICKEY")"
          if [[ ! $ENDPOINT =~ ^[0-9a-f:/.,]+$ ]]; then
            echo "[-] Error: unexpected response from API: $ENDPOINT"
            exit 1
          fi
          IFS=, read -r IPV4_ENDPOINT IPV6_ENDPOINT <<< $ENDPOINT # I really don't like shell scripting btw

          echo "[+] Connecting to Mullvad server $SERVER as $DEVICE ($PUBLICKEY)"

          echo "[+] Setting up $INTERFACE in $NAMESPACE to connect to $IPV4_ENDPOINT and $IPV6_ENDPOINT."

          echo -n "[+] Turning off existing interface $INTERFACE if exists... "
          ip -n "$NAMESPACE" link set "$INTERFACE" down 2>/dev/null && echo "Done." || echo "Not found."

          echo -n "[+] Removing existing interface $INTERFACE if exists... "
          ip -n "$NAMESPACE" link delete "$INTERFACE" 2>/dev/null && echo "Done." || echo "Not found."

          echo "[+] Creating namespace $NAMESPACE if not exists..."
          [ -f "/run/netns/$NAMESPACE" ] && echo "[-] Namespace exists." || ip netns add "$NAMESPACE"

          echo "[+] Creating interface $INTERFACE."
          ip link add "$INTERFACE" type wireguard || echo "$INTERFACE exists."

          # Currently do not connect to IPv6. grumble grumble
          echo "[+] Uploading Wireguard configuration to $INTERFACE."
          wg set "$INTERFACE" \
            private-key "$PRIVATEKEY_PATH" \
            peer "$SERVER_PUBLICKEY" \
            endpoint "$SERVER_ENDPOINT_IPV4" \
            allowed-ips "0.0.0.0/0,::0/0"

          echo "[+] Moving interface $INTERFACE to namespace $NAMESPACE."
          ip link set "$INTERFACE" netns "$NAMESPACE"

          echo "[+] Setting interface $INTERFACE up."
          ip -n "$NAMESPACE" link set "$INTERFACE" up

          echo "[+] Adding IPv4 endpoint $IPV4_ENDPOINT to $INTERFACE."
          ip -n "$NAMESPACE" addr add "$IPV4_ENDPOINT" dev $INTERFACE

          echo "[+] Adding IPv6 endpoint $IPV6_ENDPOINT to $INTERFACE."
          ip -n "$NAMESPACE" addr add "$IPV6_ENDPOINT" dev "$INTERFACE"

          echo "[+] Adding default route to $INTERFACE."
          ip -n "$NAMESPACE" route add default dev "$INTERFACE"

          # TODO: stop being lazy and calling netns exec like 10 times in one script
          echo "[+] Setting up DNS leak protection inside of $NAMESPACE."
          ip netns exec "$NAMESPACE" iptables -P INPUT ACCEPT
          ip netns exec "$NAMESPACE" iptables -P OUTPUT ACCEPT
          ip netns exec "$NAMESPACE" iptables -P FORWARD ACCEPT
          ip netns exec "$NAMESPACE" iptables -F INPUT
          ip netns exec "$NAMESPACE" iptables -F OUTPUT
          ip netns exec "$NAMESPACE" iptables -F FORWARD
          ip netns exec "$NAMESPACE" iptables -t nat -F
          ip netns exec "$NAMESPACE" iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to "${mullvadNameserver}"
          ip netns exec "$NAMESPACE" iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to "${mullvadNameserver}"

          echo "[+] Success! Probably..."
        '';
      };

      environment.etc.mullvad-resolvconf = {
        target = "netns/mullvad/resolv.conf";
        text = ''
          # Generated by vpn.nix
          # WARNING: This file gets blown away by NetworkManager.
          # It will periodically perform a swap on /etc/resolv.conf.
          # The bindmount applies to the inode, not the filename.
          # That means even in the netns, this file will suddenly disappear.
          # So actually DNS is enforced via iptables rules.
          # Switching to systemd-resolved would resolve this...
          search localdomain
          nameserver ${mullvadNameserver}
          options edns0
        '';
      };
    };
}
