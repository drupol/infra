{
  unify.modules.benix = {

    nixos = {
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
        initialPassword = "benix";
      };

      nix.settings.trusted-users = [ "benix" ];
    };

    home =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          cowsay
        ];
      };
  };
}
