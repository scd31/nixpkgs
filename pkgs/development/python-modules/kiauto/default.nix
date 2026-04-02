{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  xvfbwrapper,
  psutil,
  kicadPkg,
  kicad,
}:

buildPythonPackage (finalAttrs: {
  pname = "kiauto";
  version = "2.3.9";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "INTI-CMNB";
    repo = "KiAuto";
    rev = "v${finalAttrs.version}";
    hash = "sha256-YCrEntZ7TC0H5ulZzeEdnXIa9dNSYIdql+qHtjmLWAs=";
  };

  build-system = [ setuptools ];

  dependencies = [
    xvfbwrapper
    psutil
    kicadPkg
    kicad
  ];

  postPatch = ''
    substituteInPlace kiauto/misc.py \
      --replace "KICAD_SHARE = '/usr/share/kicad/'" "KICAD_SHARE = '${kicadPkg}'"
  '';

  pythonImportsCheck = [ "kiauto" ];

  meta = {
    description = "Automation scripts for KiCad";
    homepage = "https://github.com/INTI-CMNB/KiAuto";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ scd31 ];
  };
})
