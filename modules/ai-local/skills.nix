{
  inputs,
  ...
}:
{
  flake-file.inputs = {
    mattpocock-skills = {
      flake = false;
      url = "github:mattpocock/skills";
    };
  };

  den.aspects.ai-local = {
    homeManager =
      { lib, pkgs, ... }:
      {
        home.activation.linkMattPocockSkills = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          ${pkgs.bash}/bin/bash ${inputs.mattpocock-skills}/scripts/link-skills.sh
        '';
      };
  };
}
