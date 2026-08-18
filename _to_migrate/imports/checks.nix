{ inputs, ... }:
{
  perSystem =
    { system, ... }:
    {
      checks = inputs.deploy-rs.lib.${system}.deployChecks {
        nodes = inputs.nixpkgs.lib.foldr (
          config: acc:
          acc
          // {
            "${config.instance}" = {
              inherit (config) hostname;
              fastConnection = false;

              profiles.system = {
                inherit (config) remoteBuild;

                path =
                  inputs.deploy-rs.lib.${config.system}.activate.nixos
                    inputs.self.nixosConfigurations.${config.instance};

                sshOpts = [ ];
                sshUser = "pol";
                user = "root";
              };
            };
          }
        ) { } (builtins.filter (el: el.system == "x86_64-linux") (import ../hosts.nix));
      };
    };
}
