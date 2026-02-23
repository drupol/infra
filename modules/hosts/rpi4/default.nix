{
  den,
  inputs,
  ...
}:
{
  den.hosts.aarch64-linux.rpi4.users.pol = { };

  den.aspects.rpi4 = {
    provides.to-users = {
      includes = with den.aspects; [
        base
        bluetooth
        (facter ./facter.json)
        noise-station-client
        openssh
        # rpi4-sdimage
        shell
        vpn
        # Users
        root
      ];
    };

    nixos =
      { pkgs, ... }:
      {
        nixpkgs = {
          overlays = [
            (final: _prev: {
              master = import inputs.nixpkgs-master {
                inherit (final) config system;
              };
            })
            # Disable U-Boot "Hit any key" prompt. Default bootdelay=2 waits for keypress.
            # -2 skips autoboot delay entirely. Combined with boot.loader.timeout=0
            # for extlinux menu, this gives instant boot on headless systems.
            (_final: prev: {
              ubootRaspberryPi4_64bit = prev.ubootRaspberryPi4_64bit.override {
                extraConfig = ''
                  CONFIG_BOOTDELAY=-2
                '';
              };
            })
          ];
        };

        boot = {
          loader = {
            timeout = 0;
            grub.enable = false;
            generic-extlinux-compatible.enable = true;
          };
          # Prevent issues like: brcmfmac: brcmf_set_channel: set chanspec 0xd026 fail, reason -52
          kernelParams = [
            "snd_bcm2835.enable_headphones=1"
            "snd_bcm2835.enable_hdmi=1"
            "brcmfmac.roamoff=1"
            "brcmfmac.feature_disable=0x282000"
          ];
        };

        fileSystems = {
          "/" = {
            device = "/dev/disk/by-label/NIXOS_SD";
            fsType = "ext4";
            options = [ "noatime" ];
          };
        };

        networking.networkmanager.wifi.powersave = false;

        systemd.services.restart-network-manager = {
          description = "Restart NetworkManager to fix connection drops";
          serviceConfig = {
            Type = "oneshot";
            ExecStart = "${pkgs.systemd}/bin/systemctl restart NetworkManager.service";
          };
          startAt = "*:0/15";
        };
      };
  };
}
