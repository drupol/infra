{ lib, ... }:
{
  den.aspects.base.nixos = {
    powerManagement = {
      enable = true;
      cpuFreqGovernor = lib.mkDefault "powersave";
    };
  };
}
