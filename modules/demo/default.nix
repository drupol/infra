{
  config,
  ...
}:
{
  flake = {
    meta.users = {
      user = {
        name = "Demo User";
        key = "";
        username = "demo";
      };
    };

    modules.nixos.demo =
      { pkgs, ... }:
      {
        programs.fish.enable = true;

        users.users.user = {
          description = "Nix Demo User (pw: demo)";
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
        packages = with pkgs; [
          cowsay
        ];
      };
  };
}
