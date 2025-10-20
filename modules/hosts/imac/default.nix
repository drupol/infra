{
  config,
  ...
}:
{
  unify.hosts.nixos.imac =
    { pkgs, ... }:
    {
      modules = with config.unify.modules; [
        # Modules
        base
        bluetooth
        desktop
        dev
        facter
        fwupd
        openssh
        sound
        vpn

        # Users
        root
        pol
      ];

      users.pol.modules = config.unify.hosts.nixos.x1c.modules;

      tags = [
        "desktop"
      ];

      fqdn = "imac.netbird.cloud";

      nixos = {
        boot.loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };

        facter.reportPath = ./facter.json;

        fileSystems."/" = {
          device = "/dev/disk/by-uuid/7f407c85-1ca8-4d01-8e4a-73a6f607caa7";
          fsType = "ext4";
        };

        fileSystems."/boot" = {
          device = "/dev/disk/by-uuid/F509-F532";
          fsType = "vfat";
          options = [
            "fmask=0077"
            "dmask=0077"
          ];
        };

        swapDevices = [
          { device = "/dev/disk/by-uuid/c9e3a23f-d2c6-49c7-94ad-0372aa4f94e5"; }
        ];

        services.xserver.videoDrivers = [
          "nvidia"
          "intel"
        ];

        # Enable sound with pipewire.
        services.pulseaudio.enable = false;
        security.rtkit.enable = true;
        services.pipewire = {
          enable = true;
          alsa.enable = true;
          alsa.support32Bit = true;
          pulse.enable = true;
        };

        system.stateVersion = "25.05";

        nixpkgs.config.nvidia.acceptLicense = true;
        nixpkgs.config.allowBroken = true;
        hardware = {
          opengl = {
            enable = true;
            driSupport = true;
            driSupport32Bit = true;
          };
          graphics.enable = true;
          nvidia = {
            # Optionally, you may need to select the appropriate driver version for your specific GPU.
            package = pkgs.linuxPackages_latest.nvidiaPackages.legacy_390;

            # Modesetting is required.
            modesetting.enable = true;

            # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
            # Enable this if you have graphical corruption issues or application crashes after waking
            # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
            # of just the bare essentials.
            powerManagement.enable = true;

            # Fine-grained power management. Turns off GPU when not in use.
            # Experimental and only works on modern Nvidia GPUs (Turing or newer).
            powerManagement.finegrained = false;

            # Use the NVidia open source kernel module (not to be confused with the
            # independent third-party "nouveau" open source driver).
            # Support is limited to the Turing and later architectures. Full list of
            # supported GPUs is at:
            # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
            # Only available from driver 515.43.04+
            # Currently "beta quality", so false is currently the recommended setting.
            open = false;

            # Enable the Nvidia settings menu,
            # accessible via `nvidia-settings`.
            nvidiaSettings = true;
          };
        };

        boot.blacklistedKernelModules = [
          "nouveau"
          "rivafb"
          "nvidiafb"
          "rivatv"
          "nv"
          "uvcvideo"
        ];
        boot.extraModulePackages = [
          pkgs.linuxPackages_latest.broadcom_sta
          config.boot.kernelPackages.nvidia_x11
        ];

        nixpkgs.config.permittedInsecurePackages = [
          "broadcom-sta-6.30.223.271-59-6.17.9"
        ];
      };
    };
}
