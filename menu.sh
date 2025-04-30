#!/data/data/com.termux/files/usr/bin/bash

# 彩色定义
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
MAGENTA='\033[1;35m'
CYAN='\033[1;36m'
NC='\033[0m' # No Color

# 更新日志内容
UPDATE_DATE="2024-06-08"
UPDATE_CONTENT="
1. 菜单美化，增加彩色显示。
2. 新增“查看依赖”功能。
3. 新增“更新日志”和“关于作者”菜单项。
4. 输入数字后直接执行，无需回车。
"

trap 'clear' EXIT

while true; do
    clear
    echo -e "${CYAN}===== 菜单 =====${NC}"
    echo -e "${RED}0. 退出脚本${NC}"
    echo -e "${GREEN}1. 启动酒馆${NC}"
    echo -e "${YELLOW}2. 更新酒馆${NC}"
    echo -e "${BLUE}3. 查看依赖${NC}"
    echo -e "${MAGENTA}4. 修复依赖${NC}"
    echo -e "${CYAN}5. 更新日志${NC}"
    echo -e "${GREEN}6. 关于作者${NC}"
    echo -e "${CYAN}================${NC}"
    echo -ne "请输入选项（0/1/2/3/4/5/6）: "

    # 读取单个字符，不需回车
    read -n1 choice
    echo

    case "$choice" in
        0)
            echo -e "${RED}退出脚本。${NC}"
            exit 0
            ;;
        1)
            if [ -d "$HOME/SillyTavern" ]; then
                cd "$HOME/SillyTavern"
                bash start.sh
                echo -e "${GREEN}按任意键返回菜单...${NC}"
                read -n1
                cd "$HOME"
            else
                echo -e "${RED}目录 SillyTavern 不存在！${NC}"
                sleep 2
            fi
            ;;
        2)
            if [ -d "$HOME/SillyTavern" ]; then
                cd "$HOME/SillyTavern"
                git pull
                echo -e "${YELLOW}按任意键返回菜单...${NC}"
                read -n1
                cd "$HOME"
            else
                echo -e "${RED}目录 SillyTavern 不存在！${NC}"
                sleep 2
            fi
            ;;
        3)
            echo -e "${BLUE}依赖版本信息如下：${NC}"
            echo -ne "${GREEN}git:   "; git --version
            echo -ne "${YELLOW}node:  "; node -v
            echo -ne "${CYAN}npm:   "; npm -v
            echo -e "${BLUE}按任意键返回菜单...${NC}"
            read -n1
            ;;
        4)
            echo -e "${MAGENTA}正在修复依赖...${NC}"
            pkg update -y && pkg upgrade -y
            pkg install -y git
            pkg install -y nodejs-lts
            echo -e "${MAGENTA}依赖修复完成。${NC}"
            echo -e "${MAGENTA}按任意键返回菜单...${NC}"
            read -n1
            ;;
        5)
            echo -e "${CYAN}脚本更新日期：${YELLOW}${UPDATE_DATE}${NC}"
            echo -e "${CYAN}更新内容：${NC}${UPDATE_CONTENT}"
            echo -e "${CYAN}按任意键返回菜单...${NC}"
            read -n1
            ;;
        6)
            echo -e "${GREEN}作者：欤歡${NC}"
            echo -e "${GREEN}邮箱：gao20031002@gmail.com${NC}"
            echo -e "${GREEN}按任意键返回菜单...${NC}"
            read -n1
            ;;
        *)
            echo -e "${RED}无效选项，请重新输入。${NC}"
            sleep 1
            ;;
    esac
done
