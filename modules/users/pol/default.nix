{
  inputs,
  den,
  ...
}:
{
  flake-file.inputs = {
    # This is a private repository.
    # If you want to clone this project, it won't work unless you have access to it.
    # To remove it, remove all the occurrences of `inputs.infra-private` in all the
    # files of this project.
    infra-private.url = "github:drupol/infra-private";
  };

  den.aspects.pol =
    { config, ... }:
    {
      includes = [
        den.provides.define-user
        den.provides.primary-user
        den.aspects.tools.provides.nix-trusted-user
      ];

      meta = {
        email = "pol.dellaiera@protonmail.com";
        fullname = "Pol Dellaiera";
        username = "pol";
        key = "0AAF2901E8040715"; # ed25519/0x0AAF2901E8040715
        keygrip = [
          "143BC4FB7B3AC7C4F902ADCB579D2F66CDA1844A" # rsa4096/0xD476DFE9C67467CA
        ];
        authorizedKeys = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDfxTd6cA45DZPJsk3TmFmRPu1NQQ0XX0kow18mqFsLLaxiUQX1gsfW1kTVRGNh4s77StdsmnU/5oSQEXE6D8p3uEWCwNL74Sf4Lz4UyzSrsjyEEhNTQJromlgrVkf7N3wvEOakSZJICcpl05Z3UeResnkuZGSQ6zDVAKcB3KP1uYbR4SQGmWLHI1meznRkTDM5wHoiyWJnGpQjYVsRZT4LTUJwfhildAOx6ZIZUTsJrl35L2S81E6bv696CVGPvxV+PGbwGTavMYXfrSW4pqCnDPhQCLElQS4Od1qMicfYRSmk/W2oAKb8HZwFoWQSFUStF8ldQRnPyn2wiBQnhxnczt2jUhq1Uj6Nkq/edb1Ywgn7jlBR4BgRLD3K3oMvzJ/d3xDHjU56jc5lCA6lFLDMBV6Q9DKzMwL2jG3aQbehbUwTz7zbUwAHlCFIY5HGs4d9veXHyCsUikCLPvHL/hQU/vFRHHB7WNEyQJZK+ieOAW+un+1eF88iyKsOXE9y8PjLvXYcPHdzGaQKnqzEJSQcTUw9QSzOZQQpmpy8z6Lf08D2I4GHq1REp6d4krJOOW0gXadjsGEhLqQqWGnHE47QBPnlHlDWzOaf3UX59rFsl8xZDXoXzzwJ1stpeJx+Tn/uSNnaf44yXFyeFK/IDUeOrXYD4fSTLP1P/lCFCfeYqw== (none)"
        ];
      };

      user = {
        description = config.meta.fullname;
        openssh.authorizedKeys.keys = config.meta.authorizedKeys;
        createHome = true;
        extraGroups = [
          "dialout" # Or else: Permission denied: ‘/dev/ttyUSB0’
          "input"
          "tty"
        ];
        initialPassword = "id";
      };

      homeManager = {
        # Remove this part if no access to the private repository.
        imports = [
          (if inputs ? infra-private then inputs.infra-private.homeModules.pol else { })
        ];

        home.file = {
          ".face" = {
            source = ../../../files/home/pol/.face;
            recursive = true;
          };
          ".face.icon" = {
            source = ../../../files/home/pol/.face;
            recursive = true;
          };
          # Credits to https://store.kde.org/p/1272202
          "Pictures/Backgrounds/" = {
            source = ../../../files/home/pol/Pictures/Backgrounds;
            recursive = true;
          };
        };
      };
    };
}
