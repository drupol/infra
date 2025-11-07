{ inputs, ... }:
{
  flake.modules = {
    nixos.facter =
      { pkgs, ... }:
      {
        imports = [ inputs.nixos-facter-modules.nixosModules.facter ];
        facter.detected.dhcp.enable = false;

        environment.systemPackages = [
          pkgs.nixos-facter
        ];
      };
  };
}
