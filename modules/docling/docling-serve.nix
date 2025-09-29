{
  flake.modules.nixos.docling =
    { pkgs, ... }:
    {
      services = {
        docling-serve = {
          enable = true;
          host = "0.0.0.0";
          port = 5001;
          package = pkgs.docling-serve.override {
            withUI = true;
            withTesserocr = true;
            withCPU = true;
            withRapidocr = true;
          };
          environment = {
            DOCLING_SERVE_ENABLE_UI = "True";
            DOCLING_SERVE_MAX_SYNC_WAIT = "1200"; # Default is 120
          };
          openFirewall = true;
        };
      };
    };
}
