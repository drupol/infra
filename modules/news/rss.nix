{
  flake.modules = {
    homeManager.news =
      { pkgs, ... }:
      {
        home.packages = [
          (pkgs.feedr.overrideAttrs (
            finalAttrs: oldAttrs: {
              version = "0.7.0";

              src = oldAttrs.src.override {
                version = "v0.7.0";
                hash = "sha256-5s4QgkUX27WNrTyzyYDQjf4VjKD0Kdkicjf7hlO9OKE=";
              };

              cargoDeps = pkgs.rustPlatform.fetchCargoVendor {
                inherit (finalAttrs) pname src version;
                hash = finalAttrs.cargoHash;
              };

              cargoHash = "sha256-3xSvqj2kW0lOFUzkAbBJThJx6u7f1tSk1qgFdm2tVfg=";

              nativeInstallCheckInputs = oldAttrs.nativeInstallCheckInputs ++ [
                pkgs.writableTmpDirAsHomeHook
              ];
            }
          ))
        ];
      };
  };
}
