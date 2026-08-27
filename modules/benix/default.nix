{
  infra,
  ...
}:
{
  infra.benix = {
    includes = [
      infra.tools.provides.nix-trusted-user
    ];

    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          cowsay
        ];
      };

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
