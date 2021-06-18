{ lib
, substituteAll
, buildPythonPackage
, fetchPypi
, cmake
, cxxopts
, ghc_filesystem
, pybind11
, pythonOlder
, psutil
, setuptools-scm
}:

buildPythonPackage rec {
  pname = "chiapos";
  version = "1.0.3";
  disabled = pythonOlder "3.7";

  src = fetchPypi {
    inherit pname version;
    sha256 = "d987b481a3acbff1e0d77eb713af8d99ecec2bd11c2c465528a5078a433686bd";
  };

  patches = [
    # prevent CMake from trying to get libraries on the Internet
    (substituteAll {
      src = ./dont_fetch_dependencies.patch;
      inherit cxxopts ghc_filesystem;
      pybind11_src = pybind11.src;
    })
  ];

  nativeBuildInputs = [ cmake setuptools-scm ];

  buildInputs = [ pybind11 ];

  checkInputs = [ psutil ];

  # CMake needs to be run by setuptools rather than by its hook
  dontConfigure = true;

  meta = with lib; {
    description = "Chia proof of space library";
    homepage = "https://www.chia.net/";
    license = licenses.asl20;
    maintainers = teams.chia.members;
  };
}
