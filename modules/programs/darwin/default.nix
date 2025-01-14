{
  imports = [
    ../common
  ];

  config = {
    nixpkgs.overlays = [
      (final: prev: {
        # https://github.com/NixOS/nixpkgs/issues/370662
        ghidra = prev.ghidra.overrideAttrs (finalAttrs: previousAttrs: {
          gradleFlags = previousAttrs.gradleFlags ++ [
            "-x" ":Decompiler:linkSleighMac_x86_64Executable"
            "-x" ":Decompiler:linkDecompileMac_x86_64Executable"
          ];
        });
        vvenc = prev.vvenc.overrideAttrs {
          outputs = [ "out" ];
        };
      })
    ];
  };
}
