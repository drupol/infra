{
  den.aspects.sound = {
    nixos = {
      services = {
        pipewire = {
          enable = true;

          alsa = {
            enable = true;
            support32Bit = true;
          };

          pulse.enable = true;
        };
      };
    };

    user = {
      extraGroups = [
        "sound"
        "audio"
      ];
    };
  };
}
