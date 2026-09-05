{
  lib,
  inputs,
  ...
}:
{
  infra.base = {
    nixos = {
      nix = {
        # See https://discourse.nixos.org/t/24-05-add-flake-to-nix-path/46310/9
        # See https://hachyderm.io/@leftpaddotpy/112539055867932912
        channel.enable = false;

        nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") (
          lib.filterAttrs (_: lib.isType "flake") inputs
        );

        optimise.automatic = true;

        registry = {
          nixpkgs.flake = inputs.nixpkgs;
        };

        settings = {
          auto-optimise-store = true;
          # From https://jackson.dev/post/nix-reasonable-defaults/
          connect-timeout = 5;

          experimental-features = [
            "nix-command"
            "flakes"
          ];

          fallback = true;
          log-lines = 50;
          max-free = 1000000000;
          min-free = 128000000;
          tarball-ttl = 60 * 60 * 24;

          trusted-users = [
            "root"
            "@wheel"
          ];

          use-xdg-base-directories = true;
          warn-dirty = false;
        };
      };
    };
  };
}
