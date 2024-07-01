{ pkgs, ... }:
{
  config = {
    environment.systemPackages = [
      (pkgs.ghidra.withExtensions (_: [
        #pkgs.ghidra-extensions.ghidra-delinker-extension
      ]))
    ];

    nixpkgs.overlays = [
      (final: prev: {
        ghidra-extensions = prev.ghidra-extensions.overrideScope (
          finalScope: prevScope: {
            ghidra-delinker-extension =
              let
                pname = "ghidra-delinker-extension";
                version = "0.4.0";
                src = final.fetchFromGitHub {
                  owner = "boricj";
                  repo = "ghidra-delinker-extension";
                  rev = "04338fd028bf8b5449ff3f5373635111140bbeda";
                  hash = "sha256-wBmF8ksxMrxUR1QEaqRZB6HN09ZnwNiqJ5bMz0tCS6Y=";
                  # TODO: need to fix this
                  deepClone = true;
                };

                addResolveStep = ''
                  cat >>build.gradle <<HERE
                  task resolveDependencies {
                    doLast {
                      project.rootProject.allprojects.each { subProject ->
                        subProject.buildscript.configurations.each { configuration ->
                          resolveConfiguration(subProject, configuration, "buildscript config \''${configuration.name}")
                        }
                        subProject.configurations.each { configuration ->
                          resolveConfiguration(subProject, configuration, "config \''${configuration.name}")
                        }
                      }
                    }
                  }
                  void resolveConfiguration(subProject, configuration, name) {
                    if (configuration.canBeResolved) {
                      logger.info("Resolving project {} {}", subProject.name, name)
                      configuration.resolve()
                    }
                  }
                  HERE
                '';
                deps = finalScope.buildGhidraExtension {
                  pname = "${pname}-deps";
                  inherit version src;

                  postPatch = addResolveStep;

                  nativeBuildInputs = [
                    final.gradle
                    final.perl
                    final.git
                  ] ++ final.lib.optional final.stdenv.isDarwin final.xcbuild;
                  buildPhase = ''
                    runHook preBuild
                    export HOME="$NIX_BUILD_TOP/home"
                    mkdir -p "$HOME"
                    export JAVA_TOOL_OPTIONS="-Duser.home='$HOME'"
                    export GRADLE_USER_HOME="$HOME/.gradle"
                    gradle --no-daemon --info -Dorg.gradle.java.home=${final.openjdk17} -PGHIDRA_INSTALL_DIR=${final.ghidra}/lib/ghidra resolveDependencies
                    runHook postBuild
                  '';
                  installPhase = ''
                    runHook preInstall
                    find $GRADLE_USER_HOME/caches/modules-2 -type f -regex '.*\.\(jar\|pom\)' \
                      | perl -pe 's#(.*/([^/]+)/([^/]+)/([^/]+)/[0-9a-f]{30,40}/([^/\s]+))$# ($x = $2) =~ tr|\.|/|; "install -Dm444 $1 \$out/maven/$x/$3/$4/$5" #e' \
                      | sh
                    runHook postInstall
                  '';
                  outputHashAlgo = "sha256";
                  outputHashMode = "recursive";
                  outputHash = "sha256-ZiJs0Daby6aT2S1WAgi9nh+IzGz2JTR+XFRH21rk2+4=";
                };
              in
              finalScope.buildGhidraExtension {
                inherit src version pname;
                buildPhase = ''
                  runHook preBuild
                  export HOME="$NIX_BUILD_TOP/home"
                  mkdir -p "$HOME"
                  export JAVA_TOOL_OPTIONS="-Duser.home='$HOME'"
                  sed -i "s#mavenLocal()#mavenLocal(); maven { url '${deps}/maven' }#g" build.gradle
                  echo "pluginManagement { repositories { maven { url '${deps}/maven' }; mavenLocal(); } }" >> settings.gradle
                  gradle --offline --no-daemon -PGHIDRA_INSTALL_DIR=${final.ghidra}/lib/ghidra
                  runHook postBuild
                '';
              };
          }
        );

        ghidra =
          let
            pname = "ghidra";
            version = "11.1.1";
            patches = prev.ghidra.patches;
            src = final.fetchFromGitHub {
              owner = "NationalSecurityAgency";
              repo = "Ghidra";
              rev = "Ghidra_${version}_build";
              hash = "sha256-t96FcAK3JwO66dOf4OhpOfU8CQfAczfF61Cg7m+B3fA=";
              leaveDotGit = true;
              postFetch = ''
                cd "$out"
                git rev-parse HEAD > $out/COMMIT
                date -u -d "@$(git log -1 --pretty=%ct)" "+%Y-%b-%d" > $out/SOURCE_DATE_EPOCH
                date -u -d "@$(git log -1 --pretty=%ct)" "+%Y%m%d" > $out/SOURCE_DATE_EPOCH_SHORT
                find "$out" -name .git -print0 | xargs -0 rm -rf
              '';
            };
            deps = final.stdenv.mkDerivation {
              pname = "${pname}-deps";
              inherit version src patches;

              postPatch = ''
                cat >>build.gradle <<HERE
                task resolveDependencies {
                  doLast {
                    project.rootProject.allprojects.each { subProject ->
                      subProject.buildscript.configurations.each { configuration ->
                        resolveConfiguration(subProject, configuration, "buildscript config \''${configuration.name}")
                      }
                      subProject.configurations.each { configuration ->
                        resolveConfiguration(subProject, configuration, "config \''${configuration.name}")
                      }
                    }
                  }
                }
                void resolveConfiguration(subProject, configuration, name) {
                  if (configuration.canBeResolved) {
                    logger.info("Resolving project {} {}", subProject.name, name)
                    configuration.resolve()
                  }
                }
                HERE
              '';
              nativeBuildInputs = [
                final.gradle
                final.perl
              ] ++ final.lib.optional final.stdenv.isDarwin final.xcbuild;
              buildPhase = ''
                runHook preBuild
                export HOME="$NIX_BUILD_TOP/home"
                mkdir -p "$HOME"
                export JAVA_TOOL_OPTIONS="-Duser.home='$HOME'"
                export GRADLE_USER_HOME="$HOME/.gradle"
                gradle --no-daemon --info -Dorg.gradle.java.home=${final.openjdk17} -I gradle/support/fetchDependencies.gradle init
                gradle --no-daemon --info -Dorg.gradle.java.home=${final.openjdk17} resolveDependencies
                runHook postBuild
              '';
              installPhase = ''
                runHook preInstall
                find $GRADLE_USER_HOME/caches/modules-2 -type f -regex '.*\.\(jar\|pom\)' \
                  | perl -pe 's#(.*/([^/]+)/([^/]+)/([^/]+)/[0-9a-f]{30,40}/([^/\s]+))$# ($x = $2) =~ tr|\.|/|; "install -Dm444 $1 \$out/maven/$x/$3/$4/$5" #e' \
                  | sh
                cp -r dependencies $out/dependencies
                runHook postInstall
              '';
              outputHashAlgo = "sha256";
              outputHashMode = "recursive";
              outputHash = "sha256-66gL4UFlBUo2JIEOXoF6tFvXtBdEX4b2MeSrV1b6Vg4=";
            };
          in
          prev.ghidra.overrideAttrs (
            finalAttrs: prevAttrs: {
              inherit version src;
              patchFlags = [
                "--no-backup-if-mismatch"
                "-p1"
              ];
              buildPhase = ''
                runHook preBuild
                export HOME="$NIX_BUILD_TOP/home"
                mkdir -p "$HOME"
                export JAVA_TOOL_OPTIONS="-Duser.home='$HOME'"
                ln -s ${deps}/dependencies dependencies
                sed -i "s#mavenLocal()#mavenLocal(); maven { url '${deps}/maven' }#g" build.gradle
                gradle --offline --no-daemon --info -Dorg.gradle.java.home=${final.openjdk17} buildGhidra
                runHook postBuild
              '';
              nativeBuildInputs = (prevAttrs.nativeBuildInputs or [ ]) ++ [
                final.python3
                final.python3Packages.pip
              ];
            }
          );
      })
    ];
  };
}
