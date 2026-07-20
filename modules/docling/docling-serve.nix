{
  den.aspects.docling = {
    nixos =
      { pkgs, ... }:
      {
        services = {
          docling-serve = {
            enable = true;

            package = pkgs.docling-serve.override {
              withCPU = true;
              withRapidocr = true;
              withTesserocr = true;
              withUI = true;
            };

            environment = {
              DOCLING_SERVE_ENABLE_UI = "True";
              DOCLING_SERVE_MAX_SYNC_WAIT = "1200"; # Default is 120
            };

            host = "0.0.0.0";
            openFirewall = true;
            port = 5001;
          };
        };
      };
  };
}
