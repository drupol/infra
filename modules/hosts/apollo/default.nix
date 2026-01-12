{
  config,
  ...
}:
{
  flake.modules.nixos."hosts/apollo" =
    { lib, pkgs, ... }:
    {
      imports =
        with config.flake.modules.nixos;
        [
          # Modules
          base
          desktop
          dev
          facter
          guacamole
          noise-station-server
          openssh
          searx
          shell
          tika
          vpn

          # Users
          root
          pol
        ]
        # Specific Home-Manager modules
        ++ [
          {
            home-manager.users.pol = {
              imports = with config.flake.modules.homeManager; [
                base
                desktop
                dev
                shell
              ];

              home.packages = with pkgs; [
                thunderbird
              ];
            };
          }
        ];

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
}
