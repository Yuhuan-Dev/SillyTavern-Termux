#!/data/data/com.termux/files/usr/bin/bash

trap 'clear' EXIT

while true; do
    clear
    echo "===== 菜单 ====="
    echo "0. 退出脚本"
    echo "1. 启动酒馆"
    echo "2. 更新酒馆"
    echo "3. 修复依赖"
    echo "================"
    read -p "请输入选项（0/1/2/3）: " choice

    case "$choice" in
        0)
            echo "退出脚本。"
            exit 0
            ;;
        1)
            if [ -d "$HOME/SillyTavern" ]; then
                cd "$HOME/SillyTavern"
                bash start.sh
                read -p "按回车键返回菜单..."
                cd "$HOME"
            else
                echo "目录 SillyTavern 不存在！"
                sleep 2
            fi
            ;;
        2)
            if [ -d "$HOME/SillyTavern" ]; then
                cd "$HOME/SillyTavern"
                git pull
                read -p "按回车键返回菜单..."
                cd "$HOME"
            else
                echo "目录 SillyTavern 不存在！"
                sleep 2
            fi
            ;;
        3)
            echo "正在修复依赖..."
            pkg update -y && pkg upgrade -y
            pkg install -y git
            pkg install -y nodejs-lts
            echo "依赖修复完成。"
            read -p "按回车键返回菜单..."
            ;;
        *)
            echo "无效选项，请重新输入。"
            sleep 1
            ;;
    esac
done
