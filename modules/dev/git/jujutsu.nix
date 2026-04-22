{
  den,
  lib,
  ...
}:
{
  den.aspects.dev = {
    homeManager =
      { config, pkgs, ... }:
      {
        home.file = {
          ".config/jj/conf.d/jujutsu.toml" = {
            source = ../../../files/home/pol/.config/jj/conf.d/jujutsu.toml;
            recursive = true;
          };
        };

        programs.starship.settings = {
          custom.jj = {
            when = "jj-starship detect";
            shell = [ (lib.getExe pkgs.jj-starship) ];
            format = "$output ";
          };
        };

        programs = {
          jujutsu = {
            enable = true;
            settings = {
              user = {
                name = den.aspects.${config.home.username}.meta.fullname;
                inherit (den.aspects.${config.home.username}.meta) email;
              };

              snapshot = {
                auto-update-stale = true;
                max-new-file-size = "15M";
              };

              ui = {
                default-command = [
                  "--ignore-working-copy"
                  "log"
                  "-T"
                  "builtin_log_oneline"
                ];
                graph.style = "square";
                show-cryptographic-signatures = true;
                revsets-use-glob-by-default = true;
                pager = ":builtin";
                paginate = "auto";
                streampager = {
                  interface = "quit-if-one-page";
                };
              };

              git = {
                private-commits = "description(glob:'wip:*') | description(glob:'private:*')";
                fetch = [
                  "origin"
                ];
                write-change-id-header = true;
              };

              revsets = {
                bookmark-advance-to = "heads(streams()::@- ~ private()::)";
              };

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
                lr = [
                  "l"
                  "--reversed"
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
                w = [
                  "workspace"
                ];
                wl = [
                  "workspace"
                  "list"
                ];
              };
            };
          };
        };
      };
  };
}
