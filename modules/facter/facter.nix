{ inputs, ... }:
{
  unify.modules.facter.nixos =
    { pkgs, ... }:
    {
      imports = [ inputs.nixos-facter-modules.nixosModules.facter ];
      facter.detected.dhcp.enable = false;
      environment.systemPackages = with pkgs; [ nixos-facter ];
    };

}
