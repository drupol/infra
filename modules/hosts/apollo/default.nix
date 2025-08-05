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
      facter
      openssh
      shell
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
        ];
      }
    ];
}
