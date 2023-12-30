# nixos-config
This is my NixOS desktop configuration repositories. It stores my configurations
for my desktop machines. The actual `/etc/nixos` directory is populated with a
small proxy flake that includes this one, overrides Nixpkgs and returns these
outputs. This exists so that unattended Nixpkgs upgrades are still possible
without giving effective root access to the user and without requiring text
editors to need root access to edit the nixos-config.

## SOPS setup
Add root config for SOPS:

```shell
mkdir -p ~/.config/sops/age && nix run nixpkgs#ssh-to-age -- -private-key -i /etc/ssh/ssh_host_ed25519_key -o /root/.config/sops/age/keys.txt
```

Add recipient to SOPS:

```shell
nix shell nixpkgs#ssh-to-age -c bash -c 'cat /etc/ssh/ssh_host_ed25519_key.pub | ssh-to-age'
```
