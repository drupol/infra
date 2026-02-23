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

      meta = {
        description = "user";
        email = "";
        name = "User";
        username = "user";
        key = ""; # ed25519/0x0AAF2901E8040715
        keygrip = [
        ];
        authorizedKeys = [
        ];
      };

      nixos = {
        users.users.user = {
          inherit (config.meta) description;
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
