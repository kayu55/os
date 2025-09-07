#!/bin/bash

rm -f $0

apt update -y
apt upgrade -y
apt dist-upgrade -y
apt install curl -y
apt install wget -y
apt install jq -y

NC='\033[0m'
rbg='\033[41;37m'
r='\033[1;91m'
g='\033[1;92m'
y='\033[1;93m'
u='\033[0;35m'
c='\033[0;96m'
w='\033[1;97m'

if [ "${EUID}" -ne 0 ]; then
echo "${r}You need to run this script as root${NC}"
sleep 2
exit 0
fi

if [[ ! -f /root/.isp ]]; then
curl -sS ipinfo.io/org?token=44ae7fd0b5d0d5 | cut -d " " -f 2-10 > /root/.isp
fi
if [[ ! -f /root/.city ]]; then
curl -sS ipinfo.io/city?token=44ae7fd0b5d0d5 > /root/.city
fi
if [[ ! -f /root/.myip ]]; then
curl -sS ipv4.icanhazip.com > /root/.myip
fi

export IP=$(cat /root/.myip);
export ISP=$(cat /root/.isp);
export CITY=$(cat /root/.city);
source /etc/os-release

function lane_atas() {
echo -e "${c}┌──────────────────────────────────────────┐${NC}"
}
function lane_bawah() {
echo -e "${c}└──────────────────────────────────────────┘${NC}"
}


checking_sc

if [ "$(systemd-detect-virt)" == "openvz" ]; then
echo "OpenVZ is not supported"
exit 1
fi
}

# call


function MakeDirectories() {
    # Direktori utama
    local main_dirs=(
        "/etc/xray" "/var/lib/AR" "/etc/aryapro" "/etc/limit"
        "/etc/vmess" "/etc/vless" "/etc/trojan" "/etc/ssh" 
    )
    
    local aryapro_subdirs=("vmess" "vless" "trojan" "ssh" "bot")
    local aryapro_types=("backup" "notif" "usage" "ip" "detail")

    local protocols=("vmess" "vless" "trojan" "ssh")

    for dir in "${main_dirs[@]}"; do
        mkdir -p "$dir"
    done
    
    mkdir /etc/botwa
    cd botwa
    mkdir ssh vmess vless trojan
    cd

    for service in "${aryapro_subdirs[@]}"; do
        for type in "${aryapro_types[@]}"; do
            mkdir -p "/etc/aryapro/$service/$type"
        done
    done

    for protocol in "${protocols[@]}"; do
        mkdir -p "/etc/limit/$protocol"
    done

    local databases=(
        "/etc/aryapro/vmess/.vmess.db"
        "/etc/aryapro/vless/.vless.db"
        "/etc/aryapro/trojan/.trojan.db"
        "/etc/aryapro/ssh/.ssh.db"
        "/etc/aryapro/bot/.bot.db"
    )

    for db in "${databases[@]}"; do
        touch "$db"
        echo "& plugin Account" >> "$db"
    done

    touch /etc/.{ssh,vmess,vless,trojan}.db
    echo "IP=" > /var/lib/AR/ipvps.conf
}

MakeDirectories


function domain_setup(){
wget https://raw.githubusercontent.com/kayu55/os/main/domains.sh && chmod +x domains.sh && ./domains.sh
clear
}

domain_setup

function Installasi(){
animation_loading() {
    CMD[0]="$1"
    CMD[1]="$2"
    
    (
        # Hapus file fim jika ada
        [[ -e $HOME/fim ]] && rm -f $HOME/fim
        
        # Jalankan perintah di background dan sembunyikan output
        ${CMD[0]} -y >/dev/null 2>&1
        ${CMD[1]} -y >/dev/null 2>&1
        
        # Buat file fim untuk menandakan selesai
        touch $HOME/fim
    ) >/dev/null 2>&1 &

    tput civis # Sembunyikan kursor
    echo -ne "  \033[0;33mProcessed Install \033[1;37m- \033[0;33m["
    
    while true; do
        for ((i = 0; i < 18; i++)); do
            echo -ne "\033[0;32m#"
            sleep 0.1
        done
        
        # Jika file fim ada, hapus dan keluar dari loop
        if [[ -e $HOME/fim ]]; then
            rm -f $HOME/fim
            break
        fi
        
        echo -e "\033[0;33m]"
        sleep 1
        tput cuu1 # Kembali ke baris sebelumnya
        tput dl1   # Hapus baris sebelumnya
        echo -ne "  \033[0;33mProcessed Install \033[1;37m- \033[0;33m["
    done
    
    echo -e "\033[0;33m]\033[1;37m -\033[1;32m Succes !\033[1;37m"
    tput cnorm # Tampilkan kursor kembali
}

TOOLS_PKG() {
cd
wget https://raw.githubusercontent.com/kayu55/os/main/PACKAGES/tools.sh &> /dev/null
chmod +x tools.sh && ./tools.sh &> /dev/null

wget -q -O /etc/port.txt "https://raw.githubusercontent.com/kayu55/os/main/PACKAGES/port.txt" &> /dev/nul
start=$(date +%s)
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
apt install git curl -y >/dev/null 2>&1
apt install python -y >/dev/null 2>&1
}

INSTALL_SSH() {

# install at untuk meng kill triall ssh
sudo apt install at -y >/dev/null 2>&1

wget https://raw.githubusercontent.com/kayu55/os/main/ssh/ssh-vpn.sh &> /dev/null
chmod +x ssh-vpn.sh && ./ssh-vpn.sh &> /dev/null

# installer gotop
gotop_latest="$(curl -s https://api.github.com/repos/xxxserxxx/gotop/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)" &> /dev/null
gotop_link="https://github.com/xxxserxxx/gotop/releases/download/v$gotop_latest/gotop_v"$gotop_latest"_linux_amd64.deb" &> /dev/null
curl -sL "$gotop_link" -o /tmp/gotop.deb &> /dev/null
dpkg -i /tmp/gotop.deb &> /dev/null
} 

INSTALL_XRAY() {

# install semua kebutuhan xray
wget https://raw.githubusercontent.com/kayu55/os/main/xray/ins-xray.sh &> /dev/null
chmod +x ins-xray.sh && ./ins-xray.sh &> /dev/null

# limit quota & service xray
wget https://raw.githubusercontent.com/kayu55/os/main/Xbw_LIMIT/install.sh &> /dev/null
chmod +x install.sh && ./install.sh &> /dev/null

# limit service ip xray
wget https://raw.githubusercontent.com/kayu55/os/main/AUTOKILL_SERVICE/service.sh &> /dev/null
chmod +x service.sh && ./service.sh &> /dev/null

}

INSTALL_WEBSOCKET() {

# install-ws
wget https://raw.githubusercontent.com/kayu55/os/main/ws/install-ws.sh &> /dev/null
chmod +x install-ws.sh && ./install-ws.sh &> /dev/null

# banner ssh
wget https://raw.githubusercontent.com/kayu55/os/main/ws/banner_ssh.sh &> /dev/null
chmod +x banner_ssh.sh && ./banner_ssh.sh &> /dev/null
}

INSTALL_BACKUP() {
apt install rclone &> /dev/null
printf "q\n" | rclone config &> /dev/null
wget -O /root/.config/rclone/rclone.conf "https://github.com/kayu55/os/raw/main/rclone.conf" &> /dev/null
git clone  https://github.com/magnific0/wondershaper.git &> /dev/null
cd wondershaper
make install &> /dev/null
cd
rm -rf wondershaper
    
rm -f /root/set-br.sh
rm -f /root/limit.sh
}

INSTALL_FEATURE() {
wget https://raw.githubusercontent.com/kayu55/os//main/menu/install_menu.sh &> /dev/null
chmod +x install_menu.sh && ./install_menu.sh &> /dev/null
}

INSTALL_UDP_CUSTOM() {
wget https://raw.githubusercontent.com/kayu55/os/main/ws/UDP.sh &> /dev/null
chmod +x UDP.sh && ./UDP.sh &> /dev/null
}

if [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "ubuntu" ]]; then
echo -e "${g}Setup nginx For OS Is $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')${NC}"
UNTUK_UBUNTU
elif [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "debian" ]]; then
echo -e "${g}Setup nginx For OS Is $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')${NC}"
UNTUK_DEBIAN
else
echo -e " Your OS Is Not Supported ( ${YELLOW}$(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')${FONT} )"
fi
}

function UNTUK_DEBIAN(){
lane_atas
echo -e "${c}│          ${g}PROCESS INSTALLED TOOLS${NC}         ${c}│${NC}"
lane_bawah
TOOLS_PKG
echo ""

lane_atas
echo -e "${c}│      ${g}PROCESS INSTALLED SSH & OPENVPN${NC}     ${c}│${NC}"
lane_bawah
INSTALL_SSH
echo ""

lane_atas
echo -e "${c}│           ${g}PROCESS INSTALLED XRAY${NC}         ${c}│${NC}"
lane_bawah
INSTALL_XRAY
echo ""

lane_atas
echo -e "${c}│       ${g}PROCESS INSTALLED WEBSOCKET SSH${NC}    ${c}│${NC}"
lane_bawah
INSTALL_WEBSOCKET
echo ""

lane_atas
echo -e "${c}│       ${g}PROCESS INSTALLED BACKUP MENU${NC}${c}      │${NC}"
lane_bawah
INSTALL_BACKUP

lane_atas
echo -e "${c}│           ${g}DOWNLOAD EXTRA MENU${NC}${c}            │${NC}"
lane_bawah
INSTALL_FEATURE
echo ""

lane_atas
echo -e "${c}│           ${g}DOWNLOAD UDP CUSTOM${NC}${c}            │${NC}"
lane_bawah
INSTALL_UDP_CUSTOM
echo ""
}

function UNTUK_UBUNTU(){
lane_atas
echo -e "${c}│          ${g}PROCESS INSTALLED TOOLS${NC}         ${c}│${NC}"
lane_bawah
TOOLS_PKG
echo ""

lane_atas
echo -e "${c}│      ${g}PROCESS INSTALLED SSH & OPENVPN${NC}     ${c}│${NC}"
lane_bawah
INSTALL_SSH
echo ""

lane_atas
echo -e "${c}│           ${g}PROCESS INSTALLED XRAY${NC}         ${c}│${NC}"
lane_bawah
INSTALL_XRAY
echo ""

lane_atas
echo -e "${c}│       ${g}PROCESS INSTALLED WEBSOCKET SSH${NC}    ${c}│${NC}"
lane_bawah
INSTALL_WEBSOCKET
echo ""

lane_atas
echo -e "${c}│       ${g}PROCESS INSTALLED BACKUP MENU${NC}${c}      │${NC}"
lane_bawah
INSTALL_BACKUP
echo ""

lane_atas
echo -e "${c}│           ${g}DOWNLOAD EXTRA MENU${NC}${c}            │${NC}"
lane_bawah
INSTALL_FEATURE
echo ""

lane_atas
echo -e "${c}│           ${g}DOWNLOAD UDP CUSTOM${NC}${c}            │${NC}"
lane_bawah
INSTALL_UDP_CUSTOM
echo ""
}

# Tentukan nilai baru yang diinginkan untuk fs.file-max
NEW_FILE_MAX=65535  # Ubah sesuai kebutuhan Anda

# Nilai tambahan untuk konfigurasi netfilter
NF_CONNTRACK_MAX="net.netfilter.nf_conntrack_max=262144"
NF_CONNTRACK_TIMEOUT="net.netfilter.nf_conntrack_tcp_timeout_time_wait=30"

# File yang akan diedit
SYSCTL_CONF="/etc/sysctl.conf"

# Ambil nilai fs.file-max saat ini
CURRENT_FILE_MAX=$(grep "^fs.file-max" "$SYSCTL_CONF" | awk '{print $3}' 2>/dev/null)

# Cek apakah nilai fs.file-max sudah sesuai
if [ "$CURRENT_FILE_MAX" != "$NEW_FILE_MAX" ]; then
    # Cek apakah fs.file-max sudah ada di file
    if grep -q "^fs.file-max" "$SYSCTL_CONF"; then
        # Jika ada, ubah nilainya
        sed -i "s/^fs.file-max.*/fs.file-max = $NEW_FILE_MAX/" "$SYSCTL_CONF" >/dev/null 2>&1
    else
        # Jika tidak ada, tambahkan baris baru
        echo "fs.file-max = $NEW_FILE_MAX" >> "$SYSCTL_CONF" 2>/dev/null
    fi
fi

# Cek apakah net.netfilter.nf_conntrack_max sudah ada
if ! grep -q "^net.netfilter.nf_conntrack_max" "$SYSCTL_CONF"; then
    echo "$NF_CONNTRACK_MAX" >> "$SYSCTL_CONF" 2>/dev/null
fi

# Cek apakah net.netfilter.nf_conntrack_tcp_timeout_time_wait sudah ada
if ! grep -q "^net.netfilter.nf_conntrack_tcp_timeout_time_wait" "$SYSCTL_CONF"; then
    echo "$NF_CONNTRACK_TIMEOUT" >> "$SYSCTL_CONF" 2>/dev/null
fi


# Terapkan perubahan
sysctl -p >/dev/null 2>&1

function install_crond(){
wget https://raw.githubusercontent.com/kayu55/os/main/install_cron.sh && chmod +x install_cron.sh && ./install_cron.sh
clear
}


Installasi
install_crond

# install cron.d
cat> /root/.profile << END
if [ "$BASH" ]; then
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi
fi
mesg n || true
clear
menu
END
chmod 644 /root/.profile
if [ -f "/root/log-install.txt" ]; then
rm /root/log-install.txt > /dev/null 2>&1
fi
if [ -f "/etc/afak.conf" ]; then
rm /etc/afak.conf > /dev/null 2>&1
fi
history -c
serverV=$( curl -sS https://raw.githubusercontent.com/kayu55/os/main/versi  )
echo $serverV > /root/.versi
echo "00" > /home/daily_reboot
aureb=$(cat /home/daily_reboot)
b=11
if [ $aureb -gt $b ]
then
gg="PM"
else
gg="AM"
fi
cd

curl -sS ifconfig.me > /etc/myipvps
curl -s ipinfo.io/city?token=44ae7fd0b5d0d5 >> /etc/xray/city
curl -s ipinfo.io/org?token=44ae7fd0b5d0d5  | cut -d " " -f 2-10 >> /etc/xray/isp

rm -f /root/*.sh
rm -f /root/*.txt

function SENDER_NOTIFICATION() {
MYIP=$(curl -sS ipv4.icanhazip.com)
echo -e "\e[32mloading...\e[0m" 
clear
clear
domain=$(cat /etc/xray/domain)
TIMES="10"
CHATID="6430177985"
KEY="7567594287:AAGVeDwRq9QrNg6jSce30eOm9WiVtAWKxjA"
URL="https://api.telegram.org/bot$KEY/sendMessage"
ISP=$(cat /etc/xray/isp)
CITY=$(cat /etc/xray/city)
domain=$(cat /etc/xray/domain) 
TIME=$(date +'%Y-%m-%d %H:%M:%S')
RAMMS=$(free -m | awk 'NR==2 {print $2}')
MODEL2=$(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')
MYIP=$(curl -sS ipv4.icanhazip.com)

TEXT="
<code>━━━━━━━━━━━━━━━━━━━━</code>
<code>⚠️ AUTOSCRIPT ALL OS RELEY ⚠️</code>
<code>━━━━━━━━━━━━━━━━━━━━</code>
<code>TIME : </code><code>${TIME} WIB</code>
<code>DOMAIN : </code><code>${domain}</code>
<code>IP : </code><code>${MYIP}</code>
<code>ISP : </code><code>${ISP} $CITY</code>
<code>OS LINUX : </code><code>${MODEL2}</code>
<code>RAM : </code><code>${RAMMS} MB</code>
<code>━━━━━━━━━━━━━━━━━━━━</code>
<i> Notifikasi Installer Script...</i>
"'&reply_markup={"inline_keyboard":[[{"text":"🔥ᴏʀᴅᴇʀ","url":"https://t.me/Arya77pro"},{"text":"🔥GRUP","url":"https://t.me/Arya77pro"}]]}'

    curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
}

rm ~/.bash_history
rm -f openvpn
rm -f key.pem
rm -f cert.pem

clear
echo -e "${c}┌────────────────────────────────────────────┐${NC}"
echo -e "${c}│  ${g}INSTALL SCRIPT SELESAI..${NC}                  ${c}│${NC}"
echo -e "${c}└────────────────────────────────────────────┘${NC}"
echo  ""
echo -e "\e[92;1m dalam 3 detik akan Melakukan reboot.... \e[0m"

SENDER_NOTIFICATION

sleep 3

clear
# Langsung reboot
reboot
