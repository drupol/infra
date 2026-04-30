{
  den.aspects.tools.provides.nix-trusted-user = {
    nixos =
      { user, ... }:
      {
        nix.settings.trusted-users = [ user.userName ];
      };
  };
}
