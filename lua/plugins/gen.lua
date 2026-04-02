return {
  "David-Kunz/gen.nvim",
  opts = {
    -- 1. Use the specific version instead of :latest for stability
    model = "qwen2.5-coder:7b",
    display_mode = "float",
    show_model = true,
    no_auto_close = false,
    -- 2. Ensure the port is explicitly defined (Ollama 2026 sometimes flips ipv6/ipv4)
    host = "localhost",
    port = "11434",
  },

  config = function(_, opts)
    local gen = require("gen")
    gen.setup(opts)

    -- 3. Custom Prompt (Fixed Syntax)
    gen.prompts['Review_Text'] = {
      prompt = "Regarding the following text:\n$text\n\n" ..
          "Is there anything technically wrong? " ..
          "Are there spelling mistakes? " ..
          "Are there potential ambiguities and improvements?",
      replace = false,
    }

    -- 4. Fixed Keymaps: Visual mode mapping needs <cmd> for cleaner execution in 2026
    vim.keymap.set('v', '<leader>a', ':Gen Review_Text<CR>', { silent = true, desc = "AI Review" })
    vim.keymap.set('v', '<leader>b', ':Gen Ask<CR>', { silent = true, desc = "AI Ask" })
  end,
}
