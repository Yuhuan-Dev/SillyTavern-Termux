#!/data/data/com.termux/files/usr/bin/bash

# 自动更新和安装依赖
pkg update -y
pkg upgrade -y
pkg install -y git
pkg install -y nodejs-lts

# 克隆 SillyTavern 仓库（如已存在则跳过）
if [ ! -d "$HOME/SillyTavern" ]; then
    git clone https://github.com/SillyTavern/SillyTavern "$HOME/SillyTavern"
fi

# 下载 menu.sh 到 $HOME 目录
curl -o "$HOME/menu.sh" https://raw.githubusercontent.com/Yuhuan-Dev/SillyTavern-Termux/main/menu.sh
chmod +x "$HOME/menu.sh"

# 设置每次打开 Termux 自动运行 menu.sh
PROFILE_FILE="$HOME/.bash_profile"
if [ ! -f "$PROFILE_FILE" ]; then
    touch "$PROFILE_FILE"
fi
if ! grep -q 'bash \$HOME/menu.sh' "$PROFILE_FILE" && ! grep -q 'bash $HOME/menu.sh' "$PROFILE_FILE"; then
    echo 'bash $HOME/menu.sh' >> "$PROFILE_FILE"
fi

# 直接运行菜单
bash "$HOME/menu.sh"
