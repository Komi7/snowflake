{ pkgs, ... }:

let
  kalpurush = pkgs.stdenv.mkDerivation {
    pname = "kalpurush";
    version = "1.0";
    src = ./pkgs/fonts/Kalpurush.ttf; 
    
    dontUnpack = true;
    installPhase = ''
      mkdir -p $out/share/fonts/truetype
      cp $src $out/share/fonts/truetype/Kalpurush.ttf
    '';
  };
in
{
  fonts.packages = with pkgs; [ 
    kalpurush
    nerd-fonts.jetbrains-mono 
    nerd-fonts.symbols-only
    noto-fonts # This includes Bengali support by default
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [ "Noto Serif Bengali" "Kalpurush" "JetBrainsMono Nerd Font" ];
      sansSerif = [ "Noto Sans Bengali" "Kalpurush" "JetBrainsMono Nerd Font" ];
      monospace = [ "JetBrainsMono Nerd Font" ];
    };
  };
}
