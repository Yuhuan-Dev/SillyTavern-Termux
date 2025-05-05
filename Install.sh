#!/data/data/com.termux/files/usr/bin/bash

# 检查 nodejs 是否已安装，如未安装则安装
if ! command -v node >/dev/null 2>&1; then
    apt update -y
    apt install -y nodejs-lts
fi

# 克隆 SillyTavern 仓库（如已存在则跳过）
if [ ! -d "$HOME/SillyTavern" ]; then
    git clone https://dgithub.xyz/SillyTavern/SillyTavern "$HOME/SillyTavern"
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

# 进入 SillyTavern 目录，设置npm源，环境变量并安装依赖
cd "$HOME/SillyTavern" \
  && npm config set registry http://mirrors.cloud.tencent.com/npm/ \
  && export NODE_ENV=production \
  && npm i --no-audit --no-fund --loglevel=error --no-progress --omit=dev

# 直接运行菜单
bash "$HOME/menu.sh"
