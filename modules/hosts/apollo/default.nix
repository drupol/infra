{
  config,
  ...
}:
{
  unify.hosts.nixos.apollo = {
    users.pol.modules = config.unify.hosts.nixos.apollo.modules;

    modules = with config.unify.modules; [
      base
      ai
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
      "ai"
      "dev"
      "facter"
      "guacamole"
      "openssh"
      "shell"
    ];

    fqdn = "apollo.netbird.cloud";
  };
}
