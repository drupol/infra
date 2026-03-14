{ den, lib, ... }:
{
  den.schema = {
    user.classes = lib.mkDefault [ "homeManager" ];
  };

  den.aspects.base = {
    includes = [
      den.provides.define-user
    ];
  };

  # TODO: why I cannot use this in `den.aspects.base.includes` ?
  den.default.includes = [
    (den.lib.take.exactly (
      { host }:
      {
        ${host.class}.networking.hostName = host.hostName;
      }
    ))
  ];
}
