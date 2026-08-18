{
  config,
  lib,
  modulesPath,
  inputs,
  ...
}:
{
  imports = [
    inputs.nixos-hardware.nixosModules.apple-macmini-4-1
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];

    initrd = {
      availableKernelModules = [
        "ohci_pci"
        "ehci_pci"
        "ahci"
        "firewire_ohci"
        "usb_storage"
        "usbhid"
        "sd_mod"
        "sr_mod"
        "sdhci_pci"
      ];

      kernelModules = [ ];
    };

    kernelModules = [
      "kvm-intel"
      "wl"
    ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/4b8ff738-fe53-403a-ba16-a851b41b8c78";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/151D-2898";
      fsType = "vfat";
    };
  };

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp4s0f0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp3s0b1.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  swapDevices = [ { device = "/dev/disk/by-uuid/ce60e82c-87ac-47c2-8880-26949434cc3a"; } ];
}
