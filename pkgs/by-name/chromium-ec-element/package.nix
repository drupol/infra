{ pkgs }:

pkgs.nix-webapps-lib.mkChromiumApp {
  appName = "ec-element";
  categories = [
    "Network"
    "Chat"
    "InstantMessaging"
  ];
  class = "chrome-chat.contact.ec.europa.eu__-Default";
  desktopName = "Matrix @ European Commission";
  icon = ./Element_logo.svg;
  url = "https://chat.contact.ec.europa.eu";
}
