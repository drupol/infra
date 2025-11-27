let
  deps = {
    unflake_github_cachix_git-hooks-nix = builtins.fetchTree {
      type = "github";
      owner = "cachix";
      repo = "git-hooks.nix";
      rev = "50b9238891e388c9fdc6a5c49e49c42533a1b5ce";
    };
    unflake_github_drupol_infra-private = builtins.fetchTree {
      type = "github";
      owner = "drupol";
      repo = "infra-private";
      rev = "48ed44c8958b8ad6ff249fa11e9d20586e67edc4";
    };
    unflake_github_drupol_nix-oracle-db = builtins.fetchTree {
      type = "github";
      owner = "drupol";
      repo = "nix-oracle-db";
      rev = "ed83fc92be4fc718ed2c2e2cdb9854f4f40ddb3e";
    };
    unflake_github_drupol_pkgs-by-name-for-flake-parts = builtins.fetchTree {
      type = "github";
      owner = "drupol";
      repo = "pkgs-by-name-for-flake-parts";
      rev = "477b3e8f981e3d7bac9d297e64796c918942f744";
    };
    unflake_github_edolstra_flake-compat_flake_false = builtins.fetchTree {
      type = "github";
      owner = "edolstra";
      repo = "flake-compat";
      rev = "f387cd2afec9419c8ee37694406ca490c3f34ee5";
    };
    unflake_github_hercules-ci_flake-parts = builtins.fetchTree {
      type = "github";
      owner = "hercules-ci";
      repo = "flake-parts";
      rev = "2cccadc7357c0ba201788ae99c4dfa90728ef5e0";
    };
    unflake_github_hercules-ci_gitignore-nix = builtins.fetchTree {
      type = "github";
      owner = "hercules-ci";
      repo = "gitignore.nix";
      rev = "cb5e3fdca1de58ccbc3ef53de65bd372b48f567c";
    };
    unflake_github_nicknovitski_make-shell = builtins.fetchTree {
      type = "github";
      owner = "nicknovitski";
      repo = "make-shell";
      rev = "ffeceae9956df03571ea8e96ef77c2924f13a63c";
    };
    unflake_github_nix-community_disko = builtins.fetchTree {
      type = "github";
      owner = "nix-community";
      repo = "disko";
      rev = "5a88a6eceb8fd732b983e72b732f6f4b8269bef3";
    };
    unflake_github_nix-community_home-manager = builtins.fetchTree {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      rev = "ff067cfc619fdf6f82d50344e7d19ff2323f0827";
    };
    unflake_github_nix-community_nixos-generators = builtins.fetchTree {
      type = "github";
      owner = "nix-community";
      repo = "nixos-generators";
      rev = "032a1878682fafe829edfcf5fdfad635a2efe748";
    };
    unflake_github_nix-community_nixpkgs-lib = builtins.fetchTree {
      type = "github";
      owner = "nix-community";
      repo = "nixpkgs.lib";
      rev = "e9537535ae8f4a2f78dbef0aaa0cbb6af4abd047";
    };
    unflake_github_nix-community_nur = builtins.fetchTree {
      type = "github";
      owner = "nix-community";
      repo = "nur";
      rev = "f3a83106de56c232c51a99a5f498cdbb7509db53";
    };
    unflake_github_nix-community_plasma-manager = builtins.fetchTree {
      type = "github";
      owner = "nix-community";
      repo = "plasma-manager";
      rev = "b24ed4b272256dfc1cc2291f89a9821d5f9e14b4";
    };
    unflake_github_nix-systems_default = builtins.fetchTree {
      type = "github";
      owner = "nix-systems";
      repo = "default";
      rev = "da67096a3b9bf56a91d16901293e51ba5b49a27e";
    };
    unflake_github_nixos_nixos-hardware_ref_master = builtins.fetchTree {
      type = "github";
      owner = "nixos";
      repo = "nixos-hardware";
      rev = "9154f4569b6cdfd3c595851a6ba51bfaa472d9f3";
    };
    unflake_github_nixos_nixpkgs_ref_master = builtins.fetchTree {
      type = "github";
      owner = "nixos";
      repo = "nixpkgs";
      rev = "dcd0318502c47838f731f575baef8429b8a2ab10";
    };
    unflake_github_nixos_nixpkgs_ref_nixos-unstable = builtins.fetchTree {
      type = "github";
      owner = "nixos";
      repo = "nixpkgs";
      rev = "2d293cbfa5a793b4c50d17c05ef9e385b90edf6c";
    };
    unflake_github_nixos_nixpkgs_ref_nixpkgs-unstable = builtins.fetchTree {
      type = "github";
      owner = "nixos";
      repo = "nixpkgs";
      rev = "f720de59066162ee879adcc8c79e15c51fe6bfb4";
    };
    unflake_github_numtide_flake-utils = builtins.fetchTree {
      type = "github";
      owner = "numtide";
      repo = "flake-utils";
      rev = "11707dc2f618dd54ca8739b309ec4fc024de578b";
    };
    unflake_github_numtide_nixos-facter-modules = builtins.fetchTree {
      type = "github";
      owner = "numtide";
      repo = "nixos-facter-modules";
      rev = "5ea68886d95218646d11d3551a476d458df00778";
    };
    unflake_github_numtide_treefmt-nix = builtins.fetchTree {
      type = "github";
      owner = "numtide";
      repo = "treefmt-nix";
      rev = "5b4ee75aeefd1e2d5a1cc43cf6ba65eba75e83e4";
    };
    unflake_github_serokell_deploy-rs = builtins.fetchTree {
      type = "github";
      owner = "serokell";
      repo = "deploy-rs";
      rev = "9c870f63e28ec1e83305f7f6cb73c941e699f74f";
    };
    unflake_github_tlater_nix-webapps = builtins.fetchTree {
      type = "github";
      owner = "tlater";
      repo = "nix-webapps";
      rev = "1bb9ee8e3f428575c1c6898ae7af8d96416d696a";
    };
    unflake_github_vic_import-tree = builtins.fetchTree {
      type = "github";
      owner = "vic";
      repo = "import-tree";
      rev = "3c23749d8013ec6daa1d7255057590e9ca726646";
    };
    unflake_sourcehut_-rycee_lazy-apps = builtins.fetchTree {
      type = "sourcehut";
      owner = "~rycee";
      repo = "lazy-apps";
      rev = "4ddc92c77213f8ed3ddef1868f4a19002afa728a";
    };
  };
  universe = rec {
    unflake_github_cachix_git-hooks-nix = ((import "${deps.unflake_github_cachix_git-hooks-nix.outPath}/flake.nix").outputs {
      self = unflake_github_cachix_git-hooks-nix;
      flake-compat = unflake_github_edolstra_flake-compat_flake_false;
      gitignore = unflake_github_hercules-ci_gitignore-nix;
      nixpkgs = unflake_github_nixos_nixpkgs_ref_nixpkgs-unstable;
    }) // deps.unflake_github_cachix_git-hooks-nix // {
      _flake = true;
      outPath = "${deps.unflake_github_cachix_git-hooks-nix.outPath}";
      sourceInfo = deps.unflake_github_cachix_git-hooks-nix;
    };
    unflake_github_drupol_infra-private = ((import "${deps.unflake_github_drupol_infra-private.outPath}/flake.nix").outputs {
      self = unflake_github_drupol_infra-private;
      flake-parts = unflake_github_hercules-ci_flake-parts;
      home-manager = unflake_github_nix-community_home-manager;
      import-tree = unflake_github_vic_import-tree;
      nixpkgs = unflake_github_nixos_nixpkgs_ref_nixos-unstable;
      nixpkgs-master = unflake_github_nixos_nixpkgs_ref_master;
      nixpkgs-unstable = unflake_github_nixos_nixpkgs_ref_nixpkgs-unstable;
      systems = unflake_github_nix-systems_default;
    }) // deps.unflake_github_drupol_infra-private // {
      _flake = true;
      outPath = "${deps.unflake_github_drupol_infra-private.outPath}";
      sourceInfo = deps.unflake_github_drupol_infra-private;
    };
    unflake_github_drupol_nix-oracle-db = ((import "${deps.unflake_github_drupol_nix-oracle-db.outPath}/flake.nix").outputs {
      self = unflake_github_drupol_nix-oracle-db;
      nixpkgs = unflake_github_nixos_nixpkgs_ref_nixos-unstable;
      systems = unflake_github_nix-systems_default;
    }) // deps.unflake_github_drupol_nix-oracle-db // {
      _flake = true;
      outPath = "${deps.unflake_github_drupol_nix-oracle-db.outPath}";
      sourceInfo = deps.unflake_github_drupol_nix-oracle-db;
    };
    unflake_github_drupol_pkgs-by-name-for-flake-parts = ((import "${deps.unflake_github_drupol_pkgs-by-name-for-flake-parts.outPath}/flake.nix").outputs {
      self = unflake_github_drupol_pkgs-by-name-for-flake-parts;
    }) // deps.unflake_github_drupol_pkgs-by-name-for-flake-parts // {
      _flake = true;
      outPath = "${deps.unflake_github_drupol_pkgs-by-name-for-flake-parts.outPath}";
      sourceInfo = deps.unflake_github_drupol_pkgs-by-name-for-flake-parts;
    };
    unflake_github_edolstra_flake-compat_flake_false = deps.unflake_github_edolstra_flake-compat_flake_false;
    unflake_github_hercules-ci_flake-parts = ((import "${deps.unflake_github_hercules-ci_flake-parts.outPath}/flake.nix").outputs {
      self = unflake_github_hercules-ci_flake-parts;
      nixpkgs-lib = unflake_github_nix-community_nixpkgs-lib;
    }) // deps.unflake_github_hercules-ci_flake-parts // {
      _flake = true;
      outPath = "${deps.unflake_github_hercules-ci_flake-parts.outPath}";
      sourceInfo = deps.unflake_github_hercules-ci_flake-parts;
    };
    unflake_github_hercules-ci_gitignore-nix = ((import "${deps.unflake_github_hercules-ci_gitignore-nix.outPath}/flake.nix").outputs {
      self = unflake_github_hercules-ci_gitignore-nix;
    }) // deps.unflake_github_hercules-ci_gitignore-nix // {
      _flake = true;
      outPath = "${deps.unflake_github_hercules-ci_gitignore-nix.outPath}";
      sourceInfo = deps.unflake_github_hercules-ci_gitignore-nix;
    };
    unflake_github_nicknovitski_make-shell = ((import "${deps.unflake_github_nicknovitski_make-shell.outPath}/flake.nix").outputs {
      self = unflake_github_nicknovitski_make-shell;
      flake-compat = unflake_github_edolstra_flake-compat_flake_false;
    }) // deps.unflake_github_nicknovitski_make-shell // {
      _flake = true;
      outPath = "${deps.unflake_github_nicknovitski_make-shell.outPath}";
      sourceInfo = deps.unflake_github_nicknovitski_make-shell;
    };
    unflake_github_nix-community_disko = ((import "${deps.unflake_github_nix-community_disko.outPath}/flake.nix").outputs {
      self = unflake_github_nix-community_disko;
      nixpkgs = unflake_github_nixos_nixpkgs_ref_nixpkgs-unstable;
    }) // deps.unflake_github_nix-community_disko // {
      _flake = true;
      outPath = "${deps.unflake_github_nix-community_disko.outPath}";
      sourceInfo = deps.unflake_github_nix-community_disko;
    };
    unflake_github_nix-community_home-manager = ((import "${deps.unflake_github_nix-community_home-manager.outPath}/flake.nix").outputs {
      self = unflake_github_nix-community_home-manager;
      nixpkgs = unflake_github_nixos_nixpkgs_ref_nixos-unstable;
    }) // deps.unflake_github_nix-community_home-manager // {
      _flake = true;
      outPath = "${deps.unflake_github_nix-community_home-manager.outPath}";
      sourceInfo = deps.unflake_github_nix-community_home-manager;
    };
    unflake_github_nix-community_nixos-generators = ((import "${deps.unflake_github_nix-community_nixos-generators.outPath}/flake.nix").outputs {
      self = unflake_github_nix-community_nixos-generators;
      nixlib = unflake_github_nix-community_nixpkgs-lib;
      nixpkgs = unflake_github_nixos_nixpkgs_ref_nixpkgs-unstable;
    }) // deps.unflake_github_nix-community_nixos-generators // {
      _flake = true;
      outPath = "${deps.unflake_github_nix-community_nixos-generators.outPath}";
      sourceInfo = deps.unflake_github_nix-community_nixos-generators;
    };
    unflake_github_nix-community_nixpkgs-lib = ((import "${deps.unflake_github_nix-community_nixpkgs-lib.outPath}/flake.nix").outputs {
      self = unflake_github_nix-community_nixpkgs-lib;
    }) // deps.unflake_github_nix-community_nixpkgs-lib // {
      _flake = true;
      outPath = "${deps.unflake_github_nix-community_nixpkgs-lib.outPath}";
      sourceInfo = deps.unflake_github_nix-community_nixpkgs-lib;
    };
    unflake_github_nix-community_nur = ((import "${deps.unflake_github_nix-community_nur.outPath}/flake.nix").outputs {
      self = unflake_github_nix-community_nur;
      flake-parts = unflake_github_hercules-ci_flake-parts;
      nixpkgs = unflake_github_nixos_nixpkgs_ref_nixos-unstable;
    }) // deps.unflake_github_nix-community_nur // {
      _flake = true;
      outPath = "${deps.unflake_github_nix-community_nur.outPath}";
      sourceInfo = deps.unflake_github_nix-community_nur;
    };
    unflake_github_nix-community_plasma-manager = ((import "${deps.unflake_github_nix-community_plasma-manager.outPath}/flake.nix").outputs {
      self = unflake_github_nix-community_plasma-manager;
      home-manager = unflake_github_nix-community_home-manager;
      nixpkgs = unflake_github_nixos_nixpkgs_ref_nixos-unstable;
    }) // deps.unflake_github_nix-community_plasma-manager // {
      _flake = true;
      outPath = "${deps.unflake_github_nix-community_plasma-manager.outPath}";
      sourceInfo = deps.unflake_github_nix-community_plasma-manager;
    };
    unflake_github_nix-systems_default = ((import "${deps.unflake_github_nix-systems_default.outPath}/flake.nix").outputs {
      self = unflake_github_nix-systems_default;
    }) // deps.unflake_github_nix-systems_default // {
      _flake = true;
      outPath = "${deps.unflake_github_nix-systems_default.outPath}";
      sourceInfo = deps.unflake_github_nix-systems_default;
    };
    unflake_github_nixos_nixos-hardware_ref_master = ((import "${deps.unflake_github_nixos_nixos-hardware_ref_master.outPath}/flake.nix").outputs {
      self = unflake_github_nixos_nixos-hardware_ref_master;
    }) // deps.unflake_github_nixos_nixos-hardware_ref_master // {
      _flake = true;
      outPath = "${deps.unflake_github_nixos_nixos-hardware_ref_master.outPath}";
      sourceInfo = deps.unflake_github_nixos_nixos-hardware_ref_master;
    };
    unflake_github_nixos_nixpkgs_ref_master = ((import "${deps.unflake_github_nixos_nixpkgs_ref_master.outPath}/flake.nix").outputs {
      self = unflake_github_nixos_nixpkgs_ref_master;
    }) // deps.unflake_github_nixos_nixpkgs_ref_master // {
      _flake = true;
      outPath = "${deps.unflake_github_nixos_nixpkgs_ref_master.outPath}";
      sourceInfo = deps.unflake_github_nixos_nixpkgs_ref_master;
    };
    unflake_github_nixos_nixpkgs_ref_nixos-unstable = ((import "${deps.unflake_github_nixos_nixpkgs_ref_nixos-unstable.outPath}/flake.nix").outputs {
      self = unflake_github_nixos_nixpkgs_ref_nixos-unstable;
    }) // deps.unflake_github_nixos_nixpkgs_ref_nixos-unstable // {
      _flake = true;
      outPath = "${deps.unflake_github_nixos_nixpkgs_ref_nixos-unstable.outPath}";
      sourceInfo = deps.unflake_github_nixos_nixpkgs_ref_nixos-unstable;
    };
    unflake_github_nixos_nixpkgs_ref_nixpkgs-unstable = ((import "${deps.unflake_github_nixos_nixpkgs_ref_nixpkgs-unstable.outPath}/flake.nix").outputs {
      self = unflake_github_nixos_nixpkgs_ref_nixpkgs-unstable;
    }) // deps.unflake_github_nixos_nixpkgs_ref_nixpkgs-unstable // {
      _flake = true;
      outPath = "${deps.unflake_github_nixos_nixpkgs_ref_nixpkgs-unstable.outPath}";
      sourceInfo = deps.unflake_github_nixos_nixpkgs_ref_nixpkgs-unstable;
    };
    unflake_github_numtide_flake-utils = ((import "${deps.unflake_github_numtide_flake-utils.outPath}/flake.nix").outputs {
      self = unflake_github_numtide_flake-utils;
      systems = unflake_github_nix-systems_default;
    }) // deps.unflake_github_numtide_flake-utils // {
      _flake = true;
      outPath = "${deps.unflake_github_numtide_flake-utils.outPath}";
      sourceInfo = deps.unflake_github_numtide_flake-utils;
    };
    unflake_github_numtide_nixos-facter-modules = ((import "${deps.unflake_github_numtide_nixos-facter-modules.outPath}/flake.nix").outputs {
      self = unflake_github_numtide_nixos-facter-modules;
    }) // deps.unflake_github_numtide_nixos-facter-modules // {
      _flake = true;
      outPath = "${deps.unflake_github_numtide_nixos-facter-modules.outPath}";
      sourceInfo = deps.unflake_github_numtide_nixos-facter-modules;
    };
    unflake_github_numtide_treefmt-nix = ((import "${deps.unflake_github_numtide_treefmt-nix.outPath}/flake.nix").outputs {
      self = unflake_github_numtide_treefmt-nix;
      nixpkgs = unflake_github_nixos_nixpkgs_ref_nixpkgs-unstable;
    }) // deps.unflake_github_numtide_treefmt-nix // {
      _flake = true;
      outPath = "${deps.unflake_github_numtide_treefmt-nix.outPath}";
      sourceInfo = deps.unflake_github_numtide_treefmt-nix;
    };
    unflake_github_serokell_deploy-rs = ((import "${deps.unflake_github_serokell_deploy-rs.outPath}/flake.nix").outputs {
      self = unflake_github_serokell_deploy-rs;
      flake-compat = unflake_github_edolstra_flake-compat_flake_false;
      nixpkgs = unflake_github_nixos_nixpkgs_ref_nixpkgs-unstable;
      utils = unflake_github_numtide_flake-utils;
    }) // deps.unflake_github_serokell_deploy-rs // {
      _flake = true;
      outPath = "${deps.unflake_github_serokell_deploy-rs.outPath}";
      sourceInfo = deps.unflake_github_serokell_deploy-rs;
    };
    unflake_github_tlater_nix-webapps = ((import "${deps.unflake_github_tlater_nix-webapps.outPath}/flake.nix").outputs {
      self = unflake_github_tlater_nix-webapps;
      flake-parts = unflake_github_hercules-ci_flake-parts;
      nixpkgs = unflake_github_nixos_nixpkgs_ref_nixos-unstable;
      pkgs-by-name-for-flake-parts = unflake_github_drupol_pkgs-by-name-for-flake-parts;
      systems = unflake_github_nix-systems_default;
    }) // deps.unflake_github_tlater_nix-webapps // {
      _flake = true;
      outPath = "${deps.unflake_github_tlater_nix-webapps.outPath}";
      sourceInfo = deps.unflake_github_tlater_nix-webapps;
    };
    unflake_github_vic_import-tree = ((import "${deps.unflake_github_vic_import-tree.outPath}/flake.nix").outputs {
      self = unflake_github_vic_import-tree;
    }) // deps.unflake_github_vic_import-tree // {
      _flake = true;
      outPath = "${deps.unflake_github_vic_import-tree.outPath}";
      sourceInfo = deps.unflake_github_vic_import-tree;
    };
    unflake_sourcehut_-rycee_lazy-apps = ((import "${deps.unflake_sourcehut_-rycee_lazy-apps.outPath}/flake.nix").outputs {
      self = unflake_sourcehut_-rycee_lazy-apps;
      nixpkgs = unflake_github_nixos_nixpkgs_ref_nixpkgs-unstable;
      pre-commit-hooks = unflake_github_cachix_git-hooks-nix;
    }) // deps.unflake_sourcehut_-rycee_lazy-apps // {
      _flake = true;
      outPath = "${deps.unflake_sourcehut_-rycee_lazy-apps.outPath}";
      sourceInfo = deps.unflake_sourcehut_-rycee_lazy-apps;
    };
  };
  inputs = {
    deploy-rs = universe.unflake_github_serokell_deploy-rs;
    disko = universe.unflake_github_nix-community_disko;
    flake-parts = universe.unflake_github_hercules-ci_flake-parts;
    git-hooks = universe.unflake_github_cachix_git-hooks-nix;
    home-manager = universe.unflake_github_nix-community_home-manager;
    import-tree = universe.unflake_github_vic_import-tree;
    infra-private = universe.unflake_github_drupol_infra-private;
    lazy-apps = universe.unflake_sourcehut_-rycee_lazy-apps;
    make-shell = universe.unflake_github_nicknovitski_make-shell;
    nix-oracle-db = universe.unflake_github_drupol_nix-oracle-db;
    nix-webapps = universe.unflake_github_tlater_nix-webapps;
    nixos-facter-modules = universe.unflake_github_numtide_nixos-facter-modules;
    nixos-generators = universe.unflake_github_nix-community_nixos-generators;
    nixos-hardware = universe.unflake_github_nixos_nixos-hardware_ref_master;
    nixpkgs = universe.unflake_github_nixos_nixpkgs_ref_nixos-unstable;
    nixpkgs-master = universe.unflake_github_nixos_nixpkgs_ref_master;
    nixpkgs-unstable = universe.unflake_github_nixos_nixpkgs_ref_nixpkgs-unstable;
    nur = universe.unflake_github_nix-community_nur;
    pkgs-by-name-for-flake-parts = universe.unflake_github_drupol_pkgs-by-name-for-flake-parts;
    plasma-manager = universe.unflake_github_nix-community_plasma-manager;
    systems = universe.unflake_github_nix-systems_default;
    treefmt-nix = universe.unflake_github_numtide_treefmt-nix;
    self = throw "to use inputs.self, write `(import ./unflake.nix).withInputs (inputs: ...)`";
    withInputs = outputs: let self = outputs (inputs // { inherit self; }); in self;
  };
in inputs