{
  stdenv,
  fetchFromGitHub,
  kernel,
  kmod,
  ...
}:
stdenv.mkDerivation rec {
  name = "gcadapter-oc";
  version = "d537442c5ca5dc02ecbd35791e56e9509653c1f5";
  src = fetchFromGitHub {
    owner = "hannesmann";
    repo = "gcadapter-oc-kmod";
    rev = "${version}";
    sha256 = "uXcbGj9F8N02WMWrgZ5jJpAQXZIRQpKDDYoYvdYGkfs=";
  };
  nativeBuildInputs = [ kmod ] ++ kernel.moduleBuildDependencies;
  installPhase = ''
    install -D "gcadapter_oc.ko" -t "$out/lib/modules/${kernel.modDirVersion}/kernel/extramodules"
  '';
  hardeningDisable = [ ];
  makeFlags = [ "KERNEL_SOURCE_DIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build" ];
}
