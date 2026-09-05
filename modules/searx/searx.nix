{
  infra.searx = {
    nixos = {
      networking.firewall.allowedTCPPorts = [
        3002
      ];

      services = {
        caddy = {
          enable = true;

          virtualHosts = {
            "http://".extraConfig = ''
              handle_path /searx/* {
                reverse_proxy 127.0.0.1:3002
              }
            '';

            "https://".extraConfig = ''
              handle_path /searx/* {
                reverse_proxy 127.0.0.1:3002
              }
            '';
          };
        };

        searx = {
          enable = true;

          settings = {
            default_doi_resolver = "sci-hub.se";

            enabled_plugins = [
              "Hash plugin"
              "Search on category select"
              "Tracker URL remover"
              "Hostname replace"
              "Unit converter plugin"
              "Basic Calculator"
              "Open Access DOI rewrite"
            ];

            general = {
              debug = false;
              enable_metrics = true;
              privacypolicy_url = false;
            };

            search = {
              autocomplete = "google"; # "dbpedia", "duckduckgo", "google", "startpage", "swisscows", "qwant", "wikipedia" - leave blank to turn it off by default
              default_lang = "en";

              formats = [
                "html"
                "json"
                "rss"
              ];

              safe_search = 0; # 0 = None, 1 = Moderate, 2 = Strict
            };

            server = {
              base_url = "/searx";
              bind_address = "0.0.0.0";
              image_proxy = true;
              limiter = false;
              port = 3002;
              public_instance = false;
              secret_key = "spotting-gumminess-chamomile-unsuited-purple";
            };

            use_default_settings = true;
          };
        };
      };
    };
  };
}
