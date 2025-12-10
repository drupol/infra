{
  inputs,
  ...
}:
{
  flake.modules = {
    homeManager.messaging =
      { pkgs, ... }:
      {

        nixpkgs.overlays = [
          inputs.nix-webapps.overlays.lib
        ];

        home.packages = [
          # TODO: restore pkgs-by-name-for-flake-parts module and use it here.
          (pkgs.callPackage ./../../pkgs/by-name/chromium-discord/package.nix { })
          (pkgs.callPackage ./../../pkgs/by-name/chromium-element/package.nix { })
          (pkgs.callPackage ./../../pkgs/by-name/chromium-ec-element/package.nix { })
          (pkgs.callPackage ./../../pkgs/by-name/chromium-ec-teams/package.nix { })
          (pkgs.callPackage ./../../pkgs/by-name/chromium-meet/package.nix { })
          (pkgs.callPackage ./../../pkgs/by-name/chromium-protonmail/package.nix { })
          (pkgs.callPackage ./../../pkgs/by-name/chromium-umons-teams/package.nix { })
          pkgs.signal-desktop
        ];
      };

  };
}
