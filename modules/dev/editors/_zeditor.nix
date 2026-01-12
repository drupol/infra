{
  lib,
  ...
}:
{
  flake.modules = {
    homeManager.dev =
      { pkgs, ... }:
      {
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
            "make"
            "material-icon-theme"
            "nix"
            "plantuml"
            "ruff"
            "toml"
            "ty"
            "typos"
            "typst"
          ];
          userSettings = {
            auto_update = false;
            autosave = {
              after_delay = {
                milliseconds = 1000;
              };
            };
            base_keymap = "VSCode";
            ensure_final_newline_on_save = true;
            buffer_font_family = "Aporetic Sans Mono";
            buffer_font_features = {
              calt = true;
              ligatures = true;
            };
            buffer_font_size = 14;
            edit_predictions = {
              disabled_globs = [
                "**/.env*"
                "**/*.pem"
                "**/*.key"
                "**/*.cert"
                "**/*.crt"
                "**/secrets.yml"
              ];
            };
            features = {
              edit_prediction_provider = "copilot";
            };
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
              mode = "system";
              light = "Material Icon Theme";
              dark = "Material Icon Theme";
            };
            inlay_hints = {
              enabled = true;
            };
            languages = {
              Markdown = { };
              Nix = {
                language_servers = [
                  "nixd"
                  "!nil"
                ];
                formatter.external = {
                  command = "${lib.getExe pkgs.nixfmt}";
                  arguments = [
                    "--quiet"
                    "--"
                  ];
                };
                show_edit_predictions = true;
              };
              Typst = {
                formatter = {
                  language_server = {
                    name = "tinymist";
                  };
                };
                show_edit_predictions = true;
              };
              Python = {
                language_servers = [
                  "ty"
                  "ruff"
                ];
                format_on_save = "on";
                formatter = [
                  {
                    code_action = "source.fixAll.ruff";
                  }
                  {
                    code_action = "source.organizeImports.ruff";
                  }
                  {
                    language_server = {
                      name = "ruff";
                    };
                  }
                ];
                show_edit_predictions = true;
              };
            };
            load_direnv = "direct";
            lsp = {
              nixd = {
                binary.path = lib.getExe pkgs.nixd;
              };
              ruff = {
                binary = {
                  path = lib.getExe pkgs.ruff;
                  arguments = [ "server" ];
                };
              };
              tinymist = {
                binary.path = lib.getExe pkgs.tinymist;
              };
              ty = {
                binary = {
                  path = lib.getExe pkgs.ty;
                  arguments = [ "server" ];
                };
              };
              typos = {
                binary.path = lib.getExe pkgs.typos-lsp;
              };
            };
            preview_tabs = {
              enabled = true;
              enable_preview_from_file_finder = true;
              enable_preview_from_code_navigation = true;
            };
            show_edit_predictions = true;
            tabs = {
              file_icons = true;
              git_status = true;
            };
            tab_size = 2;
            telemetry = {
              diagnostics = false;
              metrics = false;
            };
            terminal.env = {
              EDITOR = "zed --wait";
              VISUAL = "zed --wait";
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
