{
  config,
  lib,
  modulesPath,
  ...
}:
{
  boot.extraModulePackages = [ ];
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ehci_pci"
    "ahci"
    "usb_storage"
    "sd_mod"
    "rtsx_pci_sdmmc"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/0831c17a-27d6-42b8-a61b-f52cfb02f051";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/5185-45FD";
    fsType = "vfat";
  };
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
  swapDevices = [ { device = "/dev/disk/by-uuid/066ce479-3611-42e7-9117-f1ef77668010"; } ];
}
