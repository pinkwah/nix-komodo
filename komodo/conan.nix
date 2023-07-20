{ fetchFromGitHub, python, ... }:

# Note:
# Conan has specific dependency demands; check
#     https://github.com/conan-io/conan/blob/master/conans/requirements.txt
#     https://github.com/conan-io/conan/blob/master/conans/requirements_server.txt
# on the release branch/commit we're packaging.
#
# Two approaches are used here to deal with that:
# Pinning the specific versions it wants in `newPython`,
# and using `substituteInPlace conans/requirements.txt ...`
# in `postPatch` to allow newer versions when we know
# (e.g. from changelogs) that they are compatible.

let
  newPython = python.override {
    packageOverrides = self: super: {
      node-semver = super.node-semver.overridePythonAttrs (oldAttrs: rec {
        version = "0.6.1";
        src = oldAttrs.src.override {
          rev = "refs/tags/${version}";
          hash = "sha256-dti9RBf3gC0YK22oCsN8qkYFEMvYsWnnDCTMduakqms=";
        };
        pythonImportsCheck = [ ];
      });
      distro = super.distro.overridePythonAttrs (oldAttrs: rec {
        version = "1.5.0";
        src = oldAttrs.src.override {
          inherit version;
          hash = "sha256-Dlh1auOPvY/DAg1UutuOrhfFudy+04ixe7Vbilko35I=";
        };
      });
    };
  };

in newPython.pkgs.buildPythonApplication rec {
  pname = "conan";
  version = "1.60.1";

  src = fetchFromGitHub {
    owner = "conan-io";
    repo = "conan";
    rev = "refs/tags/${version}";
    hash = "sha256-8duvg+XNiFQnQeTDJmlq3Yd663hUzglDztncyhIMeSs=";
  };

  postPatch = ''
    substituteInPlace conans/requirements.txt \
      --replace 'PyYAML>=3.11, <6.0' 'PyYAML>=3.11'
  '';

  propagatedBuildInputs = with newPython.pkgs; [
    bottle
    colorama
    python-dateutil
    deprecation
    distro
    fasteners
    future
    jinja2
    node-semver
    patch-ng
    pluginbase
    pygments
    pyjwt
    pyyaml
    requests
    six
    tqdm
    urllib3
  ];

  doCheck = false;
}
