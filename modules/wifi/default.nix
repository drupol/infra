{
  inputs,
  ...
}:
{
  flake-file.inputs = {
    # This is a private repository.
    # If you want to clone this project, it won't work unless you have access to it.
    # To remove it, remove all the occurrences of `inputs.infra-private` in all the
    # files of this project.
    infra-private.url = "github:drupol/infra-private";
  };

  den.aspects.wifi = {
    nixos = {
      imports = [
        inputs.infra-private.nixosModules.wifi
      ];

      networking.networkmanager.wifi.backend = "iwd";
    };
  };
}
