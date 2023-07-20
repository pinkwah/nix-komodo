{ pythonPackages, buildPythonPackage, fetchurl, ... }:

buildPythonPackage rec {
  pname = "ert-storage";
  version = "0.3.22";
  format = "wheel";

  src = fetchurl {
    url =
      "https://files.pythonhosted.org/packages/5a/2b/ea61bbedcfa9b69fb58abd3fb26500920637b016903e1c4188669d3e4f2c/ert_storage-0.3.22-py3-none-any.whl";
    hash = "sha256-ii+L7dqlxGRR/a1rISfVkJz1ZyhCz4hwn2++IRogO2w=";
  };

  doCheck = false;

  propagatedBuildInputs = with pythonPackages; [
    alembic
    fastapi
    pydantic
    uvicorn
    pyarrow
    pandas
    pydantic
    python-multipart
    requests
    sqlalchemy
    uvicorn
  ];
}
