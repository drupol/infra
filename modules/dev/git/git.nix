{
  den,
  ...
}:
{
  den.aspects.dev = {
    homeManager =
      { config, ... }:
      {
        programs = {
          git = {
            enable = true;

            ignores = [
              ".direnv/"
              ".jj/"
              "result"
            ];

            settings = {
              alias = {
                # From https://gist.github.com/pksunkara/988716
                a = "add --all";
                ac = "apply --check";
                ahead = "!git rev-list --right-only --count $(git bu)...HEAD";
                ai = "add -i";
                aliases = "!git config -l | grep alias | cut -c 7-";
                #############
                ama = "am --abort";
                amr = "am --resolved";
                ams = "am --skip";
                #############
                ap = "apply";
                as = "apply --stat";
                #############
                assume = "update-index --assume-unchanged";
                assumeall = "!git status -s | awk {'print $2'} | xargs git assume";
                assumed = "!git ls -v | grep ^h | cut -c 3-";
                #############
                b = "branch";
                ba = "branch -a";
                bare = "!sh -c 'git symbolic-ref HEAD refs/heads/$1 && git rm --cached -r . && git clean -xfd' -";
                bc = "rev-parse --abbrev-ref HEAD";
                bd = "branch -d";
                bdd = "branch -D";
                #############
                behind = "!git rev-list --left-only --count $(git bu)...HEAD";
                br = "branch -r";
                bu = ''!git rev-parse --abbrev-ref --symbolic-full-name "@{u}"'';
                #############
                bump = ''!sh -c 'git commit -am "Version bump v$1" && git psuoc && git release $1' -'';
                #############
                c = "commit";
                ca = "commit -a";
                cad = "commit -a --amend";
                cam = "commit -am";
                cd = "commit --amend";
                ced = "commit --allow-empty --amend";
                cem = "commit --allow-empty -m";
                #############
                cl = "clone";
                clb = "!/home/user/bin/git-clean-local-branches";
                cld = "clone --depth 1";
                clg = "!sh -c 'git clone git://github.com/$1 $(basename $1)' -";
                clgp = "!sh -c 'git clone git@github.com:$(git config --get user.username)/$1 $1' -";
                cm = "commit -m";
                co = "checkout";
                #############
                co-pr = "!sh -c 'git fetch origin refs/pull/$1/head:pull/$1 && git checkout pull/$1' -";
                cp = "cherry-pick";
                cpa = "cherry-pick --abort";
                cpc = "cherry-pick --continue";
                #############
                d = "diff";
                dc = "diff --cached";
                dck = "diff --cached --check";
                dct = "difftool --cached";
                dk = "diff --check";
                dp = "diff --patience";
                dt = "difftool";
                #############
                f = "fetch";
                #############
                fk = "fsck";
                fo = "fetch origin";
                #############
                fp = "format-patch";
                fu = "fetch upstream";
                #############
                g = "grep -p";
                human = "name-rev --name-only --refs=refs/heads/*";
                #############
                l = "log --oneline";
                lg = "log --oneline --graph --decorate";
                lgg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
                ll = "log --stat --abbrev-commit";
                lol = "log --graph --decorate --pretty=oneline --abbrev-commit";
                lola = "log --graph --decorate --pretty=oneline --abbrev-commit --all";
                #############
                ls = "ls-files";
                lsf = "!git ls-files | grep -i";
                #############
                m = "merge";
                ma = "merge --abort";
                mc = "merge --continue";
                merged = "!sh -c 'git o master && git plom && git bd $1 && git rpo' -";
                ms = "merge --skip";
                #############
                o = "checkout";
                ob = "checkout -b";
                #############
                ours = "!f() { git checkout --ours $@ && git add $@; }; f";
                patch = "format-patch --stdout HEAD~1";
                pb = "pull --rebase";
                pbo = "pull --rebase origin";
                pboc = "!git pull --rebase origin $(git bc)";
                pbom = "pull --rebase origin master";
                pbuc = "!git pull --rebase upstream $(git bc)";
                pbum = "pull --rebase upstream master";
                pf = "push --force-with-lease";
                #############
                pl = "pull";
                #############
                plo = "pull origin";
                ploc = "!git pull origin $(git bc)";
                plom = "pull origin master";
                #############
                plu = "pull upstream";
                pluc = "!git pull upstream $(git bc)";
                plum = "pull upstream master";
                #############
                pr = "prune -v";
                #############
                ps = "push";
                psao = "push --all origin";
                psaoc = "!git push --all origin $(git bc)";
                psaom = "push --all origin master";
                psdc = "!git push origin :$(git bc)";
                psf = "push -f";
                psfo = "push -f origin";
                psfoc = "!git push -f origin $(git bc)";
                psfom = "push -f origin master";
                #############
                pso = "push origin";
                psoc = "!git push origin $(git bc)";
                #############
                psom = "push origin master";
                pst = "push --tags";
                psu = "push -u";
                psuo = "push -u origin";
                psuoc = "!git push -u origin $(git bc)";
                psuom = "push -u origin master";
                #############
                r = "remote";
                ra = "remote add";
                rao = "remote add origin";
                rau = "remote add upstream";
                #############
                rb = "rebase";
                rba = "rebase --abort";
                rbc = "rebase --continue";
                rbi = "rebase --interactive";
                rbs = "rebase --skip";
                #############
                re = "reset";
                recent-branches = "branch --sort=-committerdate";
                reh = "reset --hard";
                rehh = "reset --hard HEAD";
                release = "!sh -c 'git tag v$1 && git pst' -";
                rem = "reset --mixed";
                remh = "reset --mixed HEAD";
                res = "reset --soft";
                resh = "reset --soft HEAD";
                rewrite = "rebase - x 'git commit - -amend - C HEAD - -date=\"$(date -R)\" && sleep 1.05'";
                rh = "reset HEAD";
                #############
                rmf = "rm -f";
                rmrf = "rm -r -f";
                rn = "remote rename";
                rp = "remote prune";
                rpatch = "reset --hard HEAD~1";
                rpo = "remote prune origin";
                rpu = "remote prune upstream";
                rr = "remote rm";
                rro = "remote remove origin";
                rru = "remote remove upstream";
                rs = "remote show";
                rso = "remote show origin";
                rsu = "remote show upstream";
                rv = "remote -v";
                #############
                s = "status";
                #############
                sa = "stash apply";
                sb = "status -s -b";
                sc = "stash clear";
                sd = "stash drop";
                serve = "daemon --reuseaddr --verbose --base-path=. --export-all ./.git";
                sl = "stash list";
                snap = "!git stash save 'snapshot = $(date)' && git stash apply 'stash@{0}'";
                sp = "stash pop";
                ss = "stash save";
                ssk = "stash save -k";
                st = "!git stash list | wc -l 2>/dev/null | grep -oEi '[0-9][0-9]*'";
                #############
                subadd = "!sh -c 'git submodule add git://github.com/$1 $2/$(basename $1)' -";
                subpull = "!git submodule foreach git pull --tags origin master";
                subrepo = "!sh -c 'git filter-branch --prune-empty --subdirectory-filter $1 master' -";
                subup = "submodule update --init --recursive";
                sw = "stash show";
                #############
                t = "tag";
                td = "tag -d";
                theirs = "!f() { git checkout --theirs $@ && git add $@; }; f";
                unassume = "update-index --no-assume-unchanged";
                unassumeall = "!git assumed | xargs git unassume";
                unrelease = "!sh -c 'git tag -d v$1 && git pso :v$1' -";
                #############
                w = "show";
                whois = ''!sh -c 'git log -i -1 --author="$1" --pretty="format:%an <%ae>"' -'';
                wp = "show -p";
                wr = "show -p --no-color";
              };

              branch = {
                autosetuprebase = "always";
              };

              color = {
                ui = "auto";
              };

              commit = {
                gpgsign = true;
              };

              core = {
                autocrlf = "input";
                editor = "micro";
                excludesfile = "~/.gitignore_global";
                safecrlf = "warn";
              };

              diff = {
                mnemonicprefix = true;
              };

              include = {
                path = "~/.gitconfig.local";
              };

              init = {
                defaultBranch = "main";
              };

              merge = {
                commit = "no";
                conflictstyle = "diff3";
                ff = "no";
                tool = "splice";
              };

              pull = {
                autoSetupRemote = true;
                default = "matching";
                rebase = true;
                useForceIfIncludes = true;
              };

              push = {
                autoSetupRemote = true;
                default = "current";
              };

              rebase = {
                autosquash = true;
                autostash = true;
                instructionFormat = "(%an <%ae>) %s";
                updateRefs = true;
              };

              rerere = {
                enabled = true;
              };

              signing = {
                inherit (den.aspects.${config.home.username}.meta) key;
                signByDefault = true;
              };

              user = {
                inherit (den.aspects.${config.home.username}.meta) email;
                name = den.aspects.${config.home.username}.meta.fullname;
              };
            };
          };
        };
      };
  };
}
