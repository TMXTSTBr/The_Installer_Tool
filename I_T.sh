#!/data/data/com.termux/files/usr/bin/bash

WHITE='\033[1;37m'
GRAY='\033[0;37m'
BLUE='\033[1;34m'
GREEN='\033[1;32m'
CYAN='\033[1;36m'
RESET='\033[0m'

SCRIPTS_DIR="$HOME/installer_scripts"
mkdir -p "$SCRIPTS_DIR"

AUTHOR_NAME="SEU_NOME_AQUI"
GITHUB_LINK="https://github.com/SEU_USUARIO"

LANGUAGE="EN"

# ================= ANIMAÇÃO =================
intro_animation() {
clear
echo -e "${WHITE}"
text="INSTALLER TOOL"
for ((i=0; i<${#text}; i++)); do
    echo -ne "${WHITE}${text:$i:1}"
    sleep 0.05
done
echo
sleep 0.3
for i in {1..3}; do
    echo -ne "${BLUE}."
    sleep 0.3
done
sleep 0.5
clear
}

# ================= BANNER =================
banner() {
echo -e "${WHITE}"
echo " ██╗███╗   ██╗███████╗████████╗ █████╗ ██╗      ██╗"
echo " ██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║      ██║"
echo " ██║██╔██╗ ██║███████╗   ██║   ███████║██║      ██║"
echo " ██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║      ██║"
echo " ██║██║ ╚████║███████║   ██║   ██║  ██║███████╗ ███████╗"
echo " ╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝ ╚══════╝"
echo
echo " ████████╗ ██████╗  ██████╗ ██╗     "
echo " ╚══██╔══╝██╔═══██╗██╔═══██╗██║     "
echo "    ██║   ██║   ██║██║   ██║██║     "
echo "    ██║   ██║   ██║██║   ██║██║     "
echo "    ██║   ╚██████╔╝╚██████╔╝███████╗"
echo "    ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝"
echo
echo -e "${GRAY}Professional Automation Framework for Termux${RESET}"
echo -e "${WHITE}═══════════════════════════════════════════════════${RESET}"
echo
echo -e "${CYAN}Author : ${WHITE}$  YTAgenteAndroid"
echo -e "${CYAN}GitHub : ${WHITE}$https://github.com/TMXTSTBr/The_Installer_Tool"
echo
}
# ================= INSTALAR PACOTE =================
install_pkg() {
pkgname=$1
echo -e "${BLUE}[ Installing $pkgname ... ]${RESET}"
pkg install "$pkgname" -y
echo -e "${GREEN}[ $pkgname installation completed ✔ ]${RESET}"
echo
}

# ================= CREATE SCRIPT =================
create_script() {

clear
banner

echo -e "${CYAN}┌──────────────────────────────────────────┐"
echo -e "│              CREATE INSTALLER            │"
echo -e "└──────────────────────────────────────────┘${RESET}"
echo

echo -e "${WHITE}Script name:${RESET}"
read filename

FILE="$SCRIPTS_DIR/$filename.sh"

echo "#!/data/data/com.termux/files/usr/bin/bash" > "$FILE"
echo "" >> "$FILE"

echo "# ===================================" >> "$FILE"
echo "# Created with INSTALLER TOOL" >> "$FILE"
echo "# Author: $AUTHOR_NAME" >> "$FILE"
echo "# GitHub: $GITHUB_LINK" >> "$FILE"
echo "# ===================================" >> "$FILE"
echo "" >> "$FILE"

chmod +x "$FILE"

echo
echo -e "${GRAY}Add ANY command (pkg, git, echo, etc)"
echo -e "Type 'done' to finish${RESET}"
echo

while true; do
    echo -ne "${WHITE}cmd > ${RESET}"
    read cmd
    [ "$cmd" = "done" ] && break
    echo "$cmd" >> "$FILE"
    echo -e "${GREEN}✔ Command added${RESET}"
done

echo
echo -e "${GREEN}[ Script created successfully ✔ ]${RESET}"
echo
read -p "Press Enter to return..."
}

# ================= LIST =================
list_scripts() {
clear
banner
echo -e "${WHITE}Available Scripts"
echo -e "────────────────────────────────${RESET}"
ls "$SCRIPTS_DIR"
echo
read -p "Press Enter to return..."
}

# ================= RUN =================
run_script() {

clear
banner

files=($SCRIPTS_DIR/*.sh)

if [ ! -e "${files[0]}" ]; then
    echo "No scripts found."
    read -p "Press Enter..."
    return
fi

echo -e "${WHITE}Select Script"
echo -e "────────────────────────────────${RESET}"

i=1
for f in "${files[@]}"; do
    echo " $i) $(basename "$f")"
    ((i++))
done

echo
read -p ">> " num
selected=${files[$((num-1))]}

if [ -f "$selected" ]; then
    echo
    echo -e "${BLUE}[ Executing Script ... ]${RESET}"
    echo -e "${WHITE}────────────────────────────────${RESET}"
    bash "$selected"
fi

read -p "Press Enter to return..."
}

# ================= EXPORT =================
export_script() {

clear
banner

files=($SCRIPTS_DIR/*.sh)

if [ ! -e "${files[0]}" ]; then
    echo "No scripts found."
    read -p "Press Enter..."
    return
fi

echo -e "${WHITE}Select Script to Export"
echo -e "────────────────────────────────${RESET}"

i=1
for f in "${files[@]}"; do
    echo " $i) $(basename "$f")"
    ((i++))
done

echo
read -p ">> " num
selected=${files[$((num-1))]}

if [ -f "$selected" ]; then

    # Se não tiver permissão, ativa automaticamente
    if [ ! -d "/storage/emulated/0" ]; then
        echo
        echo "Setting up storage permission..."
        termux-setup-storage
        sleep 2
    fi

    DEST="/storage/emulated/0/InstallerTool"
    mkdir -p "$DEST"

    cp "$selected" "$DEST/"

    echo
    echo -e "${GREEN}[ Script exported successfully ✔ ]${RESET}"
    echo -e "${CYAN}Location:${WHITE} $DEST/$(basename "$selected")${RESET}"
fi

read -p "Press Enter to return..."
}
# ================= MENU =================
menu() {
while true; do
clear
banner

echo -e "${WHITE} 1) Create Installer"
echo -e " 2) List Scripts"
echo -e " 3) Execute Script"
echo -e " 4) Export Script"
echo -e " 5) Quick Install (wget + git)"
echo -e " 6) Exit${RESET}"
read -p " >> " op

case $op in
    1) create_script ;;
    2) list_scripts ;;
    3) run_script ;;
    4) export_script ;;
    5)
        install_pkg wget
        install_pkg git
        read -p "Press Enter to return..."
        ;;
    6) exit ;;
    *) echo "Invalid option"; sleep 1 ;;
esac
done
}

intro_animation
menu
