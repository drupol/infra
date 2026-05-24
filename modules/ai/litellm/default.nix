{
  den.aspects.ai = {
    nixos = {
      services = {
        litellm = {
          enable = true;
          host = "0.0.0.0";
          port = 8888;
          openFirewall = true;
          environment = {
            NO_DOCS = "True";
            NO_REDOC = "True";
            DISABLE_ADMIN_UI = "True";
            HOME = "/var/lib/litellm";
            SCARF_NO_ANALYTICS = "True";
            XDG_CACHE_HOME = "/var/cache/litellm";
          };
          environmentFile = "/home/pol/Code/drupol/litellm-secrets.env";
          settings = {
            litellm_settings = {
              check_provider_endpoint = true;
              drop_params = true;
            };

            # TODO
            # vector_store_registry = [
            #   {
            #     vector_store_name = "openai";
            #     litellm_params = {
            #       api_key = "os.environ/OPENAI_API_KEY";
            #       custom_llm_provider = "openai";
            #       vector_store_id = "os.environ/OPENAI_VECTOR_STORE_ID";
            #     };
            #   }
            # ];

            model_list = [
              {
                model_name = "ChatGPT 5.4 Mini";
                litellm_params = {
                  model = "openai/gpt-5.4-mini";
                  api_key = "os.environ/OPENAI_API_KEY";
                };
              }
              {
                model_name = "ChatGPT 5.4 Nano";
                litellm_params = {
                  model = "openai/gpt-5.4-nano";
                  api_key = "os.environ/OPENAI_API_KEY";
                };
              }
              {
                model_name = "ChatGPT 5.4";
                litellm_params = {
                  model = "openai/gpt-5.4";
                  api_key = "os.environ/OPENAI_API_KEY";
                };
              }
              {
                model_name = "ChatGPT 5.3 Codex";
                litellm_params = {
                  model = "openai/gpt-5.3-codex";
                  api_key = "os.environ/OPENAI_API_KEY";
                };
              }
              {
                model_name = "ChatGPT embed small";
                litellm_params = {
                  model = "openai/text-embedding-3-small";
                  api_key = "os.environ/OPENAI_API_KEY";
                };
              }
              {
                model_name = "ChatGPT embed large";
                litellm_params = {
                  model = "openai/text-embedding-3-large";
                  api_key = "os.environ/OPENAI_API_KEY";
                };
              }
              {
                model_name = "Copilot text-embedding-3-small";
                model_info = {
                  mode = "embedding";
                };
                litellm_params = {
                  model = "github_copilot/text-embedding-3-small";
                  extra_headers = {
                    editor-plugin-version = "copilot/1.388.0";
                    editor-version = "vscode/1.106.2";
                  };
                };
              }
              {
                model_name = "Copilot text-embedding-3-large";
                model_info = {
                  mode = "embedding";
                };
                litellm_params = {
                  model = "github_copilot/text-embedding-3-large";
                  extra_headers = {
                    editor-plugin-version = "copilot/1.388.0";
                    editor-version = "vscode/1.106.2";
                  };
                };
              }
            ]
            ++ (
              let
                copilotModel = name: {
                  model_name = "Copilot " + builtins.replaceStrings [ "." ] [ "-" ] name;
                  litellm_params = {
                    model = "github_copilot/${name}";
                    extra_headers = {
                      "editor-version" = "vscode/1.106.2";
                      "Copilot-Integration-Id" = "vscode-chat";
                    };
                  };
                };
              in
              map copilotModel (import ./_copilot.nix)
            );
          };
        };
      };
    };
  };
}
