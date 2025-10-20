toplevel@{
  lib,
  ...
}:
{
  unify.hosts.nixos.xeonixos = {
    users.pol.modules = toplevel.config.unify.hosts.nixos.xeonixos.modules;

    modules = with toplevel.config.unify.modules; [
      base
      desktop
      dev
      facter
      guacamole
      openssh
      pol
      shell
      vpn
    ];

    tags = [
      "base"
      "desktop"
      "dev"
      "facter"
      "guacamole"
      "openssh"
      "shell"
    ];

    fqdn = "xeonixos.netbird.cloud";

    nixos =
      { pkgs, config, ... }:
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

        facter.reportPath = ./facter.json;

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
        nixpkgs.config.allowUnfree = true;
      };
  };

}
