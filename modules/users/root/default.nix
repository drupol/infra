{
  den,
  ...
}:
{
  den.aspects.root =
    { config, ... }:
    {
      includes = [
        den.aspects.tools.provides.nix-trusted-user
      ];

      meta = {
        email = "pol.dellaiera@protonmail.com";
        fullname = "Root";
        username = "root";
        inherit (den.aspects.pol.meta) key keygrip authorizedKeys;
      };

      user = {
        initialPassword = "id";
        openssh.authorizedKeys.keys = config.meta.authorizedKeys;
      };
    };
}
