return {
  "neovim/nvim-lspconfig",
  init = function()
    local format = function()
      require("lazyvim.plugins.lsp.format").format({ force = true })
    end

    local keys = require("lazyvim.plugins.lsp.keymaps").get()

    keys[#keys + 1] = { "<leader>lf", format, desc = "Format Document", has = "formatting" }
    keys[#keys + 1] = { "<leader>lf", format, desc = "Format Range", mode = "v", has = "rangeFormatting" }
    keys[#keys + 1] = { "<leader>lk", vim.lsp.buf.hover, desc = "Hover" }
    keys[#keys + 1] = { "<leader>lK", vim.lsp.buf.hover, desc = "Signature Help", has = "signatureHelp" }
    keys[#keys + 1] = { "<leader>ll", vim.diagnostic.open_float, desc = "Show Line Diagnostics" }
    keys[#keys + 1] = { "<leader>lq", vim.diagnostic.setloclist, desc = "Show Line Diagnostics" }
    keys[#keys + 1] = { "<leader>lR", "<cmd>LspRestart<cr>", desc = "Restart LSP" }
    keys[#keys + 1] = { "<leader>lm", vim.lsp.buf.rename, desc = "Rename", has = "rename" }
    keys[#keys + 1] = { "<leader>lM", "<cmd>Mason<cr>", desc = "mason UI" }

    -- fzf
    keys[#keys + 1] = {
      "<leader>ld",
      function()
        require("fzf-lua").lsp_definitions({ reuse_win = true, jump_to_single_result = true })
      end,
      desc = "Goto Definition",
      has = "definition",
    }
    keys[#keys + 1] = {
      "<leader>lD",
      function()
        require("fzf-lua").diagnostics({ reuse_win = true })
      end,
      desc = "Diagnostics",
    }
    keys[#keys + 1] = {
      "<leader>li",
      function()
        require("fzf-lua").lsp_implementations({ reuse_win = true })
      end,
      desc = "Goto Implementation",
    }
    keys[#keys + 1] = {
      "<leader>ly",
      function()
        require("fzf-lua").lsp_typedefs({ reuse_win = true, jump_to_single_result = true })
      end,
      desc = "Goto T[y]pe Definition",
    }
    keys[#keys + 1] = {
      "<leader>lr",
      function()
        require("fzf-lua").lsp_references({ reuse_win = true })
      end,
      desc = "References",
    }
    keys[#keys + 1] = {
      "<leader>ls",
      function()
        require("fzf-lua").lsp_document_symbols({ reuse_win = true })
      end,
      desc = "Document Symbols",
    }
    keys[#keys + 1] = {
      "<leader>le",
      vim.lsp.buf.code_action,
      desc = "Code Action",
      has = "codeAction",
    }
  end,
}
