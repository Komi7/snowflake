{ pkgs, ... }:

{
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        # --- Core UI & Theme ---
        theme = {
          enable = true;
          name = "catppuccin";
          style = "mocha";
        };
        statusline.lualine.enable = true;
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;
        filetree.nvimTree.enable = true;

        # --- Visuals ---
        visuals = {
          nvimWebDevicons.enable = true;
          indentBlankline.enable = true;
        };

        # --- LSP & Languages ---
        lsp = {
          formatOnSave = true;
          lightbulb.enable = true;
        };

        languages = {
          enableLSP = true;
          enableTreesitter = true;
          enableFormat = true;

          # Toggle languages here
          nix.enable = true;
          python.enable = true;
          rust.enable = true;
          ts.enable = true; # TypeScript/JS
          markdown.enable = true;
        };

        # --- Utility ---
        terminal.toggleterm = {
          enable = true;
          lazygit.enable = true;
        };
        assistant.copilot.enable = false; # Set to true if you use it
      };
    };
  };
}
