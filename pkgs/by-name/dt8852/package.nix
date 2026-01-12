{
  rustPlatform,
  pkg-config,
  udev,
}:

rustPlatform.buildRustPackage (_finalAttrs: {
  pname = "dt8852";
  version = "0.1.0";

  src = ./.;

  cargoHash = "sha256-REcG6QtWmf3M3dkvUAC3lUl163P6zW9bHKi9yRH9s2w=";

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ udev ];

  meta = {
    mainProgram = "dt8852";
  };
})
