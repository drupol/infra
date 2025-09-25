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
    ];

    tags = [
      "base"
      "desktop"
      "dev"
      "facter"
      "guacamole"
      "openssh"
      "shell"
    ];

    fqdn = "xeonixos.netbird.cloud";
  };
}
