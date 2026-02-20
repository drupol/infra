{
  inputs,
  ...
}:
{
  unify.modules.messaging.home =
    { pkgs, ... }:
    {
      nixpkgs.overlays = [
        inputs.self.overlays.default
      ];

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
    };
}
