# Source: https://github.com/davegallant/nix-config/blob/main/litellm/models/copilot.nix
# GitHub Copilot models exposed via LiteLLM.
# Refreshed via:
#   TOKEN=$(sudo cat /var/lib/litellm/.config/litellm/github_copilot/access-token)
#   curl -s https://api.githubcopilot.com/models \
#     -H "Authorization: Bearer $TOKEN" \
#     -H "Editor-Version: vscode/1.95.0" \
#     -H "Copilot-Integration-Id: vscode-chat" | jq '.data[].id'
[
  "claude-haiku-4.5"
  "claude-opus-4.5"
  "claude-opus-4.6"
  "claude-opus-4.7"
  "claude-sonnet-4"
  "claude-sonnet-4.5"
  "claude-sonnet-4.6"
  "gemini-2.5-pro"
  "gemini-3-flash-preview"
  "gemini-3.1-pro-preview"
  "gpt-3.5-turbo"
  "gpt-4"
  "gpt-4.1"
  "gpt-4o"
  "gpt-4o-mini"
  "gpt-5-mini"
  "gpt-5.2"
  "gpt-5.2-codex"
  "gpt-5.3-codex"
  "gpt-5.4"
  "gpt-5.4-mini"
  "grok-code-fast-1"
]
