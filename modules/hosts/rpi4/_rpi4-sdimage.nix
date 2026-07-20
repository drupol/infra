{ lib, ... }:
{
  flake.modules.nixos.rpi4-sdimage =
    { modulesPath, ... }:
    {
      # Build with `nix-build -A nixosConfigurations.rpi4.config.system.build.sdImage`
      imports = [
        "${modulesPath}/installer/sd-card/sd-image-aarch64.nix"
      ];

      boot.supportedFilesystems = {
        cifs = lib.mkForce false;
        # I don't need them
        zfs = lib.mkForce false;
      };

      sdImage = {
        # Do not compress the image to save time
        compressImage = false;
      };
    };
}
