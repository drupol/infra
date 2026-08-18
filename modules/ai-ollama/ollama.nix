{
  den.aspects.ai-ollama = {
    nixos = {
      services = {
        ollama = {
          enable = true;
          host = "0.0.0.0";
          openFirewall = true;
        };
      };
    };
  };
}
