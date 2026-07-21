{ lib, ... }:
{
  den.aspects.base = {
    nixos = {
      powerManagement = {
        cpuFreqGovernor = lib.mkDefault "powersave";
        enable = true;
      };
    };
  };
}
