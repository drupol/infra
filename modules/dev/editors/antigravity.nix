{
  den,
  ...
}:
{
  den.aspects.dev = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          # Using the FHS version to allow installation of extensions
          # I don't really need Nix to manage extensions for me
          antigravity-ide-fhs
        ];
      };

    includes = [
      (den.provides.unfree [ "antigravity-ide" ])
    ];

    nixos = {
      services = {
        gnome.gnome-keyring.enable = true;
      };
    };
  };
}
