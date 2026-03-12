#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
YEL="\e[33m"
BLUE="\e[34m"
MAG="\e[35m"
WH="\e[37m"
RESET="\e[0m"
BR="\e[91m"
BB="\e[94m"
BG="\e[92m"

echo "=================="
echo -e "${GREEN}System information${RESET}"
echo "=================="

system_info() {
  echo ""
  echo -e "${WH}SYSTEM${RESET}"
  echo "Hostname     : $(hostname)"
  echo "OS           : $(uname -o)"
  echo "Kernel       : $(uname -r)"
  echo "Architecture : $(uname -m)"
  echo "Uptime       : $(uptime -p)"
}

cpu_info() {
  echo ""
  echo -e "${MAG}CPU${RESET}"
  echo "Model  : $(grep 'model name' /proc/cpuinfo | head -n 1 | cut -d ':' -f2)"
  echo "Cores : $(grep -c ^processor /proc/cpuinfo)"
}

gpu_info() {
  echo ""
  echo -e "${BB}GPU${RESET}"
  lspci | grep -E "VGA|3D"
}

memory_info() {
  echo ""
  echo -e "${BLUE}MEMORY${RESET}"
  free -h | awk '/Mem:/ {print "Total: "$2" | Used: "$3" | Free: "$4}'
}

disk_info() {
  echo ""
  echo -e "${RED}DISKUSAGE${RESET}"
  df -h
}

network_info() {
  echo ""
  echo -e "${YEL}NETWORK${RESET}"
  if command -v ip &>/dev/null; then
    ip addr show | grep -E 'inet ' | awk '{print $2}'
  else
    echo "ip command not found"
  fi
}

temp_info() {
  echo ""
  echo -e "${BR}Temperature${RESET}"
  if command -v sensors &>/dev/null; then
    sensors | grep -E "Package id|Tctl|temp1"
  else
    echo "sensors command not found"
  fi
}

logo() {
  echo ""
  echo "  ---  ---"
  echo " ''' \/ '''  "
  echo "    \__/  "
  echo ""
}

show_all=false
help=false

while getopts "scmdnahgt" opt; do
  case $opt in
  s) system_info ;;
  c) cpu_info ;;
  m) memory_info ;;
  d) disk_info ;;
  n) network_info ;;
  a) show_all=true ;;
  h) help=true ;;
  g) gpu_info ;;
  t) temp_info ;;
  *)
    echo "Usage: $0 [-s] [-c] [-m] [-d] [-n] [-a] [-g] [-t] [-h]"
    exit 1
    ;;
  esac
done

if [ $OPTIND -eq 1 ] || [ "$show_all" = true ]; then
  logo
  system_info
  cpu_info
  gpu_info
  memory_info
  disk_info
  network_info
  temp_info
fi

if [ "$help" = true ]; then
  echo ""
  echo -e "${BG}Help Section${RESET}"
  echo ""
  echo "Options:"
  echo "-s : check system information"
  echo "-c : check cpu information"
  echo "-m : check memory information"
  echo "-d : check disk information"
  echo "-n : check network information"
  echo "-a : print all info"
  echo "-h : show this help menu"
  echo ""
  exit 0
fi

echo ""
echo "======="
echo -e "${GREEN}THE END${RESET}"
echo "======="
