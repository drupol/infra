{
  config,
  inputs,
  ...
}:
{
  flake.modules.nixosConfigurations.rpi4 = {
    imports =
      with config.flake.modules.nixos;
      [
        # Modules
        base
        bluetooth
        facter
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

    boot.loader.grub.enable = false;
    boot.loader.generic-extlinux-compatible.enable = true;

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
