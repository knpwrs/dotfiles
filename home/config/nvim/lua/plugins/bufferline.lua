return {
  "akinsho/bufferline.nvim",
  keys = {
    { "<leader>bg", "<cmd>BufferLinePick<cr>", desc = "Pick Buffer" },
    { "<leader>bp", "<cmd>BufferLineTogglePin<cr>", desc = "Toggle pin" },
    { "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<cr>", desc = "Delete non-pinned buffers" },
    { "<leader>bxx", "<cmd>BufferLinePickClose<cr>", desc = "Pick and Close Buffer" },
    { "<leader>bxh", "<cmd>BufferLineCloseLeft<cr>", desc = "Close Buffers to the Left" },
    { "<leader>bxl", "<cmd>BufferLineCloseRight<cr>", desc = "Close Buffers to the Right" },
    { "<leader>bxo", [[<cmd>%bd|e#|bd#<cr>|'"<cr>]], desc = "Close All Other Buffers" },
    { "<leader>bd", "<cmd>bd<cr>", desc = "Delete Current Buffer" },
    { "<leader>bD", "<cmd>bd!<cr>", desc = "Delete Current Buffer (Ignore Unsaved Changes)" },
    { "<leader>bo", [[<cmd>%bd|e#|bd#<cr>|'"<cr>]], desc = "Close All Other Buffers" },
    { "<leader>[", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous Buffer" },
    { "<leader>]", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    { "<leader>{", "<cmd>BufferLineMovePrev<cr>", desc = "Move Buffer Left" },
    { "<leader>}", "<cmd>BufferLineMoveNext<cr>", desc = "Move Buffer Right" },
  },
}
