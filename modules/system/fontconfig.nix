{ pkgs, ... }:

let
  kalpurush = pkgs.stdenv.mkDerivation {
    pname = "kalpurush";
    version = "1.0";
    # Point this to where you saved the .ttf file
    src = ./pkgs/fonts/Kalpurush.ttf; 
    
    dontUnpack = true;
    installPhase = ''
      mkdir -p $out/share/fonts/truetype
      cp $src $out/share/fonts/truetype/Kalpurush.ttf
    '';
  };
in
{
  fonts.packages = [ kalpurush ];
  fonts.fontconfig = {
    defaultFonts = {
      serif = [ "Noto Serif Bengali" "Kalpurush" ];
      sansSerif = [ "Noto Sans Bengali" "Kalpurush" ];
    };
  };
}

