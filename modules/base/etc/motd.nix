{ inputs, ... }:
{
  den.aspects.base = {
    nixos =
      { config, ... }:
      {
        environment.etc.motd.text = ''

          NixOS release: ${config.system.nixos.release}
          Nixpkgs revision: ${inputs.nixpkgs.rev}
          drupol/infra revision: ${inputs.self.rev or inputs.self.dirtyRev}

        '';

        users.motdFile = "/etc/motd";
      };
  };
}
