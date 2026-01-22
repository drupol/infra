{
  rustPlatform,
  pkg-config,
}:

rustPlatform.buildRustPackage (_finalAttrs: {
  pname = "temper";
  version = "0.1.0";

  src = ./.;

  cargoHash = "sha256-wzftQrQnTxD3n3fXTrOf+17fxUo4m+Zy7OF0nt2woCw=";

  nativeBuildInputs = [ pkg-config ];

  meta = {
    mainProgram = "temper";
  };
})
