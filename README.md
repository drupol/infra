![GitHub stars][github stars]
![License][mit]
[![Donate!][donate github]][5]

# PIAnC - Personal Infrastructure As (Nix) Code

This repository contains my personal infrastructure as code and host configurations.

It is built as a Nix flake using the [Den framework](https://github.com/vic/den) and organized into reusable modules for:

- host definitions
- desktop environments
- system and user profiles
- services
- custom packages

## Repository layout

- `modules/`: reusable modules (base system, hosts, services, desktop, tooling, etc.)
- `pkgs/by-name/`: local package definitions
- `files/`: static files copied into target systems
- `_to_migrate/`: legacy or in-progress migration content

## Common commands

### Enter development shell

```shell
nix develop
```

### Format all supported files

```shell
nix fmt
```

### Run flake checks

```shell
nix flake check
```

### Build a host configuration

```shell
nix build .#nixosConfigurations.<host>.config.system.build.toplevel
```

### Switch local machine to a host config

```shell
sudo nixos-rebuild switch --flake .#<host>
```

## Notes

- `flake.nix` is auto-generated. Use `nix run .#write-flake` to regenerate it.

[github stars]: https://img.shields.io/github/stars/drupol/infra.svg?style=flat-square
[donate github]: https://img.shields.io/badge/Sponsor-Github-brightgreen.svg?style=flat-square
[mit]: https://img.shields.io/badge/License-MIT-green?style=flat-square
[5]: https://github.com/sponsors/drupol
