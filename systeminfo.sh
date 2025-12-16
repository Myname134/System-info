#!/bin/bash

echo "======"
echo "System information"
echo "       ==========="

system_info() {
  echo ""
  echo "S=Y=S=T=E=M"
  echo "Hostname     : $(hostname)"
  echo "OS           : $(uname -o)"
  echo "Kernel       : $(uname -r)"
  echo "Architecture : $(uname -m)"
  echo "Uptime       : $(uptime -p)"
}

cpu_info() {
  echo ""
  echo "C-P-U"
  echo "Model  : $(grep 'model name' /proc/cpuinfo | head -n 1 | cut -d ':' -f2)"
  echo "Cores : $(grep -c ^processor /proc/cpuinfo)"
}

memory_info() {
  echo ""
  echo "M%E%M%O%R%Y"
  free -h
}

disk_info() {
  echo ""
  echo "D^I^S^K^U^S^A^G^E"
  df -h
}

network_info() {
  echo ""
  echo "N#E#T#W#O#R#K"
  ip addr show | grep -E 'inet ' | awk '{print $2}'
}

system_info
cpu_info
memory_info
disk_info
network_info

echo ""
echo "*((*(*((*(*(*((*((*(*(*(*(*((*(*"
