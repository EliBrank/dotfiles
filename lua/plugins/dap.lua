return {
  -- DAP Plugin
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require('dap')

      -- Configure Python Adapter for nvim-dap
      require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')  -- Adjust this to your Python path or virtualenv

      -- Set DAP adapters and configurations for Python
      dap.adapters.python = {
        type = 'executable',
        command = 'python3',
        args = { '-m', 'debugpy.adapter' },
      }

      dap.configurations.python = {
        {
          type = 'python',
          request = 'launch',
          name = "Launch file",
          program = "${file}",
          pythonPath = function()
            -- Use activated virtualenv or fallback to system Python
            local venv_path = os.getenv("VIRTUAL_ENV")
            if venv_path then
              return venv_path .. "/bin/python"
            else
              return "/usr/bin/python3"  -- Adjust this for your system
            end
          end,
        },
        {
          type = 'python',
          request = 'launch',
          name = "Debug Tests",
          program = "${file}",
          args = { "-m", "pytest" },
          justMyCode = false,
        },
      }
    end
  },

  -- DAP UI Plugin
  {
    "rcarriga/nvim-dap-ui",
    config = function()
      require('dapui').setup()

      local dap = require('dap')

      dap.listeners.after.event_initialized["dapui_config"] = function()
        require("dapui").open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        require("dapui").close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        require("dapui").close()
      end
    end
  },

  -- DAP Virtual Text Plugin
  {
    "theHamsta/nvim-dap-virtual-text",
    config = function()
      require("nvim-dap-virtual-text").setup({
        enabled = false,
      })
    end
  },

  -- DAP Python Plugin
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')  -- Adjust this to your Python path or virtualenv
    end
  }

}
