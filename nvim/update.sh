#!/usr/bin/env bash
# 已有安装的机器: 从 dotfiles/nvim/ 推最新覆盖到 ~/.config/nvim/
# 用法: ./update.sh
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$(cd "$(dirname "$0")" && pwd)}"
SRC="$DOTFILES_DIR/nvim"
DST="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

if [[ ! -d "$DST" ]]; then
  echo "error: $DST 不存在；先跑 ./install.sh" >&2
  exit 1
fi

echo "→ 覆盖式同步: $SRC → $DST"
shopt -s dotglob
cp -r "$SRC"/. "$DST"/

# 清掉运行时不用的文件
rm -f "$DST/install.sh" "$DST/update.sh" "$DST/README.md"
rm -f "$DST/lazy-lock.json"

echo "→ 触发 lazy 同步..."
if ! nvim --headless +"Lazy! sync" +qa; then
  echo "⚠ lazy sync 失败；可以手动打开 nvim 后跑 :Lazy sync"
fi

echo "✓ 更新完成（注意 <required> 占位符需手动填）"
