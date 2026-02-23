{
  inputs,
  ...
}:
{
  den.aspects.lora = {
    nixos =
      { pkgs, ... }:
      {
        nixpkgs.overlays = [
          inputs.self.overlays.default
        ];

        environment.systemPackages = [ pkgs.local.meshtastic-client ];
      };
  };
}
