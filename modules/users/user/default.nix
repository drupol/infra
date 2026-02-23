{
  config,
  den,
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
  };

  den.aspects.user = {
    includes = [
      den.provides.primary-user
      den.aspects.tools.provides.nix-trusted-user
    ];

    nixos = {
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
        initialPassword = "id";
      };
    };
  };
}
