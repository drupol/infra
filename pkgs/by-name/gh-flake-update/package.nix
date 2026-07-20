{
  lib,
  bashly,
  dix,
  gh,
  gitMinimal,
  makeBinaryWrapper,
  shellcheck,
  stdenvNoCC,
  versionCheckHook,
}:
stdenvNoCC.mkDerivation {
  pname = "gh-flake-update";
  version = "0.0.2";
  src = ./.;

  nativeBuildInputs = [
    bashly
    makeBinaryWrapper
  ];

  buildPhase = ''
    runHook preBuild

    bashly build -q

    runHook postBuild
  '';

  doCheck = true;

  nativeCheckInputs = [
    shellcheck
  ];

  checkPhase = ''
    runHook preCheck

    shellcheck ./gh-flake-update

    runHook postCheck
  '';

  installPhase = ''
    runHook preInstall

    install -Dm755 gh-flake-update -t $out/bin

    wrapProgram $out/bin/gh-flake-update \
      --prefix PATH : ${
        lib.makeBinPath [
          gh
          gitMinimal
          dix
        ]
      }

    runHook postInstall
  '';

  doInstallCheck = true;
  nativeInstallCheckInputs = [ versionCheckHook ];
  versionCheckProgramArg = "--version";

  meta = {
    description = "A tool to update flake inputs using GitHub CLI";
    homepage = "https://github.com/drupol/infra";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ drupol ];
    platforms = lib.platforms.unix;
    mainProgram = "gh-flake-update";
  };
}
