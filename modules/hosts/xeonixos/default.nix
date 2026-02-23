{
  den,
  lib,
  ...
}:
{
  den.hosts.x86_64-linux.xeonixos.users.pol = { };

  den.aspects.xeonixos = {
    includes = with den.aspects; [
      # Modules
      base
      desktop
      dev
      (facter ./facter.json)
      guacamole
      openssh
      vpn

      # Users
      root
      pol
      (den.provides.unfree [
        "nvidia-x11"
        "nvidia-settings"
      ])
    ];

    nixos =
      { config, pkgs, ... }:
      {

        boot = {
          # Use the GRUB 2 boot loader.
          loader.grub.enable = true;
          loader.grub.device = "/dev/sdb";
          loader.grub.useOSProber = false;

          # boot.loader.grub.efiSupport = true;
          # boot.loader.grub.efiInstallAsRemovable = true;
          # boot.loader.efi.efiSysMountPoint = "/boot/efi";
          kernel = {
            sysctl = {
              "net.ipv4.conf.all.forwarding" = lib.mkForce true;
              "net.ipv6.conf.all.forwarding" = lib.mkForce true;
            };
          };

          initrd.availableKernelModules = [
            "ehci_pci"
            "ahci"
            "xhci_pci"
            "firewire_ohci"
            "usb_storage"
            "usbhid"
            "sd_mod"
          ];

          kernelModules = [ "kvm-intel" ];
        };

        fileSystems."/" = {
          device = "/dev/disk/by-uuid/6fb8e36f-069c-43db-a843-1e345b17ec04";
          fsType = "ext4";
        };

        swapDevices = [
          { device = "/dev/disk/by-uuid/f70058b0-0600-4a7c-a226-37bf10eb307d"; }
        ];

        hardware.nvidia.open = false;
        services.xserver.videoDrivers = [ "nvidia" ];
        hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_390;
        boot.kernelPackages = lib.mkForce pkgs.linuxPackages_6_12;

        nixpkgs.config.nvidia.acceptLicense = true;
      };
  };
}
