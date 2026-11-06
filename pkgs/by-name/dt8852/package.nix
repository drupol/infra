{
  lib,
  rustPlatform,
  fetchFromGitHub,
  versionCheckHook,
  pkg-config,
  udev,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "dt8852";
  version = "0.9.2";

  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "drupol";
    repo = "dt8852";
    tag = finalAttrs.version;
    hash = "sha256-MjV1otIOQa5r6/JRaV+wdxFgP9zbcCjqqAW5vowN82U=";
  };

  cargoHash = "sha256-9ZnNDXlkWvi06Q/HtV/mFq4posHu5ALOnZHYboh4GTo=";

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ udev ];

  doInstallCheck = true;
  nativeInstallCheckInputs = [ versionCheckHook ];

  meta = {
    description = "A driver and command-line tool for the CEM DT-8852 sound level meter";
    homepage = "https://github.com/drupol/dt8852";
    license = lib.licenses.mit;
    mainProgram = "dt8852";
    maintainers = with lib.maintainers; [ drupol ];
    platforms = lib.platforms.all;
  };
})
