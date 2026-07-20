{ modulesPath, ... }:
{
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
}
