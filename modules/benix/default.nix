{
  config,
  ...
}:
{
  flake = {
    meta.users = {
      benix = {
        name = "Benix User Group";
        email = "demo@example.com";
        key = "";
        username = "benix";
        keygrip = [
        ];
        authorizedKeys = [
        ];
      };
    };

    modules.nixos.benix =
      { pkgs, ... }:
      {
        programs.fish.enable = true;

        users.users.benix = {
          description = "Benix User Group";
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
          initialPassword = "benix";
        };

        nix.settings.trusted-users = [ config.flake.meta.users.user.username ];
      };

    modules.homeManager.benix =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          cowsay
        ];
      };
  };
}
