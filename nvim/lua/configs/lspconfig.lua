require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "zls", "pyright", "vtsls", "gopls" }

-- Python: 关掉 pyright 自带 import 排序（用 ruff 替代）
vim.lsp.config("pyright", {
  settings = {
    pyright = { disableOrganizeImports = true },
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly",
      },
    },
  },
})

-- TypeScript: vtsls（替代 ts_ls，支持 TS 7.0+，不依赖 tsserver.js）
vim.lsp.config("vtsls", {
  settings = {
    vtsls = {
      enableMoveToFileCodeAction = true,
      autoUseWorkspaceTsdk = true,
      maxMemory = 8192,
      typescript = {
        inlayHints = {
          parameterTypes = { enabled = true },
          parameterNames = { enabled = "literal" },
          variableTypes = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          enumMemberValues = { enabled = true },
        },
      },
      javascript = {
        inlayHints = {
          parameterTypes = { enabled = true },
          parameterNames = { enabled = "literal" },
          variableTypes = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
        },
      },
    },
  },
})

-- Go: 启用 gofumpt / staticcheck / 内联提示
vim.lsp.config("gopls", {
  settings = {
    gopls = {
      gofumpt = true,
      staticcheck = true,
      analyses = {
        unusedparams = true,
        unusedwrite = true,
        nilness = true,
        shadow = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
})

-- vim.lsp.config 必须在 vim.lsp.enable 之前调用
for _, lsp in ipairs(servers) do
  vim.lsp.enable(lsp)
end

-- 补全 LspAttach 快捷键（NvChad 默认只设了 gd）
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
  callback = function(args)
    local opts = function(desc) return { buffer = args.buf, desc = "LSP " .. desc } end
    local map = vim.keymap.set
    map("n", "K", vim.lsp.buf.hover, opts "Hover")
    map({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts "Code action")
    map("n", "<leader>lr", vim.lsp.buf.rename, opts "Rename")
    map("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, opts "Format (LSP)")
  end,
})