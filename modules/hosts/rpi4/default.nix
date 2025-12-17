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
        # Modules
        base
        bluetooth
        facter
        openssh
        rpi4-sdimage
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
        # Disable U-Boot "Hit any key" prompt. Default bootdelay=2 waits for keypress.
        # -2 skips autoboot delay entirely. Combined with boot.loader.timeout=0
        # for extlinux menu, this gives instant boot on headless systems.
        (final: prev: {
          ubootRaspberryPi4_64bit = prev.ubootRaspberryPi4_64bit.override {
            extraConfig = ''
              CONFIG_BOOTDELAY=-2
            '';
          };
        })
      ];
    };

    boot.loader.timeout = 0;
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
