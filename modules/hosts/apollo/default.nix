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
      thunderbird
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
      "thunderbird"
    ];

    fqdn = "apollo.netbird.cloud";
  };
}
