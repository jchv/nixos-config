vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = " "

-- Custom mappings
vim.keymap.set("n", "<Leader>q", ":bp<bar>sp<bar>bn<bar>bd<CR>")
vim.keymap.set("n", "<Leader>g", ":Git<CR>")
vim.keymap.set("n", "<Leader><Left>", ":bp<CR>")
vim.keymap.set("n", "<Leader><Right>",  ":bn<CR>")
vim.keymap.set("n", "<Leader>o", ":Telescope session-lens search_session<CR>")
vim.keymap.set("n", "<Leader>t", ":CHADopen --always-focus<CR>")
vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

-- LSP bindings
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

local function cd_to_argv_dir()
  if vim.fn.argc() ~= 1 then return end
  local argv = vim.fn.argv()[1]
  if argv then
    if vim.fn.isdirectory(argv) == 0 then return end
    vim.cmd.cd(argv)
  end
end

local function is_fm_buffer(buffer)
  return vim.api.nvim_buf_get_option(buffer, "filetype") == "CHADTree"
end

local function is_fm_window(window)
  local buffer = vim.api.nvim_win_get_buf(window)
  return is_fm_buffer(buffer)
end

local function new_window()
  local splitright_old = vim.opt.splitright:get()
  vim.opt.splitright = true
  vim.cmd("vnew")
  vim.opt.splitright = splitright_old
  return vim.api.nvim_get_current_win()
end

local function find_first_non_fm_window()
  local current_win = vim.api.nvim_get_current_win()
  if not is_fm_window(current_win) then
    return current_win
  end
  local tabpage = vim.api.nvim_get_current_tabpage()
  local windows = vim.api.nvim_tabpage_list_wins(tabpage)
  for _, window in ipairs(windows) do
    if not is_fm_window(window) then
      return window
    end
  end
  return new_window()
end

function switch_to_buffer(buffer)
  local window = find_first_non_fm_window()
  vim.api.nvim_win_set_buf(window, buffer)
end

local function is_file_tree_open()
  local buffers = vim.api.nvim_list_bufs()
  for _, buffer in ipairs(buffers) do
    if vim.fn.bufwinnr(buffer) > 0 and vim.api.nvim_buf_get_option(buffer, "filetype") == "CHADTree" then
      return true
    end
  end
  return false
end

function open_file_tree()
  if not is_file_tree_open() then
    chad.Open("--nofocus")
  end
end

local function init_file_tree()
  cd_to_argv_dir()
  open_file_tree()
end

function close_file_tree()
  local buffers = vim.api.nvim_list_bufs()
  for _, buffer in ipairs(buffers) do
    if vim.fn.bufwinnr(buffer) > 0 and vim.api.nvim_buf_get_option(buffer, "filetype") == "CHADTree" then
      vim.api.nvim_buf_delete(buffer, { force = true })
    end
  end
end

-- Set GUI font for Neovide/etc.
-- Otherwise Neovide uses 16pt, which is too big.
vim.o.guifont = "monospace:h12"

-- Go format on save.
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.go" },
  callback = function()
    local params = vim.lsp.util.make_range_params(nil, vim.lsp.util._get_offset_encoding())
    params.context = {only = {"source.organizeImports"}}
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    for _, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, vim.lsp.util._get_offset_encoding())
        else
          vim.lsp.buf.execute_command(r.command)
        end
      end
    end
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.go", "*.rs", "*.nix" },
  callback = function()
    vim.lsp.buf.format({ async = false, timeout_ms = 3000 })
  end,
})
