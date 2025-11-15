{
  unify.modules.base.home = {
    programs.home-manager.enable = true;
    # See https://ohai.social/@rycee/112502545466617762
    # See https://github.com/nix-community/home-manager/issues/5452
    systemd.user.startServices = "sd-switch";

    services = {
      home-manager.autoExpire = {
        enable = true;
        frequency = "weekly";
        store.cleanup = true;
      };
    };
  };
}
