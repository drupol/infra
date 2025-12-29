{ inputs, ... }:
{
  flake.modules.nixos.base =
    { pkgs, ... }:
    {
      nixpkgs.overlays = [
        inputs.trix.overlays.default
      ];

      environment.systemPackages = [ pkgs.trix ];

      nix = {
        # From https://jackson.dev/post/nix-reasonable-defaults/
        extraOptions = ''
          connect-timeout = 5
          log-lines = 50
          min-free = 128000000
          max-free = 1000000000
          fallback = true
        '';
        optimise.automatic = true;

        nixPath = [ "nixpkgs=${pkgs.path}" ];

        settings = {
          trusted-users = [
            "root"
          ];
          auto-optimise-store = true;
          warn-dirty = false;
          tarball-ttl = 60 * 60 * 24;
        };
      };
    };
}
