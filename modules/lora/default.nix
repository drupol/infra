{
  inputs,
  ...
}:
{
  flake.modules = {
    nixos.lora =
      { pkgs, ... }:
      {
        nixpkgs.overlays = [
          inputs.self.overlays.default
        ];

        environment.systemPackages = [ pkgs.local.meshtastic-client ];
      };
  };
}
