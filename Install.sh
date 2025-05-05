#!/data/data/com.termux/files/usr/bin/bash
set -e

# 检查 git 是否已安装
if ! command -v git >/dev/null 2>&1; then
    apt update -y
    apt install -y git
fi

# 检查 curl 是否已安装
if ! command -v curl >/dev/null 2>&1; then
    apt update -y
    apt install -y curl
fi

# 检查 nodejs 是否已安装，如未安装则安装
if ! command -v node >/dev/null 2>&1; then
    apt update -y
    if apt-cache search nodejs-lts | grep -q nodejs-lts; then
        apt install -y nodejs-lts
    else
        apt install -y nodejs
    fi
fi

# 克隆 SillyTavern 仓库（如已存在则跳过）
if [ ! -d "$HOME/SillyTavern" ]; then
    git clone https://dgithub.xyz/SillyTavern/SillyTavern "$HOME/SillyTavern"
fi

# 下载 menu.sh 到 $HOME 目录
curl -o "$HOME/menu.sh" https://raw.githubusercontent.com/Yuhuan-Dev/SillyTavern-Termux/main/menu.sh
chmod +x "$HOME/menu.sh"

# 设置每次打开 Termux 自动运行 menu.sh
for PROFILE_FILE in "$HOME/.bash_profile" "$HOME/.profile"; do
    if [ ! -f "$PROFILE_FILE" ]; then
        touch "$PROFILE_FILE"
    fi
    if ! grep -q 'bash \$HOME/menu.sh' "$PROFILE_FILE" && ! grep -q 'bash $HOME/menu.sh' "$PROFILE_FILE"; then
        echo 'bash $HOME/menu.sh' >> "$PROFILE_FILE"
    fi
done

# 进入 SillyTavern 目录，设置npm源，环境变量并安装依赖
cd "$HOME/SillyTavern" || { echo "进入目录失败"; exit 1; }
npm config set registry http://mirrors.cloud.tencent.com/npm/
export NODE_ENV=production
npm i --no-audit --no-fund --loglevel=error --no-progress --omit=dev

# 直接运行菜单
bash "$HOME/menu.sh"
