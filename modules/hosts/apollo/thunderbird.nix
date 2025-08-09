{
  flake.modules.homeManager.thunderbird =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        thunderbird
      ];
    };
}
