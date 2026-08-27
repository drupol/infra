{
  infra.dev = {
    homeManager =
      { pkgs, ... }:
      {
        programs = {
          gh = {
            extensions = [
              pkgs.gh-dash
            ];
          };

          gh-dash = {
            enable = true;

            settings = {
              defaults = {
                issuesLimit = 10;

                preview = {
                  open = false;
                  width = 100;
                };

                prsLimit = 25;
                refetchIntervalMinutes = 10;
                view = "prs";
              };

              keybindings = {
                prs = [
                  {
                    command = "cd {{.RepoPath}} && code . && gh pr checkout {{.PrNumber}}";
                    key = "V";
                  }
                ];
              };

              prSections = [
                {
                  filters = "repo:NixOS/nixpkgs is:open draft:false status:success";
                  title = "To review";
                }
                {
                  filters = ''repo:NixOS/nixpkgs is:open draft:false label:"12. first-time contribution"'';
                  title = "1st contribution";
                }
                {
                  filters = ''repo:NixOS/nixpkgs is:open draft:false status:success label:"12.approvals: 1"'';
                  title = "1st approval";
                }
                {
                  filters = ''repo:NixOS/nixpkgs is:open draft:false status:success base:master -label:"1.severity: mass-rebuild" -label:"1.severity: mass-darwin-rebuild"  author:r-ryantm'';
                  title = "From r-ryantm only";
                }
                {
                  filters = "is:open author:@me";
                  title = "My PRs";
                }
                {
                  filters = "is:open review-requested:@me";
                  title = "Needs my review";
                }
                {
                  filters = "is:open involves:@me -author:@me";
                  title = "Involved";
                }
              ];

              repoPaths = {
                "NixOS/*" = "~/Code/NixOS/*";
              };

              theme.ui.table.showSeparator = false;
            };
          };
        };
      };
  };
}
