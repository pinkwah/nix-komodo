{ pythonPackages, buildPythonPackage, fetchurl, ... }:

buildPythonPackage rec {
  pname = "prefect";
  version = "1.4.1";
  format = "wheel";

  src = fetchurl {
    url =
      "https://files.pythonhosted.org/packages/68/10/637038b282a122426f245c9ee31c3fe853fd5509df7b74d2a9e075ab0e54/prefect-1.4.1-py3-none-any.whl";
    hash = "sha256-qDjUJ6iIRbEyebibkl4ras3l/yuwkMVIBhe8YEeoCKg=";
  };

  doCheck = false;

  propagatedBuildInputs = with pythonPackages; [
    click
    cloudpickle
    croniter
    dask
    distributed
    importlib-resources
    docker
    mypy-extensions
    marshmallow
    marshmallow-oneofschema
    msgpack
    packaging
    pendulum
    python-dateutil
    pyyaml
    python-box
    python-slugify
    pytz
    requests
    tabulate
    toml
    urllib3
  ];
}
