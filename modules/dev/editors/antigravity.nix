{
  den,
  ...
}:
{
  infra.dev = {
    includes = [
      (den.provides.unfree [ "antigravity-ide" ])
    ];

    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          # Using the FHS version to allow installation of extensions
          # I don't really need Nix to manage extensions for me
          antigravity-ide-fhs
        ];
      };

    nixos = {
      services = {
        gnome.gnome-keyring.enable = true;
      };
    };
  };
}
