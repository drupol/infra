{
  flake.modules = {
    nixos.displaylink = {
      services = {
        xserver = {
          videoDrivers = [ "displaylink" ];
        };
      };

      nixpkgs = {
        config.allowUnfree = true;
      };
    };
  };
}
