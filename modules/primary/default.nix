{
  infra,
  ...
}:
{
  infra.primary = {
    includes = [
      infra.ai-local
      infra.education
      infra.email
      infra.games
      infra.lora
      infra.messaging
      infra.news
      infra.virtualisation
      infra.winbox
      infra.work
    ];
  };
}
