{ lib, modulesPath, ... }:
{
  imports = [
    "${modulesPath}/virtualisation/amazon-image.nix"
    ./hardware.nix
  ];

  hardware.bluetooth.enable = true;

  networking = {
    # Use the GRUB 2 boot loader.
    # boot.loader.grub.enable = true;
    # boot.loader.grub.version = 2;
    # boot.loader.systemd-boot.enable = true;
    # boot.loader.grub.useOSProber = true;
    # boot.loader.efi.canTouchEfiVariables = true;
    # boot.loader.grub.efiSupport = true;
    # boot.loader.grub.efiInstallAsRemovable = true;
    # boot.loader.efi.efiSysMountPoint = "/boot/efi";
    # Define on which hard drive you want to install Grub.
    # boot.loader.grub.device = "nodev"; # or "nodev" for efi only
    hostName = "ec2"; # Define your hostname.
    # networking.interfaces.eno1.useDHCP = true;
    interfaces.eth0.useDHCP = true;
    networkmanager.enable = true; # Enables wireless support via wpa_supplicant.
    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
  };

  powerManagement.enable = true;
  programs = { };

  security = {
    # Enable CUPS to print documents.
    # services.printing.enable = true;
    # Enable sound.
    #sound.enable = true;
    #hardware.pulseaudio.enable = true;
    #hardware.pulseaudio.support32Bit = true;
    #hardware.pulseaudio.package = pkgs.pulseaudioFull;
    rtkit.enable = true;
    #  boot.extraModprobeConfig = ''
    #    options snd_hda_intel enable=0,1
    #  '';
    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;
    sudo.wheelNeedsPassword = false; # Use 'sudo' without a password
  };

  services = {
    #  system.copySystemConfiguration = true;
    fwupd.enable = true;

    # Limit the systemd journal to 100 MB of disk or the
    # last 7 days of logs, whichever happens first.
    journald.extraConfig = ''
      SystemMaxUse=100M
      MaxFileSec=3day
    '';

    openssh.settings.PasswordAuthentication = false;
    # services.acpid.enable = true;
    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    # Select internationalisation properties.
    # i18n.defaultLocale = "en_BE.UTF-8";
    # console = {
    #   font = "Lat2-Terminus16";
    #   keyMap = "us";
    # };
    udisks2.enable = lib.mkForce false;

    xserver = {
      xkb = {
        options = "eurosign:e";
        # Configure keymap in X11
        layout = "gb";
      };
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # List services that you want to enable:
  # services.cron = {
  #   enable = false;
  #   systemCronJobs = [
  #     "0 * * * *      root    nix-channel --update"
  #   ];
  # };
  # Enable the OpenSSH daemon.
  # services.openssh.enable = false;
  # networking.firewall.allowedTCPPorts = [ 3389 ];
  # networking.firewall.checkReversePath = false;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
  virtualisation.docker.enable = true;
  # networking.resolvconf.dnsExtensionMechanism = false;
}
