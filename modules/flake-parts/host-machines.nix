{
  inputs,
  lib,
  config,
  ...
}:
{
  flake.nixosConfigurations = lib.pipe config.flake.modules.nixosConfigurations [
    (lib.mapAttrs (
      name: module:
      let
        specialArgs = {
          inherit inputs;
          hostConfig = module // {
            inherit name;
          };
        };
      in
      lib.nixosSystem {
        inherit specialArgs;
        modules = [
          module
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = specialArgs;
          }
        ];
      }
    ))
  ];
}
