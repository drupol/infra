{ lib, ... }:
{
  unify.modules.rpi4-sdimage.nixos =
    { modulesPath, ... }:
    {
      # Build with `nix-build -A nixosConfigurations.rpi4.config.system.build.sdImage`
      imports = [
        "${modulesPath}/installer/sd-card/sd-image-aarch64.nix"
      ];

      sdImage = {
        # Do not compress the image to save time
        compressImage = false;
      };

      boot.supportedFilesystems = {
        # I don't need them
        zfs = lib.mkForce false;
        cifs = lib.mkForce false;
      };
    };
}
