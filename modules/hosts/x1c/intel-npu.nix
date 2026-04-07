{
  ...
}:
{
  # Todo: revisit when https://github.com/NixOS/nixpkgs/pull/507423
  # has landed in unstable
  flake.modules.nixos.npu =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.intel-npu-driver.validation
        pkgs.level-zero
      ];

      hardware = {
        firmware = [ pkgs.intel-npu-driver.firmware ];
        graphics = {
          enable = true;
          extraPackages = [ pkgs.intel-npu-driver ];
        };
      };
    };
}
