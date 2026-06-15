{
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    toJSON
    ;

  inherit (lib.types)
    attrsOf
    anything
    ;
in
{
  format =
    _:
    {
      type = attrsOf anything // {
        description = "ConfigObj mapping";
      };

      lib.types.atom = anything;

      generate =
        name: value:
        pkgs.runCommand name
          {
            nativeBuildInputs = [
              (pkgs.python3.withPackages (ps: with ps; [ configobj ]))
            ];

            valuesJSON = toJSON value;
            preferLocalBuild = true;
            __structuredAttrs = true;
          }
          ''
            valuesPath="$TMPDIR/values.json"

            printf "%s" "$valuesJSON" > "$valuesPath"

            python3 ${./generate.py} "$valuesPath" > "$out"
          '';
    };
}
