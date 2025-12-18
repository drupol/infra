{
  lib,
  writeScriptBin,
  meshtastic-web,
  caddy,
  ...
}:

writeScriptBin "meshtastic-client" ''
  echo "Starting Meshtastic Web Client on http://0.0.0.0:8888"
  ${lib.getExe caddy} file-server --listen 0.0.0.0:8888 --root ${meshtastic-web}
''
