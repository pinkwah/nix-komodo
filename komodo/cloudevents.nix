{ pythonPackages, buildPythonPackage, fetchurl, ... }:

buildPythonPackage rec {
  pname = "cloudevents";
  version = "1.9.0";
  format = "wheel";

  src = fetchurl {
    url =
      "https://files.pythonhosted.org/packages/58/e9/6216b3557fa6b4729d11763651c85e1d70f600147edbd6ec49f826309a28/cloudevents-1.9.0-py3-none-any.whl";
    hash = "sha256-EBFFnVbY8BhKRkVvXXJjKiVl8YFx5Rsz4G9kPnI9MMk=";
  };

  doCheck = false;

  propagatedBuildInputs = with pythonPackages; [ deprecation ];

  SETUPTOOLS_SCM_PRETEND_VERSION = version;
}
