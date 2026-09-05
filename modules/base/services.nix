{
  den.aspects.base = {
    nixos = {
      services = {
        flatpak = {
          enable = false;
        };

        # Limit the systemd journal to 100 MB of disk or the
        # last 3 days of logs, whichever happens first.
        journald.settings.Journal = {
          MaxFileSec = "3day";
          SystemMaxUse = "100M";
        };

        nscd.enableNsncd = true;
      };
    };
  };
}
