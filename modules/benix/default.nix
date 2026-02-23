{
  den,
  ...
}:
{
  den.aspects.benix = {
    includes = [
      den.aspects.tools.provides.nix-trusted-user
    ];

    nixos = {
      users.users.benix = {
        description = "Benix User Group";
        isNormalUser = true;
        createHome = true;
        extraGroups = [
          "audio"
          "input"
          "networkmanager"
          "sound"
          "tty"
        ];
        initialPassword = "benix";
      };
    };

    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          cowsay
        ];
      };
  };
}
