{
  colorschemes = {
    dracula.enable = true;
  };
  plugins = {
    auto-session = {
      enable = true;
      extraOptions = {
        pre_save_cmds = ["lua close_file_tree()"];
        post_save_cmds = ["lua open_file_tree()"];
        post_restore_cmds = ["lua open_file_tree()"];
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
      diagnostics = "nvim_lsp";
      offsets = [
        {
          filetype = "CHADTree";
          text = "File Explorer";
          text_align = "center";
          separator = true;
        }
      ];
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
        nixd.enable = true;
        gopls.enable = true;
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
    nvim-cmp = {
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
  };
  extraConfigLua = builtins.readFile ./config.lua;
}
