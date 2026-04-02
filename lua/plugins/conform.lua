return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      cpp = { "clang-format" },
      c = { "clang-format" },
      cuda = { "clang-format" },
    },
    formatters = {
      ["clang-format"] = {
        -- This tells clang-format to use 4 spaces if no .clang-format file exists
        prepend_args = { "--style={BasedOnStyle: LLVM, IndentWidth: 4}" },
      },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
}
