{
  unify.modules.work = {
    nixos = {
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
