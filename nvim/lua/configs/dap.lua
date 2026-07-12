local dap = require("dap")
local dapui = require("dapui")

-- 自动开关 dap-ui
dap.listeners.before.attach.dapui_config = function() dapui.open() end
dap.listeners.before.launch.dapui_config = function() dapui.open() end
dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

-- 调试快捷键
local map = vim.keymap.set
map("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "DAP: Toggle breakpoint" })
map("n", "<leader>dB", function()
  vim.fn.input("Breakpoint condition: ", function(input) dap.set_breakpoint(input) end)
end, { desc = "DAP: Conditional breakpoint" })
map("n", "<leader>dc", function() dap.continue() end, { desc = "DAP: Continue / Start" })
map("n", "<leader>dC", function() dap.run_to_cursor() end, { desc = "DAP: Run to cursor" })
map("n", "<leader>di", function() dap.step_into() end, { desc = "DAP: Step into" })
map("n", "<leader>do", function() dap.step_over() end, { desc = "DAP: Step over" })
map("n", "<leader>dO", function() dap.step_out() end, { desc = "DAP: Step out" })
map("n", "<leader>dt", function() dap.terminate() end, { desc = "DAP: Terminate" })
map("n", "<leader>du", function() dapui.toggle() end, { desc = "DAP: Toggle UI" })
map({ "n", "v" }, "<leader>de", function() dapui.eval() end, { desc = "DAP: Eval expression" })

dapui.setup({
  icons = { expanded = "▾", collapsed = "▸", current_frame = "→" },
  mappings = {
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o", remove = "d", edit = "e", repl = "r", toggle = "t",
  },
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.25 },
        { id = "breakpoints", size = 0.25 },
        { id = "stacks", size = 0.25 },
        { id = "watches", size = 0.25 },
      },
      size = 40, position = "left",
    },
    {
      elements = {
        { id = "repl", size = 0.5 },
        { id = "console", size = 0.5 },
      },
      size = 0.25, position = "bottom",
    },
  },
  floating = {
    border = "single",
    mappings = { close = { "q", "<Esc>" } },
  },
  windows = { indent = 1 },
})

-- 把 DAP output 事件路由到 dap-ui console（DapShowLog 也会同步记录）
dap.listeners.event = dap.listeners.event or {}
dap.listeners.event.output = dap.listeners.event.output or {}
dap.listeners.event.output["dapui_console"] = function(_, body)
  vim.schedule(function()
    local console = require("dapui").elements and require("dapui").elements.console
    if not console then return end
    pcall(console.open)
    local text = body.output or body.data or ""
    if text ~= "" then console.append(text) end
  end)
end

-- TypeScript / JavaScript 调试（js-debug-adapter）
local js_debug = "js-debug-adapter"
if vim.fn.has("win32") == 1 then js_debug = "js_debug_adapter.cmd" end

dap.adapters["pwa-node"] = {
  type = "server", host = "localhost", port = "${port}",
  executable = { command = js_debug, args = { "${port}" } },
}
dap.adapters["pwa-chrome"] = vim.deepcopy(dap.adapters["pwa-node"])
dap.adapters["pwa-firefox"] = vim.deepcopy(dap.adapters["pwa-node"])

local js_launch = {
  {
    type = "pwa-node", request = "launch",
    name = "Launch current file (tsx)",
    program = "${file}", cwd = "${workspaceFolder}",
    runtimeExecutable = "npx", runtimeArgs = { "tsx" },
    sourceMaps = true, protocol = "inspector",
    console = "integratedTerminal",
    skipFiles = { "<node_internals>/**", "${workspaceFolder}/node_modules/**" },
  },
  {
    type = "pwa-node", request = "launch",
    name = "Launch current file (ts-node)",
    program = "${file}", cwd = "${workspaceFolder}",
    runtimeExecutable = "npx", runtimeArgs = { "ts-node", "--transpile-only" },
    sourceMaps = true, protocol = "inspector",
    console = "integratedTerminal",
    skipFiles = { "<node_internals>/**", "${workspaceFolder}/node_modules/**" },
  },
  {
    type = "pwa-node", request = "attach",
    name = "Attach to running Node",
    processId = require("dap.utils").pick_process,
    cwd = "${workspaceFolder}",
  },
}
dap.configurations.typescript = js_launch
dap.configurations.javascript = js_launch

-- Go 调试（delve）
dap.adapters.delve = {
  type = "server", host = "127.0.0.1", port = "${port}",
  executable = { command = "dlv", args = { "dap", "-l", "127.0.0.1:${port}" } },
}

dap.configurations.go = {
  {
    type = "delve", request = "launch",
    name = "Debug current file",
    program = "${file}", cwd = "${workspaceFolder}",
    buildFlags = "", console = "internalConsole",
  },
  {
    type = "delve", request = "launch",
    name = "Debug current package",
    program = "${workspaceFolder}", cwd = "${workspaceFolder}",
    console = "internalConsole",
  },
  {
    type = "delve", request = "launch",
    name = "Debug test",
    mode = "test",
    program = "${workspaceFolder}", cwd = "${workspaceFolder}",
    args = { "-test.run", "${input:test_name_regex}" },
    console = "internalConsole",
  },
  {
    type = "delve", request = "attach",
    name = "Attach to running Go process",
    mode = "local",
    processId = require("dap.utils").pick_process,
    cwd = "${workspaceFolder}",
  },
}

-- Rust 调试（codelldb）
dap.adapters.codelldb = {
  type = "server", host = "127.0.0.1", port = "${port}",
  executable = { command = "codelldb", args = { "--port", "${port}" } },
}

-- 从 cargo metadata 自动解析 binary 路径
local function cargo_binary()
  if vim.v.shell_error ~= 0 then return nil end
  local ok, decoded = pcall(vim.fn.json_decode, vim.fn.system("cargo metadata --no-deps --format-version 1"))
  if not ok or not decoded or not decoded.packages or #decoded.packages == 0 then return nil end
  return (decoded.target_directory or "target") .. "/debug/" .. decoded.packages[1].name
end

dap.configurations.rust = {
  {
    type = "codelldb", request = "launch",
    name = "Debug (cargo build + launch)",
    cargo = { args = { "build" } },
    program = cargo_binary, cwd = "${workspaceFolder}",
    stopOnEntry = false, console = "integratedTerminal",
  },
  {
    type = "codelldb", request = "launch",
    name = "Debug (launch existing binary)",
    program = cargo_binary, cwd = "${workspaceFolder}",
    stopOnEntry = false, console = "integratedTerminal",
  },
  {
    type = "codelldb", request = "launch",
    name = "Debug unit tests",
    cargo = { args = { "test", "--no-run" } },
    program = cargo_binary, cwd = "${workspaceFolder}",
    args = { "--", "--test-threads=1" }, console = "integratedTerminal",
  },
}