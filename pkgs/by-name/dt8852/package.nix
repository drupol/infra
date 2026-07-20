{
  pkg-config,
  rustPlatform,
  udev,
}:

rustPlatform.buildRustPackage (_finalAttrs: {
  pname = "dt8852";
  version = "0.1.0";
  src = ./.;
  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ udev ];
  cargoHash = "sha256-REcG6QtWmf3M3dkvUAC3lUl163P6zW9bHKi9yRH9s2w=";

  meta = {
    mainProgram = "dt8852";
  };
})
