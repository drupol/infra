{ pkgs }:

pkgs.nix-webapps-lib.mkChromiumApp {
  appName = "ec-teams";
  categories = [
    "Network"
    "Chat"
    "InstantMessaging"
  ];
  class = "chrome-teams.microsoft.com__-Default";
  desktopName = "MS Teams @ European Commission";
  icon = ./Microsoft_Office_Teams.svg;
  url = "https://teams.microsoft.com";
}
