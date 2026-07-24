{
  den,
  ...
}:
{
  den.aspects.work = {
    includes = [
      (den.provides.unfree [
        "aws-workspaces"
        "workspacesclient"
      ])
    ];

    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          aws-workspaces
        ];
      };
  };
}
