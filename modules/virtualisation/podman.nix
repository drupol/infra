{
  infra.virtualisation = {
    homeManager = {
      services.podman = {
        enable = true;
      };
    };
  };
}
