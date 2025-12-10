{
  config,
  inputs,
  ...
}:
{
  flake.modules.nixos."hosts/rpi4" = {
    imports =
      with config.flake.modules.nixos;
      [
        inputs.disko.nixosModules.disko

        # Modules
        base
        bluetooth
        desktop
        displaylink
        dev
        education
        facter
        fwupd
        games
        shell
        sound
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
              email
              messaging
              pol
              games
              shell
              work
            ];
          };
        }
      ];

    nixpkgs = {
      overlays = [
        (final: _prev: {
          master = import inputs.nixpkgs-master {
            inherit (final) config system;
          };
        })
      ];
    };

    boot = {
      plymouth.enable = true;

      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };

      kernelModules = [ "kvm-intel" ];

      kernelParams = [
        "quiet"
        "splash"
      ];
    };

    fileSystems = {
      "/" = {
        device = "/dev/disk/by-label/NIXOS_SD";
        fsType = "ext4";
        options = [ "noatime" ];
      };
      "/var/log" = {
        device = "none";
        fsType = "tmpfs";
        options = [
          "defaults"
          "size=2G"
          "nosuid"
          "noatime"
        ];
      };
      "/tmp" = {
        device = "none";
        fsType = "tmpfs";
        options = [
          "defaults"
          "size=1G"
          "nosuid"
          "noatime"
        ];
      };
    };
  };
}
