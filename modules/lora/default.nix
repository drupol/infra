{
  inputs,
  ...
}:
{
  flake.modules = {
    homeManager.lora =
      { pkgs, ... }:
      {
        nixpkgs.overlays = [
          inputs.self.overlays.default
        ];

        home.packages = [ pkgs.local.meshtastic-client ];
      };
  };
}
