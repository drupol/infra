{
  inputs,
  ...
}:
{
  imports = [
    inputs.files.flakeModule
  ];

  perSystem = {
    files.generateApp = true;
  };
}
