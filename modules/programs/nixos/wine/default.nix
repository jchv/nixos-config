{ pkgs, ... }:
{
  config = {
    environment.systemPackages = [
      pkgs.wineWowPackages.full
      pkgs.wineasio
    ];

    environment.variables = {
      # Prevents WINE from creating desktop entries/associations, at the cost of
      # some noise in the logs.
      WINEDLLOVERRIDES = "winemenubuilder.exe=d";
    };
  };
}
