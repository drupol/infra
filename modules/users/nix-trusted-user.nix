{
  den,
  ...
}:
{
  den.aspects.tools.provides.nix-trusted-user = den.lib.take.atLeast (
    { user, ... }:
    {
      includes = [
        {
          nixos.nix.settings.trusted-users = [ user.userName ];
        }
      ];
    }
  );
}
