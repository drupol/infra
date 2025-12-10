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
