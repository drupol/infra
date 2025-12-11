let
  deps = rec {
    unflake_github_cachix_git-hooks-nix = builtins.fetchTree {
      type = "github";
      owner = "cachix";
      repo = "git-hooks.nix";
      rev = "09e45f2598e1a8499c3594fe11ec2943f34fe509";
      lastModified = 1765464257;
      narHash = "sha256-dixPWKiHzh80PtD0aLuxYNQ0xP+843dfXG/yM3OzaYQ=";
    };
    unflake_github_drupol_infra-private = builtins.fetchTree {
      type = "github";
      owner = "drupol";
      repo = "infra-private";
      rev = "48ed44c8958b8ad6ff249fa11e9d20586e67edc4";
      lastModified = 1762948688;
      narHash = "sha256-VDA9YC5V1rPHkBq8ZLyyzbT7/YVTMHtIdc4UHC9u4nQ=";
    };
    unflake_github_drupol_pkgs-by-name-for-flake-parts = builtins.fetchTree {
      type = "github";
      owner = "drupol";
      repo = "pkgs-by-name-for-flake-parts";
      rev = "477b3e8f981e3d7bac9d297e64796c918942f744";
      lastModified = 1743779435;
      narHash = "sha256-5eaQ3iKcwUbLw7pOJJqV85qgf5L+ihfsISrifGM7czQ=";
    };
    unflake_github_edolstra_flake-compat = builtins.fetchTree {
      type = "github";
      owner = "edolstra";
      repo = "flake-compat";
      rev = "65f23138d8d09a92e30f1e5c87611b23ef451bf3";
      lastModified = 1765121682;
      narHash = "sha256-4VBOP18BFeiPkyhy9o4ssBNQEvfvv1kXkasAYd0+rrA=";
    };
    unflake_github_hercules-ci_flake-parts = builtins.fetchTree {
      type = "github";
      owner = "hercules-ci";
      repo = "flake-parts";
      rev = "5635c32d666a59ec9a55cab87e898889869f7b71";
      lastModified = 1765495779;
      narHash = "sha256-MhA7wmo/7uogLxiewwRRmIax70g6q1U/YemqTGoFHlM=";
    };
    unflake_github_hercules-ci_gitignore-nix = builtins.fetchTree {
      type = "github";
      owner = "hercules-ci";
      repo = "gitignore.nix";
      rev = "cb5e3fdca1de58ccbc3ef53de65bd372b48f567c";
      lastModified = 1762808025;
      narHash = "sha256-XmjITeZNMTQXGhhww6ed/Wacy2KzD6svioyCX7pkUu4=";
    };
    unflake_github_nicknovitski_make-shell = builtins.fetchTree {
      type = "github";
      owner = "nicknovitski";
      repo = "make-shell";
      rev = "ffeceae9956df03571ea8e96ef77c2924f13a63c";
      lastModified = 1733933815;
      narHash = "sha256-9JjM7eT66W4NJAXpGUsdyAFXhBxFWR2Z9LZwUa7Hli0=";
    };
    unflake_github_nix-community_disko = builtins.fetchTree {
      type = "github";
      owner = "nix-community";
      repo = "disko";
      rev = "d64e5cdca35b5fad7c504f615357a7afe6d9c49e";
      lastModified = 1765326679;
      narHash = "sha256-fTLX9kDwLr9Y0rH/nG+h1XG5UU+jBcy0PFYn5eneRX8=";
    };
    unflake_github_nix-community_home-manager = builtins.fetchTree {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      rev = "d787ec69c3216ea33be1c0424fe65cb23aa8fb31";
      lastModified = 1765606130;
      narHash = "sha256-KOP4QnkiRwiD5KEOr6ceF67rfTP1OqPmCCft6xDC3k4=";
    };
    unflake_github_nix-community_nixpkgs-lib = builtins.fetchTree {
      type = "github";
      owner = "nix-community";
      repo = "nixpkgs.lib";
      rev = "e0cad9791b0c168931ae562977703b72d9360836";
      lastModified = 1765070080;
      narHash = "sha256-5D1Mcm2dQ1aPzQ0sbXluHVUHququ8A7PKJd7M3eI9+E=";
    };
    unflake_github_nix-community_nur = builtins.fetchTree {
      type = "github";
      owner = "nix-community";
      repo = "nur";
      rev = "bfc3a779688933d29c41a9b730d46ff7b212e08a";
      lastModified = 1765615934;
      narHash = "sha256-J+NuD3qJ2GEI34D6jzLWHa8uKsrw7lgDsSz3M3+OY4k=";
    };
    unflake_github_nix-community_plasma-manager = builtins.fetchTree {
      type = "github";
      owner = "nix-community";
      repo = "plasma-manager";
      rev = "b24ed4b272256dfc1cc2291f89a9821d5f9e14b4";
      lastModified = 1763909441;
      narHash = "sha256-56LwV51TX/FhgX+5LCG6akQ5KrOWuKgcJa+eUsRMxsc=";
    };
    unflake_github_nix-systems_default = builtins.fetchTree {
      type = "github";
      owner = "nix-systems";
      repo = "default";
      rev = "da67096a3b9bf56a91d16901293e51ba5b49a27e";
      lastModified = 1681028828;
      narHash = "sha256-Vy1rq5AaRuLzOxct8nz4T6wlgyUR7zLU309k9mBC768=";
    };
    unflake_github_nixos_nixos-hardware_ref_master = builtins.fetchTree {
      type = "github";
      owner = "nixos";
      repo = "nixos-hardware";
      rev = "9154f4569b6cdfd3c595851a6ba51bfaa472d9f3";
      lastModified = 1764440730;
      narHash = "sha256-ZlJTNLUKQRANlLDomuRWLBCH5792x+6XUJ4YdFRjtO4=";
    };
    unflake_github_nixos_nixpkgs_ref_master = builtins.fetchTree {
      type = "github";
      owner = "nixos";
      repo = "nixpkgs";
      rev = "8b7992dc36bf0184d2164685b909efdb02ef46f4";
      lastModified = 1765614097;
      narHash = "sha256-XV/bJATQqeGWkwSOwAaglqQUjowAqr3ZrkzR2tv27iU=";
    };
    unflake_github_nixos_nixpkgs_ref_nixos-unstable = builtins.fetchTree {
      type = "github";
      owner = "nixos";
      repo = "nixpkgs";
      rev = "2fbfb1d73d239d2402a8fe03963e37aab15abe8b";
      lastModified = 1765472234;
      narHash = "sha256-9VvC20PJPsleGMewwcWYKGzDIyjckEz8uWmT0vCDYK0=";
    };
    unflake_github_nixos_nixpkgs_ref_nixpkgs-unstable = builtins.fetchTree {
      type = "github";
      owner = "nixos";
      repo = "nixpkgs";
      rev = "5d6bdbddb4695a62f0d00a3620b37a15275a5093";
      lastModified = 1765425892;
      narHash = "sha256-jlQpSkg2sK6IJVzTQBDyRxQZgKADC2HKMRfGCSgNMHo=";
    };
    unflake_github_numtide_nixos-facter-modules = builtins.fetchTree {
      type = "github";
      owner = "numtide";
      repo = "nixos-facter-modules";
      rev = "9dd775ee92de63f14edd021d59416e18ac2c00f1";
      lastModified = 1765442039;
      narHash = "sha256-k3lYQ+A1F7aTz8HnlU++bd9t/x/NP2A4v9+x6opcVg0=";
    };
    unflake_github_numtide_treefmt-nix = builtins.fetchTree {
      type = "github";
      owner = "numtide";
      repo = "treefmt-nix";
      rev = "5b4ee75aeefd1e2d5a1cc43cf6ba65eba75e83e4";
      lastModified = 1762938485;
      narHash = "sha256-AlEObg0syDl+Spi4LsZIBrjw+snSVU4T8MOeuZJUJjM=";
    };
    unflake_github_tlater_nix-webapps = builtins.fetchTree {
      type = "github";
      owner = "tlater";
      repo = "nix-webapps";
      rev = "1bb9ee8e3f428575c1c6898ae7af8d96416d696a";
      lastModified = 1734815698;
      narHash = "sha256-dH1QJJ5TyPVH9kvvGsHufwY0evWeayaaUl/Ge3X3OYs=";
    };
    unflake_github_vic_import-tree = builtins.fetchTree {
      type = "github";
      owner = "vic";
      repo = "import-tree";
      rev = "3c23749d8013ec6daa1d7255057590e9ca726646";
      lastModified = 1763762820;
      narHash = "sha256-ZvYKbFib3AEwiNMLsejb/CWs/OL/srFQ8AogkebEPF0=";
    };
    unflake_git_https---codeberg-org-FrdrCkII-falake-git = builtins.fetchTree {
      type = "git";
      url = "https://codeberg.org/FrdrCkII/falake.git";
      rev = "70761ee62e87537ad428903186146a8a773b7701";
      revCount = 15;
      lastModified = 1765515769;
      narHash = "sha256-iv+e0i2g9GyA6ZnnSmlv8xxjS2eVq2EklPuXkHVW53o=";
    };
    unflake_github_edolstra_flake-compat_flake_false = unflake_github_edolstra_flake-compat;
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
    unflake_git_https---codeberg-org-FrdrCkII-falake-git = ((import "${deps.unflake_git_https---codeberg-org-FrdrCkII-falake-git.outPath}/flake.nix").outputs {
      self = unflake_git_https---codeberg-org-FrdrCkII-falake-git;
    }) // deps.unflake_git_https---codeberg-org-FrdrCkII-falake-git // {
      _flake = true;
      outPath = "${deps.unflake_git_https---codeberg-org-FrdrCkII-falake-git.outPath}";
      sourceInfo = deps.unflake_git_https---codeberg-org-FrdrCkII-falake-git;
    };
  };
  inputs = {
    disko = universe.unflake_github_nix-community_disko;
    falake = universe.unflake_git_https---codeberg-org-FrdrCkII-falake-git;
    git-hooks = universe.unflake_github_cachix_git-hooks-nix;
    home-manager = universe.unflake_github_nix-community_home-manager;
    import-tree = universe.unflake_github_vic_import-tree;
    infra-private = universe.unflake_github_drupol_infra-private;
    make-shell = universe.unflake_github_nicknovitski_make-shell;
    nix-webapps = universe.unflake_github_tlater_nix-webapps;
    nixos-facter-modules = universe.unflake_github_numtide_nixos-facter-modules;
    nixos-hardware = universe.unflake_github_nixos_nixos-hardware_ref_master;
    nixpkgs = universe.unflake_github_nixos_nixpkgs_ref_nixos-unstable;
    nixpkgs-master = universe.unflake_github_nixos_nixpkgs_ref_master;
    nixpkgs-unstable = universe.unflake_github_nixos_nixpkgs_ref_nixpkgs-unstable;
    nur = universe.unflake_github_nix-community_nur;
    pkgs-by-name-for-flake-parts = universe.unflake_github_drupol_pkgs-by-name-for-flake-parts;
    plasma-manager = universe.unflake_github_nix-community_plasma-manager;
    systems = universe.unflake_github_nix-systems_default;
    treefmt-nix = universe.unflake_github_numtide_treefmt-nix;
    self = throw "to use inputs.self, write `import ./unflake.nix (inputs: ...)`";
    withInputs = outputs: let self = outputs (inputs // { inherit self; }); in self;
    __functor = self: self.withInputs;
  };
in inputs