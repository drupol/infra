{
  config,
  inputs,
  lib,
  ...
}:
{
  flake.modules.nixos."hosts/rpi4" = {
    imports =
      with config.flake.modules.nixos;
      [
        # Modules
        base
        bluetooth
        desktop
        facter
        fwupd
        openssh
        shell
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
              pol
              shell
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
      loader = {
        efi.canTouchEfiVariables = true;
        systemd-boot.enable = true;
        # systemd-boot and this tries to install bootloader, disable this
        generic-extlinux-compatible.enable = lib.mkForce false;
      };
    };

    facter.reportPath = ./facter.json;

    fileSystems = {
      "/" = {
        device = "/dev/disk/by-label/NIXOS_SD";
        fsType = "ext4";
        options = [ "noatime" ];
      };
    };
  };
}
