{
  flake.modules.nixos.base = {
    # https://mastodon.online/@nomeata/109915786344697931
    documentation = {
      enable = false;
      doc.enable = false;
      info.enable = false;
    };
  };
}
