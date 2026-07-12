return {
  -- Mason: ensure_installed 自动装列出的工具
  {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      local extras = {
        -- Python
        "pyright", "ruff",
        -- TypeScript / 前端
        "vtsls", "prettierd", "js-debug-adapter",
        -- Go
        "gopls", "goimports", "delve",
        -- Rust debug
        "codelldb",
      }
      for _, tool in ipairs(extras) do
        if not vim.list_contains(opts.ensure_installed, tool) then
          table.insert(opts.ensure_installed, tool)
        end
      end
      opts.automatic_installation = true
      return opts
    end,
  },

  -- conform: 保存时格式化
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>fm",
        function() require("conform").format({ async = true, lsp_fallback = true }) end,
        mode = { "n", "v" },
        desc = "Format buffer",
      },
    },
    opts = require "configs.conform",
  },

  -- nvim-lspconfig: lazy=false 确保启动时注册 LSP
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function() require "configs.lspconfig" end,
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {},
  },

  -- nvim-dap: 含 dap-ui + 调试快捷键
  {
    "mfussenegger/nvim-dap",
    lazy = false,
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function() require "configs.dap" end,
  },

  -- Python 调试: 自动激活 .venv
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    config = function()
      local function find_venv()
        local found = vim.fs.find(".venv", { upward = true, type = "directory" })[1]
        if not found then return nil end
        found = vim.fn.fnamemodify(found, ":p"):gsub("/$", "")
        if vim.fn.executable(found .. "/bin/python") ~= 1 then return nil end
        return found
      end

      local function get_python_path()
        local venv = find_venv()
        return venv and (venv .. "/bin/python") or "python3"
      end

      -- dap-python v2.0+ 支持 callback，失败 fallback 到 string
      if not pcall(function() require("dap-python").setup(get_python_path) end) then
        require("dap-python").setup "python3"
      end

      local function sync_env()
        local venv = find_venv()
        if not venv then return end
        vim.env.VIRTUAL_ENV = venv
        vim.env.PATH = venv .. "/bin:" .. vim.env.PATH
        pcall(function() require("dap-python").python_path = venv .. "/bin/python" end)
      end
      sync_env()

      vim.api.nvim_create_autocmd({ "BufEnter", "DirChanged", "LspAttach" }, {
        pattern = { "*.py", "*.pyi" },
        group = vim.api.nvim_create_augroup("PythonVenv", { clear = true }),
        callback = sync_env,
      })
    end,
  },
}