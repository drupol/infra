{
  den,
  ...
}:
{
  den.aspects.user =
    { config, ... }:
    {
      includes = [
        den.provides.define-user
        den.provides.primary-user
        den.aspects.tools.provides.nix-trusted-user
      ];

      nixos = {
        users.users.user = {
          inherit (config.meta) description;
          createHome = true;

          extraGroups = [
            "audio"
            "input"
            "networkmanager"
            "sound"
            "tty"
          ];

          initialPassword = "id";
          isNormalUser = true;
        };
      };

      meta = {
        authorizedKeys = [
        ];

        description = "user";
        email = "";
        key = ""; # ed25519/0x0AAF2901E8040715

        keygrip = [
        ];

        name = "User";
        username = "user";
      };
    };
}
