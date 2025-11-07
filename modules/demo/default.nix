{
  config,
  ...
}:
{
  flake = {
    meta.users = {
      demo = {
        name = "Demo User";
        email = "demo@example.com";
        key = "";
        username = "demo";
        keygrip = [
        ];
        authorizedKeys = [
        ];
      };
    };

    modules.nixos.demo =
      { pkgs, ... }:
      {
        programs.fish.enable = true;

        users.users.demo = {
          description = "Nix Demo User";
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
          initialPassword = "demo";
        };

        nix.settings.trusted-users = [ config.flake.meta.users.user.username ];
      };

    modules.homeManager.demo =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          cowsay
        ];
      };
  };
}
