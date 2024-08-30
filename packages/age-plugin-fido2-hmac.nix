{
  lib,
  buildGoModule,
  fetchFromGitHub,
  libfido2,
}:

let
  version = "0.2.3";
in
buildGoModule {
  pname = "age-plugin-fido2-hmac";
  inherit version;

  src = fetchFromGitHub {
    owner = "olastor";
    repo = "age-plugin-fido2-hmac";
    rev = "v${version}";
    hash = "sha256-P2gNOZeuODWEb/puFe6EA1wW3pc0xgM567qe4FKbFXg=";
  };

  vendorHash = "sha256-h4/tyq9oZt41IfRJmmsLHUpJiPJ7YuFu59ccM7jHsFo=";

  buildInputs = [ libfido2 ];

  meta = with lib; {
    description = "FIDO2 plugin for age";
    mainProgram = "age-plugin-fido2-hmac";
    homepage = "https://github.com/olastor/age-plugin-fido2-hmac";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = with maintainers; [ jchw ];
  };
}
