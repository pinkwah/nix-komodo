{ cwrap, autoconf, perl, pythonPackages, python, buildPythonPackage, gnum4
, fetchFromGitHub, cmake, ninja, conan, which, ecl, xtgeo, cloudevents, SALib, ies
, prefect, ert-storage, qt5, ... }:

buildPythonPackage rec {
  pname = "ert";
  version = "5.0.4";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "equinor";
    repo = pname;
    rev = version;
    hash = "sha256-FTwS/8//nodG+gsyDYhYvKQUb1o/3VK5Qsa19BPxpJU=";
  };

  dontUseCmakeConfigure = true;

  doCheck = false;

  nativeBuildInputs = with pythonPackages; [
    scikit-build
    pybind11
    cmake
    ninja
    qt5.wrapQtAppsHook
  ];

  propagatedBuildInputs = with pythonPackages; [
    qt5.qtbase
    SALib
    aiofiles
    aiohttp
    alembic
    ansicolors
    async_generator
    beartype
    cloudevents
    cloudpickle
    cryptography
    cwrap
    dask-jobqueue
    decorator
    deprecation
    dnspython
    ecl
    fastapi
    filelock
    httpx
    jinja2
    lark
    matplotlib
    netcdf4
    numpy
    numpy
    packaging
    pandas
    pandas
    pluggy
    protobuf3
    psutil
    pydantic
    prefect
    pyqt5
    pyrsistent
    python-dateutil
    pyyaml
    qtpy
    requests
    scipy
    sqlalchemy
    tables
    tqdm
    typing-extensions
    uvicorn
    websockets
    xarray
    xtgeo
    ert-storage
    ies
  ];

  prePatch = ''
    export CONAN_USER_HOME=$(mktemp -d)
    mkdir -p $CONAN_USER_HOME
    cat > $CONAN_USER_HOME/conan <<EOF
      #!/bin/sh
      unset PYTHONPATH
      export PYTHONPATH="${conan}/lib/python3.10/site-packages"
      exec "${conan}/bin/.conan-wrapped" "\$@"
    EOF
    chmod +x $CONAN_USER_HOME/conan
    export PATH=$CONAN_USER_HOME:$PATH

    substituteInPlace src/clib/CMakeLists.txt --replace missing all
  '';

  preConfigure = ''
    export _kmd_PYTHONPATH=$PYTHONPATH
    export PYTHONPATH=${pythonPackages.grpcio-tools}/lib/${python.libPrefix}/site-packages:$PYTHONPATH
  '';

  preInstall = ''
    export PYTHONPATH=$_kmd_PYTHONPATH

    rm -rf /tmp/zohar
    cp -r $PWD/.. /tmp/zohar
  '';

  dontWrapQtApps = true;

  preFixup = ''
    qtWrapperArgs+=("''${gappsWrapperArgs[@]}")
    wrapQtApp $out/bin/ert
  '';

  SETUPTOOLS_SCM_PRETEND_VERSION = version;
}
