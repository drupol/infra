{
  den.aspects.base = {
    nixos = {
      nix = {
        # See https://discourse.nixos.org/t/24-05-add-flake-to-nix-path/46310/9
        # See https://hachyderm.io/@leftpaddotpy/112539055867932912
        channel.enable = false;
        nixPath = [ "nixpkgs=flake:nixpkgs" ];

        optimise.automatic = true;
        settings = {
          use-xdg-base-directories = true;
          trusted-users = [
            "root"
            "@wheel"
          ];
          auto-optimise-store = true;
          experimental-features = [
            "nix-command"
            "flakes"
          ];
          warn-dirty = false;
          tarball-ttl = 60 * 60 * 24;
          # From https://jackson.dev/post/nix-reasonable-defaults/
          connect-timeout = 5;
          log-lines = 50;
          min-free = 128000000;
          max-free = 1000000000;
          fallback = true;
        };
      };
    };
  };
}
