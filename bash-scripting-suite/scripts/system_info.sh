#!/usr/bin/env bash
# system_info.sh - produce a concise system information report
# Usage: ./system_info.sh [output_file]

set -u

OUT=${1-}

report(){
  echo "==== SYSTEM REPORT - $(date -R) ===="
  echo
  echo "-- Host --"
  uname -a
  echo
  echo "-- Uptime & Load --"
  uptime
  echo
  echo "-- CPU --"
  if command -v lscpu >/dev/null 2>&1; then
    lscpu
  else
    awk -F: '/model name/ {print $2; exit}' /proc/cpuinfo
  fi
  echo
  echo "-- Memory --"
  free -h
  echo
  echo "-- Disk Usage --"
  df -h --total | sed -n '1,5p'
  echo
  echo "-- Top 5 processes by CPU --"
  ps -eo pid,comm,pcpu,pmem --sort=-pcpu | head -n 6
  echo
  echo "-- Top 5 processes by memory --"
  ps -eo pid,comm,pcpu,pmem --sort=-pmem | head -n 6
  echo
  echo "-- Network Interfaces --"
  ip -brief addr 2>/dev/null || ifconfig -a 2>/dev/null || true
  echo
}

if [[ -n "$OUT" ]]; then
  report > "$OUT"
  echo "Report written to $OUT"
else
  report
fi
