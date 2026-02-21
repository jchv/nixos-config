{
  ghidra,
  ant,
  fetchFromGitHub,
  gradle,
  lib,
}:
ghidra.buildGhidraExtension (finalAttrs: {
  pname = "ghidra-gamecube-loader";
  version = "0-unstable";

  src = fetchFromGitHub {
    owner = "Cuyler36";
    repo = "Ghidra-GameCube-Loader";
    rev = "c61f08fdddfb655f2f1fd39dc53d8220530c8b52";
    hash = "sha256-w/onDdTSl6MidJL56e6sozOS9OsVwBhfCm3N1uGLmGQ=";
  };

  nativeBuildInputs = [ ant ];

  postPatch = ''
    substituteInPlace build.gradle \
      --replace-fail \
        '-''${getGitHash()}' \
        '-${builtins.substring 0 8 finalAttrs.src.rev}'
    substituteInPlace data/buildLanguage.xml \
        --replace-fail \
        'file="../.antProperties.xml" optional="false"' \
        'file="../.antProperties.xml" optional="true"'
  '';

  configurePhase = ''
    runHook preConfigure

    pushd data
    touch sleighArgs.txt
    ant -f buildLanguage.xml -Dghidra.install.dir=${ghidra}/lib/ghidra sleighCompile
    popd

    runHook postConfigure
  '';

  mitmCache = gradle.fetchDeps {
    pkg = finalAttrs.finalPackage;
    data = ./deps.json;
  };

  meta = {
    description = "A Nintendo GameCube binary loader for Ghidra";
    homepage = "https://github.com/Cuyler36/Ghidra-GameCube-Loader";
    downloadPage = "https://github.com/Cuyler36/Ghidra-GameCube-Loader/releases/tag/${finalAttrs.version}";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ jchw ];
  };
})
