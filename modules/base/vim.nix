{ pkgs, ... }: {
  config =
  let
    vim = pkgs.lunarvim.override {
      viAlias = true;
      vimAlias = true;
      nvimAlias = true;
      globalConfig = ''
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
          vim.cmd "Neotree toggle"
        end

        -- Open tree by default.
        vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_neotree })

        -- Set GUI font for Neovide/etc.
        -- Otherwise Neovide uses 16pt, which is too big.
        vim.o.guifont = "monospace:h12"

        lvim.plugins = {
          -- Install suda plugin for safer editing of system files.
          { "lambdalisue/suda.vim" },
          -- Install toggleterm for convenient terminal pane
          {
            "akinsho/toggleterm.nvim",
            config = function()
              -- Set up toggleterm.
              require("toggleterm").setup{
                open_mapping = [[<C-`>]],
                insert_mappings = true,
                terminal_mappings = true,
                direction = 'horizontal',
                winbar = {
                  enabled = true,
                  name_formatter = function(term)
                    return term.name
                  end
                },
              }
            end,
          },
          -- Install better whitespace
          { "ntpeters/vim-better-whitespace" },
          -- Neotree instead of nvim-tree
          {
            "nvim-neo-tree/neo-tree.nvim",
            branch = "v2.x",
            dependencies = {
              "nvim-lua/plenary.nvim",
              "nvim-tree/nvim-web-devicons",
              "MunifTanjim/nui.nvim",
            },
            config = function()
              require("neo-tree").setup({
                source_selector = {
                  winbar = true,
                },
                close_if_last_window = true,
                window = {
                  width = 30,
                },
                buffers = {
                  follow_current_file = true,
                },
                filesystem = {
                  follow_current_file = true,
                  filtered_items = {
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    hide_by_name = {
                      "node_modules"
                    },
                    never_show = {
                      ".DS_Store",
                      "thumbs.db"
                    },
                  },
                },
              })
            end
          },
        }
        -- Enable smart edit for better ergonomics editing system files.
        vim.g.suda_smart_edit = 1
        -- Enable format-on-save.
        lvim.format_on_save.enabled = true
        lvim.format_on_save.pattern = { "*.go" }
        -- Use Neotree instead of nvim-tree.
        lvim.builtin.nvimtree.active = false
      '';
    };
  in {
    environment.systemPackages = [ vim ];
  };
}
