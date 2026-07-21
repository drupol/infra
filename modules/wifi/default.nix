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

      networking = {
        networkmanager.wifi.backend = "iwd";

        wireless.iwd = {
          enable = true;

          settings.Rank = {
            BandModifier2_4GHz = 2.0; # (v > 1) = 2.4 GHz networks are preferred over the rest
            BandModifier5GHz = 0.5; # (0 < v < 1): preferred over 6 GHz networks
            BandModifier6GHz = 0.1; # (0 < v < 1): the least preferred band, but still usable if nothing else is available
          };
        };
      };
    };
  };
}
