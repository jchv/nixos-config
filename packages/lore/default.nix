{
  lib,
  rustPlatform,
  fetchFromGitHub,
  installShellFiles,
  versionCheckHook,
  nix-update-script,
  stdenv,
  nixosTests,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "lore";
  version = "0.8.3";

  src = fetchFromGitHub {
    owner = "EpicGames";
    repo = "lore";
    tag = "v${finalAttrs.version}";
    hash = "sha256-PY7lcRbsxkDiuTpO7tjfXlgb789qxFAKXNXFJ+Nbdj4=";
  };

  __structuredAttrs = true;

  cargoHash = "sha256-yapx4fEvljFlCpazOubTY2t/+pa7U9g60ZQ5mRMazIc=";

  nativeBuildInputs = [
    rustPlatform.bindgenHook
    installShellFiles
  ];

  cargoBuildFlags = [
    "--package=lore-client"
    "--package=lore-server"
  ];

  # This is a workaround; otherwise, these two --cfg flags get lost due to
  # cargoSetupHook's rustflags logic.
  env.RUSTFLAGS = "--cfg tokio_unstable --cfg uuid_unstable -Cforce-frame-pointers=yes";

  # TODO: The tests seem to require some external setup to work.
  doCheck = false;

  nativeInstallCheckInputs = [ versionCheckHook ];
  doInstallCheck = true;
  versionCheckProgramArg = "--version";

  postInstall = lib.optionalString (stdenv.buildPlatform.canExecute stdenv.hostPlatform) ''
    for shell in bash zsh fish; do
      "$out/bin/lore" completions "$shell" > "lore.$shell"
    done

    installShellCompletion --cmd lore \
      --bash lore.bash \
      --zsh lore.zsh \
      --fish lore.fish
  '';

  passthru = {
    updateScript = nix-update-script { };
    tests = {
      server-test = nixosTests.loreserver;
    };
  };

  meta = {
    description = "Next-generation open source version control system";
    longDescription = ''
      Lore is a centralized, content-addressed version control system created
      by Epic Games, optimized for projects that combine code with large
      binary assets, including games and entertainment.
    '';
    homepage = "https://lore.org/";
    changelog = "https://github.com/EpicGames/lore/releases/tag/v${finalAttrs.version}";
    license = lib.licenses.mit;
    sourceProvenance = [ lib.sourceTypes.fromSource ];
    maintainers = [ lib.maintainers.jchw ];
    mainProgram = "lore";
    platforms = lib.platforms.unix;
  };
})
