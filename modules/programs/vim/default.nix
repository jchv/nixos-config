{ ... }: {
  config = {
    programs.nixvim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      plugins = {
        neo-tree = {
          enable = true;
          closeIfLastWindow = true;
	  sourceSelector.winbar = true;
	};
	bufferline = {
	  enable = true;
	};
	lightline = {
	  enable = true;
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
	  plugins = [ "tpope/vim-sleuth" ];
	};
      };
      extraConfigLua = ''
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        local function cd_to_argv_dir()
          if vim.fn.argc() ~= 1 then return end
          local argv = vim.fn.argv()[1]
          if argv then
            if vim.fn.isdirectory(argv) == 0 then return end
            vim.cmd.cd(argv)
          end
        end

        local function open_neotree()
          cd_to_argv_dir()
          vim.cmd "Neotree show"
        end

        -- Open tree by default.
        vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_neotree })

        -- Set GUI font for Neovide/etc.
        -- Otherwise Neovide uses 16pt, which is too big.
        vim.o.guifont = "monospace:h12"
      '';
    };
  };
}