{
  inputs,
  ...
}:
{
  flake-file.inputs = {
    files = {
      url = "github:sini/files";
    };
  };

  imports = [
    inputs.files.flakeModule
  ];

  perSystem = {
    files = {
      generateApp = true;
      treefmt.enable = true;
    };
  };
}
