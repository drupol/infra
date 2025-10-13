{ inputs, ... }:
{
  flake.modules.nixos."hosts/x1c" =
    { pkgs, lib, ... }:
    {
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
        kernelPackages = lib.mkForce pkgs.master.linuxPackages_latest;
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
    };
}
