# Interception tools plugins package
{ stdenv, gcc }:

# Based on https://github.com/vyp/dots/blob/98cd30599945d11ed9a2b10e52487b6581995e2d/interception-tools/plugins/default.nix

# NOTE: menutosuper does not work, it is not compiled here

stdenv.mkDerivation rec {
  name = "interception-tools-plugins-${version}";
  version = "2024-03-14";

  src = ./.;

  buildPhase = ''
    gcc -o enter+rightctrl enter+rightctrl.c
    gcc -o rightctrltosuper rightctrltosuper.c
    gcc -o capstoesc capstoesc.c
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp enter+rightctrl $out/bin
    cp rightctrltosuper $out/bin
    cp capstoesc $out/bin
  '';
}
