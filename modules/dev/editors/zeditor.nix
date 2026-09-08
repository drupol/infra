{
  lib,
  ...
}:
{
  den.aspects.dev = {
    homeManager =
      { pkgs, ... }:
      let
        oxfmt.external = {
          arguments = [
            "--stdin-filepath"
            "{buffer_path}"
          ];

          command = lib.getExe pkgs.oxfmt;
        };
      in
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
            disable_ai = true;

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

            format_on_save = "off";

            git = {
              branch_picker = {
                show_author_name = true;
              };

              git_gutter = "tracked_files";

              inline_blame = {
                enabled = true;
                show_commit_summary = true;
              };
            };

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
                formatter = oxfmt;
              };

              JSON = {
                formatter = oxfmt;
              };

              JSONC = {
                formatter = oxfmt;
              };

              JavaScript = {
                formatter = oxfmt;
              };

              Markdown = {
                formatter = oxfmt;
              };

              Nix = {
                formatter = [
                  {
                    external = {
                      arguments = [
                        "--quiet"
                        "-"
                      ];

                      command = lib.getExe pkgs.nixfmt-rs;
                    };
                  }
                ];

                language_servers = [
                  "nixd"
                  "!nil"
                ];

                show_edit_predictions = true;
              };

              TSX = {
                formatter = oxfmt;
              };

              TypeScript = {
                formatter = oxfmt;
              };

              Typst = {
                formatter = {
                  language_server = {
                    name = "tinymist";
                  };
                };

                show_edit_predictions = true;
              };

              YAML = {
                formatter = oxfmt;
              };
            };

            load_direnv = "direct";

            lsp = {
              nixd = {
                binary.path = lib.getExe pkgs.nixd;
              };

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
