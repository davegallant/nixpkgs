{lib, stdenv, fetchurl} :

stdenv.mkDerivation {
  name = "jdom-1.0";

  src = fetchurl {
    url = "http://www.jdom.org/dist/binary/jdom-1.0.tar.gz";
    sha256 = "1igmxzcy0s25zcy9vmcw0kd13lh60r0b4qg8lnp1jic33f427pxf";
  };

  dontUnpack = true;

  installPhase = ''
    tar zxvf $src
    mkdir -p $out
    mv * $out
  '';

  meta = with lib; {
    description = "Java-based solution for accessing, manipulating, and outputting XML data from Java code";
    homepage = "http://www.jdom.org";
    platforms = platforms.unix;
    license = licenses.bsdOriginal;
  };
}
