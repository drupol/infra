{
  lib,
  ...
}:
{
  infra.dev = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          lean4
        ];

        programs.zed-editor = {
          enable = true;

          extensions = [
            "docker-compose"
            "dockerfile"
            "git-firefly"
            "graphviz"
            "http"
            "just"
            "latex"
            "lean4"
            "make"
            "material-icon-theme"
            "nix"
            "oxc"
            "plantuml"
            "ruff"
            "toml"
            "ty"
            "typos"
            "typst"
            "xml"
          ];

          userSettings = {
            auto_update = false;

            autosave = {
              after_delay = {
                milliseconds = 1000;
              };
            };

            base_keymap = "VSCode";
            buffer_font_family = "Aporetic Sans Mono";

            buffer_font_features = {
              calt = true;
              ligatures = true;
            };

            buffer_font_size = 14;
            cli_default_open_behavior = "new_window";

            edit_predictions = {
              disabled_globs = [
                "**/.env*"
                "**/*.pem"
                "**/*.key"
                "**/*.cert"
                "**/*.crt"
                "**/secrets.yml"
              ];

              provider = "copilot";
            };

            ensure_final_newline_on_save = true;

            file_scan_exclusions = [
              "_build"
              ".vscode"
              ".lexical"
              ".elixir_ls"
              ".coverage"
              ".venv"
              ".pytest_cache/"
              ".mypy_cache/"
              ".ruff_cache"
              ".git/"
              ".idea"
              "**/__pycache__"
              "node_modules"
              "test_db.sql"
              ".ropeproject"
              ".expert"
            ];

            file_types = {
              Dockerfile = [ "*Containerfile*" ];
            };

            format_on_save = "on";

            icon_theme = {
              dark = "Material Icon Theme";
              light = "Material Icon Theme";
              mode = "system";
            };

            inlay_hints = {
              enabled = true;
            };

            languages = {
              CSS = {
                formatter = [
                  {
                    language_server.name = "oxfmt";
                  }
                ];
              };

              HTML = {
                formatter = [
                  {
                    language_server.name = "oxfmt";
                  }
                ];
              };

              JSON = {
                formatter = [
                  {
                    language_server.name = "oxfmt";
                  }
                ];
              };

              JavaScript = {
                formatter = [
                  {
                    language_server.name = "oxfmt";
                  }
                ];
              };

              Markdown = {
                formatter = [
                  {
                    language_server.name = "oxfmt";
                  }
                ];
              };

              Nix = {
                language_servers = [
                  "nixd"
                  "!nil"
                ];

                show_edit_predictions = true;
              };

              TSX = {
                formatter = [
                  {
                    language_server.name = "oxfmt";
                  }
                ];
              };

              Typst = {
                formatter = {
                  language_server = {
                    name = "tinymist";
                  };
                };

                show_edit_predictions = true;
              };
              # Python = {
              #   language_servers = [
              #     "ty"
              #     "ruff"
              #   ];
              #   format_on_save = "on";
              #   formatter = [
              #     {
              #       code_action = "source.fixAll.ruff";
              #     }
              #     {
              #       code_action = "source.organizeImports.ruff";
              #     }
              #     {
              #       language_server = {
              #         name = "ruff";
              #       };
              #     }
              #   ];
              #   show_edit_predictions = true;
              # };
            };

            load_direnv = "direct";

            lsp = {
              nixd = {
                binary.path = lib.getExe pkgs.nixd;
              };

              oxfmt = {
                binary = {
                  arguments = [ "--lsp" ];
                  path = lib.getExe pkgs.oxfmt;
                };

                initialization_options.settings = {
                  fmt.configPath = ".oxfmtrc.json";
                  run = "onSave";
                };
              };

              # ruff = {
              #   binary = {
              #     path = lib.getExe pkgs.ruff;
              #     arguments = [ "server" ];
              #   };
              # };
              tinymist = {
                binary.path = lib.getExe pkgs.tinymist;

                initialization_options = {
                  preview = {
                    background = {
                      enabled = true;
                    };
                  };
                };

                settings = {
                  exportPdf = "onSave";
                  formatterMode = "typstyle";
                  outputPath = "$root/$name";
                };
              };

              # ty = {
              #   binary = {
              #     path = lib.getExe pkgs.ty;
              #     arguments = [ "server" ];
              #   };
              # };
              typos = {
                binary.path = lib.getExe pkgs.typos-lsp;
              };
            };

            preview_tabs = {
              enable_preview_from_file_finder = true;
              enabled = true;
            };

            project_panel = {
              dock = "left";
            };

            show_edit_predictions = true;
            tab_size = 2;

            tabs = {
              file_icons = true;
              git_status = true;
            };

            telemetry = {
              diagnostics = false;
              metrics = false;
            };

            terminal.env = {
              EDITOR = "zeditor --wait";
              VISUAL = "zeditor --wait";
            };

            ui_font_family = "Aporetic Sans Mono";
            ui_font_size = 14;

            wrap_guides = [
              80
              120
            ];
          };
        };
      };
  };
}
