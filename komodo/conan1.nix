{ lib
, stdenv
, fetchFromGitHub
, git
, pkg-config
, python3
, zlib
}:

python3.pkgs.buildPythonApplication rec {
  pname = "conan1";
  version = "1.60.1";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "conan-io";
    repo = "conan";
    rev = "refs/tags/${version}";
    hash = "sha256-+ohUOQ9WBER/X0TDklf/qZCm9LhM1I1QRmED4FnkweM=";
  };

  propagatedBuildInputs = with python3.pkgs; [
    bottle
    colorama
    python-dateutil
    distro
    fasteners
    jinja2
    patch-ng
    pluginbase
    pygments
    pyjwt
    pyyaml
    requests
    tqdm
    urllib3
  ] ++ lib.optionals stdenv.isDarwin [
    idna
    cryptography
    pyopenssl
  ];

  __darwinAllowLocalNetworking = true;

  doCheck = false;

  meta = with lib; {
    description = "Decentralized and portable C/C++ package manager";
    homepage = "https://conan.io";
    changelog = "https://github.com/conan-io/conan/releases/tag/${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ HaoZeke ];
  };
}
