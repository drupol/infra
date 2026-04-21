{
  den,
  ...
}:
{
  den.aspects.dev = {
    includes = [
      (den.provides.unfree [ "antigravity" ])
    ];

    nixos = {
      services = {
        gnome.gnome-keyring.enable = true;
      };
    };

    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          # Using the FHS version to allow installation of extensions
          # I don't really need Nix to manage extensions for me
          antigravity-fhs
        ];
      };
  };
}
