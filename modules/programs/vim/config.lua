vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = " "

-- Custom mappings
vim.keymap.set("n", "<Leader>q", ":bp<bar>sp<bar>bn<bar>bd<CR>")
vim.keymap.set("n", "<Leader>g", ":Git<CR>")
vim.keymap.set("n", "<Leader><Left>", ":bp<CR>")
vim.keymap.set("n", "<Leader><Right>",  ":bn<CR>")
vim.keymap.set("n", "<Leader>o", ":Telescope session-lens search_session<CR>")
vim.keymap.set("n", "<Leader>t", ":CHADopen<CR>")

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
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.rs", "*.go" },
  callback = function()
    vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
    vim.lsp.buf.format({ async = false, timeout_ms = 5000 })
  end,
  group = vim.api.nvim_create_augroup("lsp_format", { clear = true }),
  desc = "Format on Save",
})
