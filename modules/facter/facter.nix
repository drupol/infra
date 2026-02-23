{ inputs, ... }:
{
  flake-file.inputs = {
    nixos-facter-modules.url = "github:numtide/nixos-facter-modules";
  };

  den.aspects.facter = facterReportPath: {
    nixos =
      { pkgs, ... }:
      {
        imports = [ inputs.nixos-facter-modules.nixosModules.facter ];
        hardware.facter.detected.dhcp.enable = false;
        environment.systemPackages = with pkgs; [ nixos-facter ];
        hardware.facter.reportPath = facterReportPath;
      };
  };

}
