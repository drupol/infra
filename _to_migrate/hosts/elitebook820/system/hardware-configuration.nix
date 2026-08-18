{
  config,
  lib,
  modulesPath,
  ...
}:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    extraModulePackages = [ ];

    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ehci_pci"
        "ahci"
        "usb_storage"
        "sd_mod"
        "rtsx_pci_sdmmc"
      ];

      kernelModules = [ ];
    };

    kernelModules = [ "kvm-intel" ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/0831c17a-27d6-42b8-a61b-f52cfb02f051";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/5185-45FD";
      fsType = "vfat";
    };
  };

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  swapDevices = [ { device = "/dev/disk/by-uuid/066ce479-3611-42e7-9117-f1ef77668010"; } ];
}
