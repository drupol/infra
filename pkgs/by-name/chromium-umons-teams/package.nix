{ pkgs }:

pkgs.nix-webapps-lib.mkChromiumApp {
  appName = "umons-teams";
  categories = [
    "Network"
    "Chat"
    "InstantMessaging"
  ];
  class = "chrome-teams.microsoft.com__-Default";
  desktopName = "MS Teams @ Umons";
  icon = ./Microsoft_Office_Teams.svg;
  url = "https://teams.microsoft.com";
}
