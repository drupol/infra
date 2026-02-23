{
  den.aspects.sound = {
    nixos = {
      services = {
        pipewire = {
          enable = true;
          alsa.enable = true;
          alsa.support32Bit = true;
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
