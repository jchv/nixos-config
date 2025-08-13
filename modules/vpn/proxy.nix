{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {
    jchw.vpn.proxy.enable = lib.mkEnableOption "mullvad proxy";
  };

  config = lib.mkIf config.jchw.vpn.proxy.enable {
    sops.secrets = {
      "mullvad/account" = { };
      "mullvad/device" = { };
      "mullvad/privateKey" = { };
      "mullvad/server" = { };
      "mullvad/socksAddr" = { };
    };

    environment.systemPackages = [ pkgs.wireproxy ];

    systemd.services.mullvad-proxy = {
      description = "Mullvad Proxy";
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      wantedBy = [ "multi-user.target" ];

      path = [
        pkgs.curl
        pkgs.jq
      ];

      script = ''
        set -e
        PRIVATEKEY="$(cat $CREDENTIALS_DIRECTORY/mullvad-privateKey)"
        PUBLICKEY="$(cat $CREDENTIALS_DIRECTORY/mullvad-privateKey | ${pkgs.wireguard-tools}/bin/wg pubkey)"
        SERVER="$(cat "$CREDENTIALS_DIRECTORY/mullvad-server")"
        DEVICE="$(cat "$CREDENTIALS_DIRECTORY/mullvad-device")"
        ACCOUNT="$(cat "$CREDENTIALS_DIRECTORY/mullvad-account")"
        SOCKSADDR="$(cat "$CREDENTIALS_DIRECTORY/mullvad-socksAddr")"

        echo "[+] VPN proxy script started."

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
        IFS=, read -r IPV4_ENDPOINT IPV6_ENDPOINT <<< $ENDPOINT

        echo "[+] Starting proxy on $SOCKSADDR to Mullvad server $SERVER as $DEVICE ($PUBLICKEY)"

        exec ${pkgs.wireproxy}/bin/wireproxy -c /dev/stdin --silent <<EOF
        [Interface]
        Address = $IPV4_ENDPOINT
        MTU = 1420
        PrivateKey = $PRIVATEKEY
        DNS = 10.64.0.1

        [Peer]
        PublicKey = $SERVER_PUBLICKEY
        Endpoint = $SERVER_ENDPOINT_IPV4

        [Socks5]
        BindAddress = $SOCKSADDR
        EOF
      '';

      startLimitIntervalSec = 200;
      startLimitBurst = 5;

      serviceConfig = {
        DynamicUser = true;
        RestartSec = 30;
        Restart = "always";
        LoadCredential = [
          "mullvad-account:${config.sops.secrets."mullvad/account".path}"
          "mullvad-device:${config.sops.secrets."mullvad/device".path}"
          "mullvad-privateKey:${config.sops.secrets."mullvad/privateKey".path}"
          "mullvad-server:${config.sops.secrets."mullvad/server".path}"
          "mullvad-socksAddr:${config.sops.secrets."mullvad/socksAddr".path}"
        ];
      };
    };
  };
}
