{
  lib,
  den,
  ...
}:
{
  den.aspects.dev = {
    includes = [
      (den.provides.unfree [
        "vscode"
        "vscode-extension-bmewburn-vscode-intelephense-client"
        "vscode-extension-ms-vscode-remote-remote-containers"
        "vscode-extension-ms-vscode-remote-remote-ssh"
        "vscode-extension-ms-vsliveshare-vsliveshare"
      ])
    ];

    nixos = {
      services = {
        # needed for store VS Code auth token
        gnome.gnome-keyring.enable = true;
      };
    };

    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          vscode-runner
          lean4
          json-sort
        ];

        programs.vscode = {
          enable = true;
          mutableExtensionsDir = false;
          profiles = {
            default = {
              enableExtensionUpdateCheck = false;
              enableUpdateCheck = false;
              extensions = with pkgs.vscode-extensions; [
                bbenoist.nix
                bmewburn.vscode-intelephense-client
                christian-kohler.path-intellisense
                coder.coder-remote
                codezombiech.gitignore
                dhall.vscode-dhall-lsp-server
                dhall.dhall-lang
                donjayamanne.githistory
                editorconfig.editorconfig
                github.copilot-chat
                github.github-vscode-theme
                github.vscode-pull-request-github
                golang.go
                jebbs.plantuml
                jkillian.custom-local-formatters
                jnoortheen.nix-ide
                leanprover.lean4
                mkhl.direnv
                ms-vscode-remote.remote-containers
                ms-vscode-remote.remote-ssh
                ms-vsliveshare.vsliveshare
                myriad-dreamin.tinymist
                pkief.material-icon-theme
                redhat.vscode-yaml
                redhat.vscode-xml
                rust-lang.rust-analyzer
                tamasfe.even-better-toml
                tekumara.typos-vscode
                usernamehw.errorlens
                yzhang.markdown-all-in-one
                zhuangtongfa.material-theme
                (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
                  mktplcRef = {
                    name = "oxc-vscode";
                    publisher = "oxc";
                    version = "1.55.0";
                    hash = "sha256-QAuN9Qe1AErcGIbbqsYYO6kikgaEiX0Y3ddnNhuOB6Q=I me";
                  };

                  nativeBuildInputs = with pkgs; [
                    jaq
                    moreutils
                  ];

                  postInstall = ''
                    cd "$out/$installPrefix"

                    jaq \
                      --arg oxlint "${lib.getExe pkgs.oxlint}" \
                      --arg oxfmt "${lib.getExe pkgs.oxfmt}" \
                      '
                        .contributes.configuration.properties."oxc.path.oxlint".default = $oxlint |
                        .contributes.configuration.properties."oxc.path.oxfmt".default = $oxfmt
                      ' package.json | sponge package.json
                  '';
                })
              ];
              userSettings = {
                "[css]" = {
                  "editor.defaultFormatter" = "oxc.oxc-vscode";
                };
                "[go]" = {
                  "editor.defaultFormatter" = "golang.go";
                };
                "[graphql]" = {
                  "editor.defaultFormatter" = "oxc.oxc-vscode";
                };
                "[handlebars]" = {
                  "editor.defaultFormatter" = "oxc.oxc-vscode";
                };
                "[html]" = {
                  "editor.defaultFormatter" = "oxc.oxc-vscode";
                };
                "[javascript]" = {
                  "editor.defaultFormatter" = "oxc.oxc-vscode";
                };
                "[javascriptreact]" = {
                  "editor.defaultFormatter" = "oxc.oxc-vscode";
                };
                "[json]" = {
                  "editor.defaultFormatter" = "oxc.oxc-vscode";
                };
                "[jsonc]" = {
                  "editor.defaultFormatter" = "oxc.oxc-vscode";
                };
                "[json5]" = {
                  "editor.defaultFormatter" = "oxc.oxc-vscode";
                };
                "[less]" = {
                  "editor.defaultFormatter" = "oxc.oxc-vscode";
                };
                "[markdown]" = {
                  "editor.defaultFormatter" = "oxc.oxc-vscode";
                };
                "[mdx]" = {
                  "editor.defaultFormatter" = "oxc.oxc-vscode";
                };
                "[nix]" = {
                  "editor.defaultFormatter" = "jnoortheen.nix-ide";
                };
                "[php]" = {
                  "editor.defaultFormatter" = "bmewburn.vscode-intelephense-client";
                };
                "[postcss]" = {
                  "editor.defaultFormatter" = "oxc.oxc-vscode";
                };
                "[scss]" = {
                  "editor.defaultFormatter" = "oxc.oxc-vscode";
                };
                "[toml]" = {
                  "editor.defaultFormatter" = "tamasfe.even-better-toml";
                };
                "[txt]" = {
                  "editor.formatOnSave" = false;
                };
                "[typescript]" = {
                  "editor.defaultFormatter" = "oxc.oxc-vscode";
                };
                "[typescriptreact]" = {
                  "editor.defaultFormatter" = "oxc.oxc-vscode";
                };
                "[typst]" = {
                  "editor.defaultFormatter" = "myriad-dreamin.tinymist";
                };
                "[vue]" = {
                  "editor.defaultFormatter" = "oxc.oxc-vscode";
                };
                "[yaml]" = {
                  "editor.defaultFormatter" = "redhat.vscode-yaml";
                };
                "chat.mcp.access" = "all";
                "chat.mcp.gallery.enabled" = false;
                "chat.mcp.autostart" = "newAndOutdated";
                "debug.console.fontFamily" = "'Aporetic Sans Mono'";
                "diffEditor.ignoreTrimWhitespace" = false;
                "editor.bracketPairColorization.enabled" = true;
                "editor.cursorSmoothCaretAnimation" = "on";
                "editor.fontFamily" = "'Aporetic Sans Mono'";
                "editor.fontLigatures" = true;
                "editor.fontSize" = 14;
                "editor.formatOnSave" = false;
                "editor.guides.bracketPairs" = true;
                "editor.guides.bracketPairsHorizontal" = "active";
                "editor.guides.indentation" = true;
                "editor.inlineSuggest.enabled" = true;
                "editor.linkedEditing" = true;
                "editor.matchBrackets" = "always";
                "editor.renderWhitespace" = "boundary";
                "editor.suggestFontSize" = 0;
                "editor.suggest.preview" = true;
                "editor.suggest.showStatusBar" = true;
                "editor.mouseWheelZoom" = true;
                "editor.rulers" = [
                  80
                  120
                ];
                "editor.stickyScroll.enabled" = true;
                "editor.stickyScroll.maxLineCount" = 10;
                "editor.suggestSelection" = "first";
                "editor.unicodeHighlight.ambiguousCharacters" = false;
                "editor.unicodeHighlight.invisibleCharacters" = false;
                "editor.unicodeHighlight.nonBasicASCII" = false;
                "errorLens.enabled" = false;
                "explorer.confirmDelete" = false;
                "explorer.confirmDragAndDrop" = false;
                "explorer.fileNesting.enabled" = true;
                "explorer.fileNesting.patterns" = {
                  "*.md" = "\${capture}.*.md";
                  "config.toml" = "config.*.toml,params.toml";
                };
                "extensions.autoCheckUpdates" = false;
                "extensions.autoUpdate" = false;
                "extensions.ignoreRecommendations" = true;
                "files.autoSave" = "afterDelay";
                "files.autoSaveDelay" = 500;
                "files.insertFinalNewline" = true;
                "files.trimFinalNewlines" = true;
                "files.trimTrailingWhitespace" = true;
                "git.allowForcePush" = true;
                "git.autofetch" = true;
                "git.autoStash" = true;
                "git.blame.editorDecoration.enabled" = true;
                "git.blame.statusBarItem.enabled" = true;
                "git.blame.editorDecoration.template" = "\${subject}, \${authorName} (\${authorDateAgo})";
                "git.blame.statusBarItem.template" = "\${subject}, \${authorName} (\${authorDateAgo})";
                "git.confirmForcePush" = false;
                "git.confirmSync" = false;
                "git.enableSmartCommit" = true;
                "git.showPushSuccessNotification" = true;
                "github.copilot.enable" = {
                  "*" = true;
                  yaml = true;
                  plaintext = true;
                  markdown = true;
                };
                "githubPullRequests.pullBranch" = "always";
                "markdown.preview.fontFamily" = "'Aporetic Sans Mono'";
                "nix.formatterPath" = [ (lib.getExe pkgs.nixfmt-rs) ];
                "nix.serverPath" = lib.getExe pkgs.nixd;
                "nix.enableLanguageServer" = true;
                "nix.serverSettings.nixd.formatting.command" = [ (lib.getExe pkgs.nixfmt-rs) ];
                "plantuml.previewSnapIndicators" = true;
                "plantuml.render" = "Local";
                "plantuml.server" = "https://www.plantuml.com/plantuml";
                "redhat.telemetry.enabled" = false;
                "search.seedWithNearestWord" = true;
                "search.showLineNumbers" = true;
                "search.useGlobalIgnoreFiles" = true;
                "search.useIgnoreFiles" = true;
                "search.exclude" = {
                  "**/.direnv" = true;
                  "**/.git" = true;
                  "**/.jj" = true;
                  "**/.venv" = true;
                  "**/node_modules" = true;
                  "*.lock" = true;
                  "dist" = true;
                  "tmp" = true;
                };
                "security.workspace.trust.untrustedFiles" = "open";
                "telemetry.telemetryLevel" = "off";
                "terminal.integrated.defaultProfile.linux" = "fish";
                "terminal.integrated.fontSize" = 14;
                "terminal.integrated.tabs.enabled" = true;
                "tinymist.preview.scrollSync" = "onSelectionChange";
                "tinymist.formatterMode" = "typstyle";
                "update.mode" = "none";
                "update.showReleaseNotes" = true;
                "window.dialogStyle" = "custom";
                "window.menuBarVisibility" = "toggle";
                "window.newWindowDimensions" = "inherit";
                "window.titleBarStyle" = "custom";
                "window.zoomLevel" = 0;
                "workbench.colorCustomizations" = { };
                "workbench.colorTheme" = "GitHub Dark Default";
                "workbench.commandPalette.experimental.suggestCommands" = true;
                "workbench.editor.enablePreview" = true; # Prevents temporary editor tabs
                "workbench.editor.highlightModifiedTabs" = true;
                "workbench.iconTheme" = "material-icon-theme";
                "workbench.panel.defaultLocation" = "bottom";
                "workbench.startupEditor" = "none";
              };
            };
          };
        };
      };
  };
}
