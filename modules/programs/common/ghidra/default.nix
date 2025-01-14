{ pkgs, ... }:
{
  config = {
    environment.systemPackages = [
      (pkgs.ghidra.withExtensions (_: [
        pkgs.ghidra-extensions.ghidra-delinker-extension
      ]))
    ];
  };
}
