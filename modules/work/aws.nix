{
  den,
  ...
}:
{
  den.aspects.work = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          aws-workspaces
        ];
      };

    includes = [
      (den.provides.unfree [
        "aws-workspaces"
        "workspacesclient"
      ])
    ];
  };
}
