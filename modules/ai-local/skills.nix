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

    obra-superpowers = {
      flake = false;
      url = "github:obra/superpowers";
    };

    trailofbits-skills = {
      flake = false;
      url = "github:trailofbits/skills";
    };
  };

  den.aspects.ai-local = {
    homeManager =
      { lib, ... }:
      let
        # Stolen from https://github.com/shazow/nixfiles/blob/main/vms/agentspace/skills/flake.nix
        withAllSkills =
          name:
          skillsPath:
          let
            # 1. Read the contents of the target folder.
            # builtins.readDir returns an attribute set like: { "git-skill" = "directory"; "README.md" = "regular"; }
            rawContents = builtins.readDir (builtins.toPath skillsPath);

            # 2. Filter out entries that aren't directories to ensure we ignore root files
            skillDirectories = lib.filterAttrs (_name: type: type == "directory") rawContents;

            # 3. Extract just the names of the directories as a plain list of strings
            skillNames = builtins.attrNames skillDirectories;
          in
          # 4. Map the list of subfolders into a Home Manager attribute set structure
          builtins.listToAttrs (
            map (skillName: {
              name = ".agents/skills/${name}-${skillName}";

              value = {
                source = "${skillsPath}/${skillName}";
              };
            }) skillNames
          );
      in
      {
        home.file =
          (withAllSkills "mattpocock-skills" "${inputs.mattpocock-skills}/skills")
          // (withAllSkills "obra-superpowers" "${inputs.obra-superpowers}/skills")
          // (withAllSkills "trailofbits-skills" "${inputs.trailofbits-skills}/plugins");
      };
  };
}
