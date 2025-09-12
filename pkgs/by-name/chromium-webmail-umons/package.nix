{ pkgs }:

pkgs.nix-webapps-lib.mkChromiumApp {
  appName = "webmail-umons";
  categories = [
    "Network"
    "Email"
  ];
  class = "chrome-outlook.office365.com__-Default";
  desktopName = "Webmail @ Umons";
  icon = ./Microsoft_Office_Outlook.svg;
  url = "https://outlook.office365.com";
}
