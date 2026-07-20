{
  inputs,
  ...
}:
{
  den.aspects.messaging = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [
          pkgs.local.chromium-discord
          pkgs.local.chromium-element
          pkgs.local.chromium-ec-element
          pkgs.local.chromium-ec-teams
          pkgs.local.chromium-meet
          pkgs.local.chromium-protonmail
          pkgs.local.chromium-umons-teams
          pkgs.signal-desktop
        ];

        nixpkgs.overlays = [
          inputs.self.overlays.default
        ];
      };
  };
}
