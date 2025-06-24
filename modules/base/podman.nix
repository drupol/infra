{
  flake.modules = {
    homeManager.base = {
      services.podman = {
        enable = true;
      };
    };
  };
}
