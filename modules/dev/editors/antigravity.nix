{
  unify.modules.dev = {
    nixos = {
      services = {
        gnome.gnome-keyring.enable = true;
      };
    };

    home =
      { pkgs, ... }:
      {
        nixpkgs = {
          config = {
            allowUnfree = true;
          };
        };

        home.packages = with pkgs; [
          # Using the FHS version to allow installation of extensions
          # I don't really need Nix to manage extensions for me
          antigravity-fhs
        ];
      };
  };
}
