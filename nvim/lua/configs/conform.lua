return {
  notify_on_error = false,

  formatters_by_ft = {
    lua = { "stylua" },
    python = { "ruff_format", "ruff_organize_imports" },

    -- 前端相关：prettierd（daemon 版） + prettier fallback + stop_prettier 关闭 daemon
    typescript = { "prettierd", "prettier", "stop_prettier" },
    typescriptreact = { "prettierd", "prettier", "stop_prettier" },
    javascript = { "prettierd", "prettier", "stop_prettier" },
    javascriptreact = { "prettierd", "prettier", "stop_prettier" },
    json = { "prettierd", "prettier", "stop_prettier" },
    jsonc = { "prettierd", "prettier", "stop_prettier" }, -- tsconfig.json 等
    css = { "prettierd", "prettier", "stop_prettier" },
    scss = { "prettierd", "prettier", "stop_prettier" },
    less = { "prettierd", "prettier", "stop_prettier" },
    html = { "prettierd", "prettier", "stop_prettier" },
    vue = { "prettierd", "prettier", "stop_prettier" },
    svelte = { "prettierd", "prettier", "stop_prettier" },
    markdown = { "prettierd", "prettier", "stop_prettier" },
    yaml = { "prettierd", "prettier", "stop_prettier" },

    go = { "goimports", "gofmt" },
    gomod = { "gofumpt" },
    rust = { "rustfmt", "rustfmt_imports" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}