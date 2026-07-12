# nvim (NvChad v2.5) custom config

`~/.config/nvim/` 的自定义覆盖层，叠在 NvChad v2.5 starter 之上。

## 分层

- **底座**: NvChad v2.5 starter（`install.sh` 自动克隆）
- **自定义**: 本目录文件，由 `install.sh` / `update.sh` 覆盖到 `~/.config/nvim/`

## 文件映射

| dotfiles 仓库路径                          | 系统 `~/.config/nvim/...`        |
| ------------------------------------------ | -------------------------------- |
| `init.lua`                                 | `init.lua`                       |
| `.stylua.toml`                             | `.stylua.toml`                   |
| `lua/chadrc.lua`                           | `lua/chadrc.lua`                 |
| `lua/options.lua`                          | `lua/options.lua`                |
| `lua/mappings.lua`                         | `lua/mappings.lua`               |
| `lua/configs/{lazy,lspconfig,conform,dap}.lua` | `lua/configs/*.lua`           |
| `lua/plugins/{init.lua,avante.nvim.lua}`   | `lua/plugins/*.lua`              |

## 新机器安装

```sh
git clone <this-dotfiles-repo> ~/dotfiles
cd ~/dotfiles/nvim
./install.sh
```

`install.sh` 流程：

1. 备份现有 `~/.config/nvim/`（如果存在）
2. 克隆 NvChad v2.5 starter 当底座
3. 把本目录文件覆盖式同步到 `~/.config/nvim/`
4. 触发 lazy.nvim 装插件

## 已有机器更新

```sh
cd ~/dotfiles
git pull
cd nvim
./update.sh
```

## Avante 占位符

`lua/plugins/avante.nvim.lua` 里 `providers.openai.endpoint` 和 `providers.openai.model`
是 `<required>` 占位符 —— `install.sh` / `update.sh` **不会**自动替换它们。

首次安装后手动编辑 `~/.config/nvim/lua/plugins/avante.nvim.lua`：

```lua
providers = {
  openai = {
    endpoint = "https://api.deepseek.com/v1",  -- 举例
    model = "deepseek-chat",                    -- 举例
    timeout = 30000,
    extra_request_body = { temperature = 0 },
  },
},
```

API key 走环境变量（如 `OPENAI_API_KEY` / `DEEPSEEK_API_KEY`），不要写进配置。

## 已知 rust 状态

- `lspconfig.lua`: 未注册 `rust_analyzer`（rustup 装的）作为 LSP
- `dap.lua`: codelldb + Rust 调试配置保留
- `chadrc.lua`: 不在 mason skip 列表里，所以 Mason 也会装一份 `rust-analyzer`

新机器上如果 rust 调试要用 codelldb，需要额外装:

```sh
:MasonInstall codelldb
```

如果不需要 Rust 调试、想消掉 Mason 的 rust-analyzer 装动作，往 `chadrc.lua` 加:

```lua
M.mason = { skip = { "rust-analyzer" } }
```

## 不入库

- `lazy-lock.json` — 每台机器自己生成
- `install.sh` / `update.sh` 在第一次同步完会清掉（避免污染运行时配置）
