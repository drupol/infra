{
  den,
  ...
}:
{
  den.hosts.x86_64-linux.imac.users.pol = { };

  den.aspects.imac = {
    includes = [
      (den.provides.unfree [
        "nvidia-x11"
        "nvidia-settings"
        "broadcom-sta"
      ])
      (den.provides.insecure [
        "broadcom-sta-6.30.223.271-59-6.19.11"
      ])
    ];

    provides.to-users = {
      includes = with den.aspects; [
        base
        bluetooth
        desktop
        dev
        (facter ./facter.json)
        fwupd
        openssh
        sound
        vpn
        # Users
        root
      ];
    };

    nixos =
      { pkgs, config, ... }:
      {
        boot.loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };

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

        nixpkgs.config.nvidia.acceptLicense = true;
        nixpkgs.config.allowBroken = true;
        hardware = {
          graphics = {
            enable = true;
            enable32Bit = true;
          };
          nvidia = {
            # Optionally, you may need to select the appropriate driver version for your specific GPU.
            package = pkgs.linuxPackages_latest.nvidiaPackages.legacy_390;

            # Modesetting is required.
            modesetting.enable = true;

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
      };
  };
}
