return {
  "tadmccorkle/markdown.nvim",
  ft = "markdown", -- or 'event = "VeryLazy"'
  opts = {
    on_attach = function(bufnr)
      local map = vim.keymap.set

      local function set_heading(level)
        local line = vim.api.nvim_get_current_line()
        local content = line:gsub("^%s*#+%s*", "")
        content = content:gsub("%s*#+%s*$", "")

        if content == "" then
          return
        end

        local prefix = string.rep("#", level) .. " "
        vim.api.nvim_set_current_line(prefix .. content)
      end

      map("n", "<leader>hh", function()
        set_heading(2)
      end, { buffer = bufnr, desc = "Heading 2" })

      map("n", "<leader>hj", function()
        set_heading(3)
      end, { buffer = bufnr, desc = "Heading 3" })

      map("n", "<leader>hk", function()
        set_heading(4)
      end, { buffer = bufnr, desc = "Heading 4" })

      map("n", "<leader>hl", function()
        set_heading(5)
      end, { buffer = bufnr, desc = "Heading 5" })

      map("n", "<leader>h;", function()
        set_heading(6)
      end, { buffer = bufnr, desc = "Heading 6" })

      map("x", "<leader>mc", function()
        local start_line = vim.fn.line(".")
        local end_line = vim.fn.line("v")

        start_line, end_line = math.min(start_line, end_line),
        math.max(start_line, end_line)

        local lines = vim.api.nvim_buf_get_lines(
          bufnr,
          start_line - 1,
          end_line,
          false
        )

        table.insert(lines, 1, "```")
        table.insert(lines, "```")

        vim.api.nvim_buf_set_lines(
          bufnr,
          start_line - 1,
          end_line,
          false,
          lines
        )
      end, { buffer = bufnr, desc = "Wrap in code block" })
    end,
  }
}
