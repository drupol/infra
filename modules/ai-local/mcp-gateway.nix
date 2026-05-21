{
  den.aspects.ai-local = {
    homeManager = {
      imports = [
        ./_mcp-gateway-config.nix
      ];

      services.mcp-gateway = {
        enable = true;
        enableMcpIntegration = true;
        settings = {
          meta_mcp = {
            enabled = true;
            cache_tools = true;
            cache_ttl = "400s";
          };
        };
      };
    };
  };
}
