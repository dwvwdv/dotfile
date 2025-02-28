#!/bin/bash
set -euo pipefail

# 設定 dotfile 來源目錄
DOTFILE_DIR="$HOME/dotfile"

# 定義配置映射（將 "~" 替換為 $HOME）
declare -A configs=(
    [yazi]="$HOME/.config/yazi"
    [nvim]="$HOME/.config/nvim"
    [wezterm]="$HOME/.config/wezterm"
    [starship.toml]="$HOME/.config/starship.toml"
    [lazysql]="$HOME/.config/lazysql"
    [nushell]="$HOME/.config/nushell"
)

# 建立軟連結的函數
create_symlink() {
    local source="$1"
    local target="$2"
    local target_parent

    target_parent=$(dirname "$target")
    if [ ! -d "$target_parent" ]; then
        mkdir -p "$target_parent"
    fi

    echo "Creating symlink: $source -> $target"
    
    if [ -e "$target" ] || [ -L "$target" ]; then
        rm -rf "$target"
    fi

    ln -s "$source" "$target"
}

# 依序遍歷配置並建立軟連結
for key in "${!configs[@]}"; do
    source_path="$DOTFILE_DIR/$key"
    target_path="${configs[$key]}"
    create_symlink "$source_path" "$target_path"
done

echo "Symlink creation completed!"
