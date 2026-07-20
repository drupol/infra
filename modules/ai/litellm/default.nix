{
  den.aspects.ai = {
    nixos = {
      services = {
        litellm = {
          enable = true;

          environment = {
            DISABLE_ADMIN_UI = "True";
            HOME = "/var/lib/litellm";
            NO_DOCS = "True";
            NO_REDOC = "True";
            SCARF_NO_ANALYTICS = "True";
            XDG_CACHE_HOME = "/var/cache/litellm";
          };

          environmentFile = "/home/pol/Code/drupol/litellm-secrets.env";
          host = "0.0.0.0";
          openFirewall = true;
          port = 8888;

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
                litellm_params = {
                  api_key = "os.environ/OPENAI_API_KEY";
                  model = "openai/gpt-5.4-mini";
                };

                model_name = "ChatGPT 5.4 Mini";
              }
              {
                litellm_params = {
                  api_key = "os.environ/OPENAI_API_KEY";
                  model = "openai/gpt-5.4-nano";
                };

                model_name = "ChatGPT 5.4 Nano";
              }
              {
                litellm_params = {
                  api_key = "os.environ/OPENAI_API_KEY";
                  model = "openai/gpt-5.4";
                };

                model_name = "ChatGPT 5.4";
              }
              {
                litellm_params = {
                  api_key = "os.environ/OPENAI_API_KEY";
                  model = "openai/gpt-5.3-codex";
                };

                model_name = "ChatGPT 5.3 Codex";
              }
              {
                litellm_params = {
                  api_key = "os.environ/OPENAI_API_KEY";
                  model = "openai/text-embedding-3-small";
                };

                model_name = "ChatGPT embed small";
              }
              {
                litellm_params = {
                  api_key = "os.environ/OPENAI_API_KEY";
                  model = "openai/text-embedding-3-large";
                };

                model_name = "ChatGPT embed large";
              }
              {
                litellm_params = {
                  extra_headers = {
                    editor-plugin-version = "copilot/1.388.0";
                    editor-version = "vscode/1.106.2";
                  };

                  model = "github_copilot/text-embedding-3-small";
                };

                model_info = {
                  mode = "embedding";
                };

                model_name = "Copilot text-embedding-3-small";
              }
              {
                litellm_params = {
                  extra_headers = {
                    editor-plugin-version = "copilot/1.388.0";
                    editor-version = "vscode/1.106.2";
                  };

                  model = "github_copilot/text-embedding-3-large";
                };

                model_info = {
                  mode = "embedding";
                };

                model_name = "Copilot text-embedding-3-large";
              }
            ]
            ++ (
              let
                copilotModel = name: {
                  litellm_params = {
                    extra_headers = {
                      "Copilot-Integration-Id" = "vscode-chat";
                      "editor-version" = "vscode/1.106.2";
                    };

                    model = "github_copilot/${name}";
                  };

                  model_name = "Copilot " + builtins.replaceStrings [ "." ] [ "-" ] name;
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
