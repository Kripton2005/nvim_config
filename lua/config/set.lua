vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "100"

vim.opt.clipboard = "unnamedplus"

vim.g.mapleader = " "
vim.g.maplocalleader = "/"

-- for nvim-tree, we disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.sessionoptions:append("terminal")

-- How long (in milliseconds) of nothing happening before diagnostics update
vim.opt.updatetime = 300

-- Configure how diagnostics behave
vim.diagnostic.config({
  underline = true,
  virtual_text = true,      -- Shows the error message next to the code
  update_in_insert = false, -- Keep this false for performance, but it refreshes on Esc
  severity_sort = true,
})

-- Optional: Improve the completion menu experience
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Start scrolling when the cursor is 8 characters away from the screen edge
vim.opt.sidescrolloff = 8
-- Scroll 1 character at a time (smoother than jumping)
vim.opt.sidescroll = 1

local home = vim.fn.expand("~")
local venv_path = home .. "/work_env"
local venv_python = venv_path .. "/bin/python"

vim.g.python3_host_prog = venv_python

vim.opt.backupcopy = "yes"

vim.opt.guicursor = "v-c-i:ver25"

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.py",
  callback = function(args)
    -- Tell Neovim to format using the client named "ruff"
    vim.lsp.buf.format({
      bufnr = args.buf,
      id = vim.lsp.get_clients({ name = "ruff", bufnr = args.buf })[1].id,
      async = false
    })
  end,
})
