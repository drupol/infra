{
  config,
  ...
}:
{
  unify.hosts.nixos.xeonixos = {
    users.pol.modules = config.unify.hosts.nixos.xeonixos.modules;

    modules = with config.unify.modules; [
      base
      desktop
      dev
      facter
      guacamole
      openssh
      pol
      shell
      vpn
    ];

    tags = [
      "base"
      "desktop"
      "dev"
      "facter"
      "guacamole"
      "openssh"
      "shell"
      "vpn"
    ];

    fqdn = "xeonixos.netbird.cloud";
  };
}
