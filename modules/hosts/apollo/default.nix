{
  config,
  ...
}:
{
  flake.modules.nixos."hosts/apollo".imports =
    with config.flake.modules.nixos;
    [
      # Modules
      base
      desktop
      dev
      docling
      facter
      guacamole
      openssh
      searx
      shell
      tika
      vpn

      # Users
      root
      pol
    ]
    # Specific Home-Manager modules
    ++ [
      {
        home-manager.users.pol.imports = with config.flake.modules.homeManager; [
          base
          desktop
          dev
          facter
          shell
          thunderbird
        ];
      }
    ];
}
