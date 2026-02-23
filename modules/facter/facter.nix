{ inputs, ... }:
{
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
