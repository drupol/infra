{ lib, ... }:
{
  infra.base = {
    nixos = {
      powerManagement = {
        cpuFreqGovernor = lib.mkDefault "powersave";
        enable = true;
      };
    };
  };
}
