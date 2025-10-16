{
  config,
  ...
}:
{
  flake = {
    meta.users = {
      user = {
        name = "Utilisateur";
        key = "";
        username = "user";
        keygrip = [
        ];
        authorizedKeys = [
        ];
      };
    };

    modules.nixos.user =
      { pkgs, ... }:
      {
        programs.fish.enable = true;

        users.users.user = {
          description = config.flake.meta.users.user.name;
          isNormalUser = true;
          createHome = true;
          extraGroups = [
            "audio"
            "input"
            "networkmanager"
            "sound"
            "tty"
          ];
          shell = pkgs.fish;
          initialPassword = "id";
        };

        nix.settings.trusted-users = [ config.flake.meta.users.user.username ];
      };
  };
}
