{
  colorschemes = {
    dracula.enable = true;
  };
  plugins = {
    auto-session = {
      enable = true;
      extraOptions = {
        pre_save_cmds = [ "lua close_file_tree()" ];
        post_save_cmds = [ "lua open_file_tree()" ];
        post_restore_cmds = [ "lua open_file_tree()" ];
      };
    };
    chadtree = {
      enable = true;
    };
    fugitive = {
      enable = true;
    };
    bufferline = {
      enable = true;
      settings.options = {
        diagnostics = "nvim_lsp";
        offsets = [
          {
            filetype = "CHADTree";
            text = "File Explorer";
            text_align = "center";
            separator = true;
          }
        ];
        close_command = "";
        left_mouse_command = "lua switch_to_buffer(%d)";
        right_mouse_command = "";
        show_buffer_close_icons = false;
      };
    };
    none-ls = {
      enable = true;
    };
    rust-tools = {
      enable = true;
    };
    lsp = {
      enable = true;
      servers = {
        gopls.enable = true;
        clangd.enable = true;
        nixd.enable = true;
        nixd.settings.formatting.command = [ "nixfmt" ];
      };
    };
    lsp-format = {
      enable = true;
    };
    nvim-lightbulb = {
      enable = true;
    };
    lsp-lines = {
      enable = true;
    };
    cmp = {
      enable = true;
    };
    packer = {
      enable = true;
      plugins = [
        "tpope/vim-sleuth"
        "ntpeters/vim-better-whitespace"
      ];
    };
    telescope = {
      enable = true;
      keymaps = {
        "<C-p>" = {
          action = "git_files";
        };
      };
    };
    treesitter = {
      enable = true;
    };
  };
  extraConfigLua = builtins.readFile ./config.lua;
}
