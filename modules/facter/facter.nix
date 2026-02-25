{ inputs, ... }:
{
  flake.modules = {
    nixos.facter =
      { pkgs, ... }:
      {
        imports = [ inputs.nixos-facter-modules.nixosModules.facter ];
        hardware.facter.detected.dhcp.enable = false;
        environment.systemPackages = with pkgs; [ nixos-facter ];
      };
  };
}
