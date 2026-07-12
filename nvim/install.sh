#!/usr/bin/env bash
# 在新机器上跑这个脚本，把 dotfiles/nvim/ 还原成 ~/.config/nvim/
# 用法: ./install.sh [-h|--help]
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: ./install.sh

首次在新机器上安装这个 NvChad v2.5 自定义配置。

流程:
  1. 备份现有 ~/.config/nvim（如果存在）
  2. 克隆 NvChad v2.5 starter 当底座
  3. 把 dotfiles/nvim/ 覆盖式同步到 ~/.config/nvim/
  4. 触发 lazy.nvim 装插件

安装完之后:
  - 打开 ~/.config/nvim/lua/plugins/avante.nvim.lua
  - 把 <required> 占位符替换成真实的 endpoint / model
  - API key 走环境变量（OPENAI_API_KEY / DEEPSEEK_API_KEY 等）

已有安装、只更新文件时用 ./update.sh。
EOF
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

DOTFILES_DIR="${DOTFILES_DIR:-$(cd "$(dirname "$0")" && pwd)}"
SRC="$DOTFILES_DIR/nvim"
DST="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

# 1. 备份
if [[ -e "$DST" && ! -L "$DST" ]]; then
  bak="${DST}.bak.$(date +%Y%m%d-%H%M%S)"
  echo "→ 备份 $DST → $bak"
  mv "$DST" "$bak"
fi
mkdir -p "$DST"

# 2. 第一次安装: 拉 NvChad v2.5 starter 当底盘
if [[ ! -d "$DST/lua/nvchad" ]]; then
  echo "→ 克隆 NvChad v2.5 starter（底座）..."
  tmp="$(mktemp -d)"
  trap 'rm -rf "$tmp"' EXIT
  git clone --depth 1 -b v2.5 https://github.com/NvChad/starter "$tmp"
  shopt -s dotglob
  cp -r "$tmp"/. "$DST"/
  rm -rf "$DST/.git"
fi

# 3. 覆盖式同步自定义配置
echo "→ 覆盖式同步: $SRC → $DST"
shopt -s dotglob
cp -r "$SRC"/. "$DST"/

# 4. 清掉运行时不用的文件
rm -f "$DST/install.sh" "$DST/update.sh" "$DST/README.md"
rm -f "$DST/lazy-lock.json"

# 5. 触发 lazy 装插件
echo "→ 启动 lazy 同步（首次运行会下载约 30 个插件）..."
if ! nvim --headless +"Lazy! sync" +qa; then
  echo "⚠ lazy sync 失败；可以手动打开 nvim 后跑 :Lazy sync"
fi

cat <<'NEXT'

✓ 安装完成。下一步:
  - 直接运行 nvim（让 lazy 完成插件安装和 treesitter 解析）
  - 编辑 ~/.config/nvim/lua/plugins/avante.nvim.lua，把 <required> 占位符填上
NEXT
