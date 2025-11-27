#!/usr/bin/env bash
# log_cleaner.sh - safely truncate or rotate large logs
# Usage: ./log_cleaner.sh <log_file> [max_kb]
# Example: ./log_cleaner.sh /var/log/syslog 10240

set -euo pipefail

LOG=${1:-}
MAXKB=${2:-10240} # default 10 MB

if [[ -z "$LOG" ]]; then
  echo "Usage: $0 <log_file> [max_kb]"
  exit 2
fi

if [[ ! -f "$LOG" ]]; then
  echo "Log file '$LOG' not found"
  exit 3
fi

size_kb=$(du -k "$LOG" | cut -f1)

if (( size_kb > MAXKB )); then
  echo "Log is ${size_kb}KB, larger than ${MAXKB}KB — rotating"
  ts=$(date +"%Y%m%dT%H%M%S")
  cp "$LOG" "${LOG}.${ts}.backup"
  : > "$LOG"  # truncate file safely
  gzip -9 "${LOG}.${ts}.backup" || true
  echo "Rotated and compressed backup: ${LOG}.${ts}.backup.gz"
else
  echo "Log size ${size_kb}KB within threshold ${MAXKB}KB — nothing to do"
fi
