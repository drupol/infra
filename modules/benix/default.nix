{
  den,
  ...
}:
{
  den.aspects.benix = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          cowsay
        ];
      };

    includes = [
      den.aspects.tools.provides.nix-trusted-user
    ];

    nixos = {
      users.users.benix = {
        createHome = true;
        description = "Benix User Group";

        extraGroups = [
          "audio"
          "input"
          "networkmanager"
          "sound"
          "tty"
        ];

        initialPassword = "benix";
        isNormalUser = true;
      };
    };
  };
}
