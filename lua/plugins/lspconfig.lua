return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- 1. Setup Mason to manage external binaries
      require("mason").setup()

      -- 2. Ensure servers are installed automatically
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",        -- Lua (Neovim config)
          "rust_analyzer", -- Rust
          "clangd",        -- C and C++
          "asm_lsp",       -- x86-64 Assembly
          "pyright",       -- Python (optional, common)
          "texlab"         -- Latex
        },
      })

      local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
      vim.env.PATH = mason_bin .. ":" .. vim.env.PATH

      vim.lsp.enable('asm_lsp')
      vim.lsp.enable('rust_analyzer')
      vim.lsp.enable('pyright')

      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' } -- Stop the 'H' hint for 'vim' global
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
          }
        }
      })
      vim.lsp.enable('lua_ls')

      local capabilities = vim.lsp.protocol.make_client_capabilities()

      ---@diagnostic disable-next-line: inject-field
      capabilities.offsetEncoding = { "utf-16" }

      vim.lsp.config('clangd', {
        capabilities = capabilities,
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=never",
          "--completion-style=detailed",
          "--function-arg-placeholders=0",
          "--fallback-style=llvm",
        },
        init_options = {
          usePlaceholders = true,
          completeUnimported = true,
          fallbackFlags = { "-Wall", "-Wextra", "-Wpedantic", "-pthread" }
        }
      })
      vim.lsp.enable('clangd')

      vim.lsp.config('r_language_server', {
        settings = {
          r = {
            lsp = {
              diagnostics = true,
              -- Directly override lintr options here
              lintr_options = {
                line_length_linter = { length = 120 } -- Adjust limit as desired
              }
            }
          }
        }
      })

      vim.lsp.enable('r_language_server')

      -- TexLab Configuration
      vim.lsp.config('texlab', {
        settings = {
          texlab = {
            build = {
              executable = 'latexmk',
              args = { '-pdf', '-interaction=nonstopmode', '-synctex=1', '-shell-escape', '%f' },
              onSave = true,
              forwardSearchAfter = true,
            },
            forwardSearch = {
              executable = 'zathura',
              args = { '--mode', 'fullscreen', '--synctex-forward', '%l:1:%f', '%p' },
            },
            chktex = {
              onOpenAndSave = true, -- Lints your LaTeX code for stylistic errors
            },
            diagnosticsDelay = 300,
          },
        },
      })
      vim.lsp.enable('texlab')
    end
  }
}
