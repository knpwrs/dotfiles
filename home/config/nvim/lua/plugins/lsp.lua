return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "typos-lsp",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()

      -- Remove all default lsp keymaps
      for i = #keys, 1, -1 do
        table.remove(keys, i)
      end

      -- And use custom keymaps!
      -- stylua: ignore start
      keys[#keys + 1] = { "<leader>ld", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition", has = "definition" }
      keys[#keys + 1] = { "<leader>lD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" }
      keys[#keys + 1] = { "<leader>ly", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" }
      keys[#keys + 1] = { "<leader>lr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" }
      keys[#keys + 1] = { "<leader>li", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" }
      keys[#keys + 1] = { "<leader>lr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" }
      keys[#keys + 1] = { "<leader>lk", vim.lsp.buf.hover, desc = "Hover" }
      keys[#keys + 1] = { "<leader>lK", vim.lsp.buf.hover, desc = "Signature Help", has = "signatureHelp" }
      keys[#keys + 1] = { "<c-k>", function() return vim.lsp.buf.signature_help() end, mode = "i", desc = "Signature Help", has = "signatureHelp" }
      keys[#keys + 1] = { "<leader>ll", vim.diagnostic.open_float, desc = "Show Line Diagnostics" }
      keys[#keys + 1] = { "<leader>lR", "<cmd>LspRestart<cr>", desc = "Restart LSP" }
      keys[#keys + 1] = { "<leader>lm", vim.lsp.buf.rename, desc = "Rename", has = "rename" }
      keys[#keys + 1] = { "<leader>lM", function() Snacks.rename.rename_file() end, desc = "Rename File", mode ={"n"}, has = { "workspace/didRenameFiles", "workspace/willRenameFiles" } }
      keys[#keys + 1] = { "<leader>le", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" }
      keys[#keys + 1] = { "<leader>lE", LazyVim.lsp.action.source, desc = "Source Action", has = "codeAction" }
      keys[#keys + 1] = { "<leader>lc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" }, has = "codeLens" }
      keys[#keys + 1] = { "<leader>lC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" }, has = "codeLens" }
      keys[#keys + 1] = { "<leader>ls", function() Snacks.picker.lsp_symbols({ filter = LazyVim.config.kind_filter }) end, desc = "LSP Symbols", has = "documentSymbol" }
      keys[#keys + 1] = { "<leader>lS", function() Snacks.picker.lsp_workspace_symbols({ filter = LazyVim.config.kind_filter }) end, desc = "LSP Workspace Symbols", has = "workspace/symbols" }
      keys[#keys + 1] = { "]]", function() Snacks.words.jump(vim.v.count1) end, has = "documentHighlight", desc = "Next Reference", cond = function() return Snacks.words.is_enabled() end }
      keys[#keys + 1] = { "[[", function() Snacks.words.jump(-vim.v.count1) end, has = "documentHighlight", desc = "Prev Reference", cond = function() return Snacks.words.is_enabled() end }
      -- stylua: ignore end
    end,
  },
}
