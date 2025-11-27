#!/usr/bin/env bash
# user_report.sh - generate a simple user account report
# Usage: ./user_report.sh [output_file]

set -u
OUT=${1-}

report(){
  echo "==== USER REPORT - $(date -R) ===="
  echo
  echo "-- /etc/passwd (human-readable) --"
  awk -F: '{printf "%s (UID:%s) home:%s shell:%s\n", $1, $3, $6, $7}' /etc/passwd
  echo
  echo "-- Last login (lastlog top 10) --"
  lastlog | sed -n '1,12p'
  echo
  echo "-- Recent logins (last 20) --"
  last -n 20 || true
  echo
  echo "-- Users in sudo/group --"
  if getent group sudo >/dev/null 2>&1; then
    getent group sudo
  elif getent group wheel >/dev/null 2>&1; then
    getent group wheel
  else
    echo "No 'sudo' or 'wheel' group found on this system"
  fi
  echo
}

if [[ -n "$OUT" ]]; then
  report > "$OUT"
  echo "User report written to $OUT"
else
  report
fi
