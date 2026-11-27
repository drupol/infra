{
  den.aspects.facter = facterReportPath: {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [ nixos-facter ];

        hardware = {
          facter = {
            detected.dhcp.enable = false;
            reportPath = facterReportPath;
          };
        };
      };
  };

}
