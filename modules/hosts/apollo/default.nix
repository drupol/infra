{
  config,
  ...
}:
{
  unify.hosts.nixos.apollo = {
    users.pol.modules = config.unify.hosts.nixos.apollo.modules;

    modules = with config.unify.modules; [
      base
      ai
      dev
      docling
      facter
      guacamole
      openssh
      searx
      shell
      tika
      vpn

      # Users
      pol
    ];

    tags = [
      "base"
      "ai"
      "dev"
      "facter"
      "guacamole"
      "openssh"
      "shell"
      "thunderbird"
    ];

    nixos =
      { lib, ... }:
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
      };

    home = {

    };

    fqdn = "apollo.netbird.cloud";
  };
}
