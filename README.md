[![GitHub Workflow Status][github workflow status]][2]
![GitHub stars][github stars]
![License][mit]
[![Donate!][donate github]][5]

# Nix (dotfiles) configurations

This repository contains the configuration of my home network.

It originally started as a Flakes-based setup. I learned Nix through [Flakes]
from day one, and that workflow shaped most of my early habits. Flakes offer a
clean, powerful and reproducible way of structuring Nix projects... but as of
November 2025, they still remain marked as experimental in many environments.

Although I am confident stabilisation is on the horizon, I eventually chose to
return to a more traditional layout for day-to-day use. This approach provides
greater reliability across systems and, surprisingly, helped me understand more
deeply what happens under Nix’s hood.

The earlier version of this repository relied on [flake-parts] and followed a
[dendritic pattern], where every file was a flake-parts module. I really enjoyed
that structure, and actually stepping back from Flakes does not prevent me from
keeping the same modularity: the Nix code remains cleanly split into small and
reusable pieces.

This transition was made possible thanks to [`unflake`], which re-implements
Flake-like behaviour entirely in userland.

## Quick usage

Install or update a system:

```shell
# Run unflake to update inputs (Using NIX_CONFIG so it propagates to unflake)
NIX_CONFIG='
    extra-experimental-features = nix-command flakes
    tarball-ttl = 0' \
nix-shell https://codeberg.org/goldstein/unflake/archive/main.tar.gz -A unflake-shell --run unflake
# Compare current config with next one
NIX_CONFIG='tarball-ttl = 0' nix-shell -p dix -p nix-output-monitor --run 'dix /run/current-system $(nom-build --extra-experimental-features "nix-command flakes" default.nix -A nixosConfigurations.x1c.config.system.build.toplevel --no-out-link)'
# Set next system profile
NIX_CONFIG='tarball-ttl = 0' sudo nix-env --profile /nix/var/nix/profiles/system --set $(nix-build --extra-experimental-features "nix-command flakes" default.nix -A nixosConfigurations.x1c.config.system.build.toplevel --no-out-link)
# Switch to next profile
sudo /nix/var/nix/profiles/system/bin/switch-to-configuration switch
```

or with `nixos-rebuild`:

```shell
sudo nixos-rebuild switch --file default.nix -A nixosConfigurations.x1c
```

or with [`nh`](https://github.com/nix-community/nh):

```shell
NIX_CONFIG='tarball-ttl = 0' nix-shell https://codeberg.org/goldstein/unflake/archive/main.tar.gz -A unflake-shell --run unflake
nh os switch -a --file default.nix nixosConfigurations.x1c
```

Enter a development shell:

```shell
nix-shell -A devShells.x86_64-linux.default default.nix
# or, when a shell.nix is present:
nix-shell
```

Run the formatter:

```shell
nix-build -A formatter.x86_64-linux
./result/bin/treefmt
```

Update inputs:

```shell
nix run https://ln-s.sh/unflake
```

## Contributing

PRs and issues are welcome. Keep changes focused and include how to test them locally.

[github stars]: https://img.shields.io/github/stars/drupol/infra.svg?style=flat-square
[github workflow status]: https://img.shields.io/github/actions/workflow/status/drupol/infra/flake-check.yaml?style=flat-square&branch=master
[license]: https://img.shields.io/packagist/l/drupol/infra.svg?style=flat-square
[donate github]: https://img.shields.io/badge/Sponsor-Github-brightgreen.svg?style=flat-square
[2]: https://github.com/drupol/infra/actions
[mit]: https://img.shields.io/badge/License-MIT-green?style=flat-square
[5]: https://github.com/sponsors/drupol
[Flakes]: https://wiki.nixos.org/wiki/Flakes
[flake-parts]: https://flake.parts
[dendritic pattern]: https://discourse.nixos.org/t/pattern-every-file-is-a-flake-parts-module/61271
[`unflake`]: https://discourse.nixos.org/t/unflake-flake-dependencies-for-non-flake-projects-and-a-way-to-stop-writing-follows/72611
