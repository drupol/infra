{
  den,
  inputs,
  ...
}:
{
  den.aspects.ai = {
    includes = [
      (den.provides.unfree [ "open-webui" ])
      den.aspects.searx
    ];

    nixos =
      { pkgs, system, ... }:
      {
        nixpkgs = {
          overlays = [
            (final: _prev: {
              master = import inputs.nixpkgs-master {
                inherit (final) config;
                inherit system;
              };
            })
          ];
        };

        services = {
          open-webui = {
            enable = true;
            package = pkgs.master.open-webui;
            host = "0.0.0.0";
            port = 8080;
            environment = {
              CONTENT_EXTRACTION_ENGINE = "tika";
              DEVICE_TYPE = "cpu";
              ENABLE_OLLAMA_API = "True";
              ENABLE_OPENAI_API = "True";
              ENABLE_RAG_HYBRID_SEARCH = "True";
              ENABLE_RAG_WEB_LOADER_SSL_VERIFICATION = "False";
              ENABLE_RAG_WEB_SEARCH = "True";
              ENABLE_WEB_SEARCH = "True";
              OLLAMA_BASE_URL = "http://127.0.0.1:11434";
              OLLAMA_API_BASE_URL = "http://127.0.0.1:11434/api";
              OPENAI_API_BASE_URL = "http://127.0.0.1:8888/v1";
              OPENAI_API_KEY = "";
              PDF_EXTRACT_IMAGES = "True";
              RAG_EMBEDDING_ENGINE = "openai";
              RAG_EMBEDDING_MODEL = "openai/text-embedding-3-small";
              RAG_EMBEDDING_MODEL_AUTO_UPDATE = "True";
              RAG_FILE_MAX_COUNT = "2";
              RAG_OLLAMA_API_BASE_URL = "http://127.0.0.1:11434";
              RAG_OPENAI_API_BASE_URL = "http://127.0.0.1:8888/v1";
              RAG_RERANKING_MODEL = "BAAI/bge-reranker-v2-m3";
              RAG_TEXT_SPLITTER = "token";
              RAG_WEB_SEARCH_ENGINE = "searxng";
              RAG_WEB_SEARCH_RESULT_COUNT = "5";
              RESET_CONFIG_ON_START = "True";
              SEARXNG_QUERY_URL = "http://127.0.0.1/searx/search?q=<query>";
              TIKA_SERVER_URL = "http://apollo:9998/";
              WEBUI_AUTH = "False";
              WEBUI_NAME = "LLM @ Home";
              WEB_SEARCH_ENGINE = "searxng";
            };
          };

          caddy = {
            enable = true;
            virtualHosts."http://".extraConfig = ''
              reverse_proxy 127.0.0.1:8080
            '';
            virtualHosts."https://".extraConfig = ''
              reverse_proxy 127.0.0.1:8080
            '';
          };
        };

        networking.firewall.allowedTCPPorts = [
          80
          443
        ];
      };
  };
}
