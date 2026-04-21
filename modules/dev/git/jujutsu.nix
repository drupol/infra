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
                ];
                graph.style = "square";
                show-cryptographic-signatures = true;
                revsets-use-glob-by-default = true;
              };

              git = {
                private-commits = "description(glob:'wip:*') | description(glob:'private:*')";
                remotes.origin.track-bookmarks = "*";
                fetch = [
                  "origin"
                ];
                write-change-id-header = true;
              };

              remotes = {
                origin = {
                  auto-track-bookmarks = "glob:*";
                };
              };

              revset-aliases = {
                # Source: https://github.com/bryceberger/config/blob/38c6caf0823517b5423b2ca2a25f7fd79d445e0e/home/jj/config.toml
                "/" = "trunk()";
                "_" = "fork_point(trunk() | @)";
                "_(x)" = "fork_point(trunk() | x)";
                "mine()" = "author(exact:'@name@') | author(exact:'@email@')";

                "immutable_heads()" = "trunk() | tags() | remote_bookmarks(remote=origin)";

                "streams()" = "heads(::@ & bookmarks())";
                "streams(x)" = "heads(::x & bookmarks())";

                "wip()" = "description(glob:'wip:*')";
                "private()" = "description(glob:'private:*')";
                safe_heads = "remote_bookmarks()";
                "why_immutable(r)" = "(r & immutable()) | roots(r:: & immutable_heads())";
              };

              revsets = {
                bookmark-advance-to = "heads(streams()::@- ~ private()::)";
              };

              template-aliases = {
                "commit_description_verbose(commit)" = ''
                  concat(
                    commit_description(commit),
                    "JJ: ignore-rest\n",
                    diff.git(),
                  )
                '';
                "commit_description(commit)" = ''
                  concat(
                    commit.description(), "\n",
                    "JJ: This commit contains the following changes:\n",
                    indent("JJ:    ", diff.stat(72)),
                  )
                '';

                annotate_header = ''
                  if(first_line_in_hunk, surround("\n", "\n", separate("\n",
                    separate(" ",
                      format_short_change_id_with_hidden_and_divergent_info(commit),
                      format_short_id(commit.commit_id()),
                      format_short_cryptographic_signature(commit.signature()),
                      commit.description().first_line(),
                    ),
                    commit_timestamp(commit).local().format('%Y-%m-%d %H:%M:%S')
                      ++ " "
                      ++ commit.author(),
                  ))) ++ pad_start(4, line_number) ++ ": " ++ content
                '';

                # 00000000 ........ yyyy-mm-dd HH:MM:SS    1:
                annotate = ''
                  if(first_line_in_hunk,
                    separate(" ",
                      format_short_id(commit.change_id()),
                      pad_end(8, truncate_end(8, commit.author().email().local())),
                      commit_timestamp(commit).local().format('%Y-%m-%d %H:%M:%S'),
                    ),
                    pad_end(37, ""),
                  ) ++ pad_start(4, line_number) ++ ": " ++ content
                '';

                "format_commit_info(commit)" = ''
                  separate(" ",
                    format_short_change_id_with_hidden_and_divergent_info(commit),
                    format_short_id(commit.commit_id()),
                    format_short_cryptographic_signature(commit.signature()),
                  )'';

                "format_commit_bookmarks(commit)" = ''
                  separate(" ",
                    commit.working_copies(),
                    commit.tags(),
                    commit.bookmarks(),
                  )'';

                "format_description(commit)" = ''
                  separate(" ",
                    if(empty, label("empty", "(empty)")),
                    coalesce(
                      if(commit.description(),
                        truncate_end(48, commit.description().first_line(), " [...]"),
                        if(!empty, label("description placeholder", "(no description)")),
                      )
                    )
                  )'';

                "format_author(commit)" = ''
                  separate(" ",
                   commit.author().email(),
                   commit.author().name(),
                  )
                '';

                "format_commit_date(commit)" = ''
                  separate(" ",
                    commit_timestamp(commit).local().format('%Y-%m-%d %H:%M:%S'),
                  )
                '';

                "format_short_change_id_with_hidden_and_divergent_info(commit)" = ''
                  if(commit.hidden(),
                    label("hidden",
                      format_short_change_id_with_gerrit_hyperlink(commit) ++
                      " hidden"
                    ),
                    label(if(commit.divergent(), "divergent"),
                      format_short_change_id_with_gerrit_hyperlink(commit) ++
                      if(commit.divergent(), "?")
                    )
                  )
                '';
                "gerrit_change_id(change_id)" = "'\"Id0000000\" ++ change_id.normal_hex()'";
                "format_short_change_id_with_gerrit_hyperlink(commit)" = ''
                  		hyperlink(
                  			"https://gerrit/q/" ++
                  			coalesce(
                  				commit.description().lines().map(|line|
                  					if(line.starts_with("Change-Id: "),
                  						line.remove_prefix("Change-Id: ")
                  					)
                  				).join(""),
                  				gerrit_change_id(commit.change_id())
                  			),
                  			format_short_change_id(commit.change_id())
                  		)
                  	'';
              };

              templates = {
                draft_commit_description = "commit_description(self)";

                file_annotate = "annotate_header";
              };

              aliases = {
                tug = [
                  "bookmark"
                  "advance"
                ];
                ds = [
                  "diff"
                  "--stat"
                ];
                l = [
                  "log"
                  "-T"
                  "builtin_log_compact"
                ];
                lr = [
                  "log"
                  "--reversed"
                  "-T"
                  "builtin_log_compact"
                ];
                ll = [
                  "log"
                  "-T"
                  "builtin_log_detailed"
                ];
                llr = [
                  "log"
                  "--reversed"
                  "-T"
                  "builtin_log_detailed"
                ];
                xl = [
                  "log"
                  "-T"
                  "builtin_log_detailed"
                ];
              };
            };
          };
        };
      };
  };
}
