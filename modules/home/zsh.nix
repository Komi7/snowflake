{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Your custom shell aliases
    shellAliases = {
      ll = "ls -l";
      v = "nvim";
      ff = "fastfetch";
      # Standalone Rebuild Shortcuts
      up-sys = "sudo nixos-rebuild switch --flake .#KOMI";
      up-user = "home-manager switch --flake .#shousuke";
      clean = "sudo nix-collect-garbage -d";
    };

    # Oh-My-Zsh settings
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" "docker" ];
      theme = "robbyrussell";
    };

    # Custom logic (like running fastfetch on startup)
    initContent = ''
      # Fastfetch on startup if in a standard terminal
      if [[ -z "$VTE_VERSION" && "$TERM" != "dumb" ]]; then
        fastfetch
      fi
    '';
  };
}
