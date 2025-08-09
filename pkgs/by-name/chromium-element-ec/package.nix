{ pkgs }:

pkgs.nix-webapps-lib.mkChromiumApp {
  appName = "element-ec";
  categories = [
    "Network"
    "Chat"
    "InstantMessaging"
  ];
  class = "chrome-chat.contact.ec.europa.eu__-Default";
  desktopName = "Element European Commission";
  icon = ./Element_logo.svg;
  url = "https://chat.contact.ec.europa.eu";
}
