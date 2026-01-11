{
  fetchPypi,
  python3Packages,
}:

python3Packages.buildPythonPackage rec {
  pname = "dt8852";
  version = "1.1.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-3WiHJQnlP39CGzxu/sZ1jWcP40tyr2G62H4yYuwS0wA=";
  };

  build-system = with python3Packages; [ setuptools ];

  dependencies = with python3Packages; [
    pyserial
  ];

  pythonImportsCheck = [ "dt8852" ];

  meta = {
  };
}
