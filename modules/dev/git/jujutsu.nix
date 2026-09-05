{
  lib,
  den,
  ...
}:
{
  den.aspects.dev = {
    homeManager =
      { config, pkgs, ... }:
      {
        home.file = {
          ".config/jj/conf.d/jujutsu.toml" = {
            recursive = true;
            source = ../../../files/home/pol/.config/jj/conf.d/jujutsu.toml;
          };
        };

        programs = {
          jujutsu = {
            enable = true;

            settings = {
              aliases = {
                c = [
                  "commit"
                ];

                ds = [
                  "diff"
                  "--stat"
                ];

                l = [
                  "log"
                ];

                ll = [
                  "log"
                  "-T"
                  "builtin_log_comfortable"
                ];

                llr = [
                  "ll"
                  "--reversed"
                ];

                lr = [
                  "l"
                  "--reversed"
                ];

                p = [
                  "git"
                  "push"
                ];

                pf = [
                  "git"
                  "push"
                  "--ignore-immutable"
                ];

                sync = [
                  "git"
                  "fetch"
                  "--all-remotes"
                ];

                tug = [
                  "bookmark"
                  "advance"
                ];

                w = [
                  "workspace"
                ];

                wl = [
                  "workspace"
                  "list"
                ];

                xl = [
                  "log"
                  "-T"
                  "builtin_log_compact_full_description"
                ];

                xlr = [
                  "xl"
                  "--reversed"
                ];

                xxl = [
                  "log"
                  "-T"
                  "builtin_log_detailed"
                ];

                xxlr = [
                  "xl"
                  "--reversed"
                ];
              };

              git = {
                fetch = [
                  "origin"
                ];

                private-commits = "description(glob:'wip:*') | description(glob:'private:*')";
                write-change-id-header = true;
              };

              revsets = {
                bookmark-advance-to = "heads(streams()::@- ~ private()::)";
              };

              snapshot = {
                auto-update-stale = true;
                max-new-file-size = "15M";
              };

              ui = {
                default-command = [
                  "--ignore-working-copy"
                  "log"
                  "--reversed"
                  "-T"
                  "builtin_log_oneline"
                ];

                diff-editor = ":builtin";
                graph.style = "square";
                pager = ":builtin";
                paginate = "auto";
                revsets-use-glob-by-default = true;
                show-cryptographic-signatures = true;

                streampager = {
                  interface = "quit-if-one-page";
                };
              };

              user = {
                inherit (den.aspects.${config.home.username}.meta) email;
                name = den.aspects.${config.home.username}.meta.fullname;
              };
            };
          };
        };

        programs.starship.settings = {
          custom.jj = {
            format = "$output ";
            shell = [ (lib.getExe pkgs.jj-starship) ];
            when = "jj-starship detect";
          };
        };
      };
  };
}
