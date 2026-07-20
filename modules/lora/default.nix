{
  inputs,
  ...
}:
{
  den.aspects.lora = {
    homeManager =
      { pkgs, ... }:
      {
        # TODO: How to use `config.packages.meshtastic-client` instead of `pkgs.local.meshtastic-client`?
        home.packages = [ pkgs.local.meshtastic-client ];

        nixpkgs.overlays = [
          inputs.self.overlays.default
        ];
      };
  };
}
