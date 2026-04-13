{ inputs, ... }:
{
  flake-file.inputs = {
    nixos-facter-modules.url = "github:numtide/nixos-facter-modules";
  };

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
