{
  config = {
    services.samba = {
      enable = true;
      nsswins = true;
      winbindd.enable = true;
      nmbd.enable = true;
      settings = {
        global = {
          "workgroup" = "WORKGROUP";
          "map to guest" = "bad user";
          "guest account" = "nobody";
          "case sensitive" = false;
          "client min protocol" = "LANMAN1";
        };
        homes = {
          "comment" = "Home directory";
          "browseable" = "yes";
          "valid users" = "%S";
          "writable" = "yes";
        };
      };
    };
  };
}
