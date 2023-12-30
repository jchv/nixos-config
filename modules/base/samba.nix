{
  config = {
    services.samba = {
      enable = true;
      nsswins = true;
      enableWinbindd = true;
      enableNmbd = true;
      extraConfig = ''
        workgroup = WORKGROUP
        map to guest = bad user
        guest account = nobody
        case sensitive = False

        ; Insecure, but very useful for old OSes.
        ; SMB should only be used over trusted links.
        client min protocol = LANMAN1
      '';
      shares.homes = {
        comment = "Home directory";
        browseable = "yes";
        "valid users" = "%S";
        writable = "yes";
      };
    };
  };
}
