{
  dt8852,
  python3Packages,
}:

python3Packages.buildPythonPackage rec {
  pname = "sl400-to-influxdb";
  version = "1.1.0";
  pyproject = true;

  src = ./.;

  build-system = with python3Packages; [ hatchling ];

  dependencies = with python3Packages; [
    dt8852
    influxdb-client
    pyserial
  ];

  doCheck = false;

  pythonImportsCheck = [ "sl400_to_influxdb" ];

  meta = {
  };
}
