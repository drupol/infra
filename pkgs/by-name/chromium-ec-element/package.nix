{ pkgs }:

pkgs.nix-webapps-lib.mkChromiumApp {
  appName = "ec-element";
  categories = [
    "Network"
    "Chat"
    "InstantMessaging"
  ];
  class = "chrome-app.matrix.tech.ec.europa.eu__-Default";
  desktopName = "Matrix @ European Commission";
  icon = ./Element_logo.svg;
  url = "https://app.matrix.tech.ec.europa.eu";
}
