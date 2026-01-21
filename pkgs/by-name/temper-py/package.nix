{
  python3Packages,
  fetchFromGitHub,
}:

python3Packages.buildPythonApplication {
  pname = "temper-py";
  version = "0.0.4-unstable-2025-01-31";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "ccwienk";
    repo = "temper";
    rev = "60889bf473e6e580c54250b55fd263bf06157ed8";
    hash = "sha256-KzDkBA/a/z3riEc57end4/JPP32efg096YxlUIomx3A=";
  };

  build-system = with python3Packages; [
    setuptools
  ];

  dependencies = with python3Packages; [
    pyserial
  ];

  pythonImportsCheck = [ "temper" ];

  meta = {
    mainProgram = "temper";
  };
}
