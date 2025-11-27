#!/usr/bin/env bash
# install.sh - make scripts executable and optionally add a user-level systemd timer
# Usage:
#   ./install.sh                  # make scripts executable
#   ./install.sh --systemd <src> <dest> <mode> <retain_days>   # install user-level systemd timer (requires --user daemon)
#
# Notes:
# - To use systemd --user timers, ensure your environment supports user services (e.g., `systemctl --user` works)
# - The service uses the backup.sh script with arguments passed in the installed timer unit.

set -euo pipefail

SCRIPTDIR=$(cd "$(dirname "$0")" && pwd)

# Make scripts executable
chmod +x "$SCRIPTDIR"/*.sh
echo "Scripts in $SCRIPTDIR set to executable"

if [[ ${1-} == "--systemd" ]]; then
  if [[ $# -lt 5 ]]; then
    echo "Usage: $0 --systemd <src> <dest> <mode> <retain_days>"
    exit 2
  fi
  SRC=$2
  DEST=$3
  MODE=$4
  RETAIN=$5
  # install unit and timer to ~/.config/systemd/user/
  UNIT_DIR="$HOME/.config/systemd/user"
  mkdir -p "$UNIT_DIR"
  SERVICE_FILE="$UNIT_DIR/bash-scripts-backup.service"
  TIMER_FILE="$UNIT_DIR/bash-scripts-backup.timer"
  cat > "$SERVICE_FILE" <<EOF
[Unit]
Description=Run Bash Scripting Suite backup

[Service]
Type=oneshot
ExecStart=$SCRIPTDIR/backup.sh $SRC $DEST $MODE $RETAIN
EOF
  cat > "$TIMER_FILE" <<EOF
[Unit]
Description=Daily backup timer for Bash Scripting Suite

[Timer]
OnCalendar=daily
Persistent=true

[Install]
WantedBy=timers.target
EOF
  echo "Installed user systemd unit and timer to $UNIT_DIR"
  echo "To enable and start the timer:"
  echo "  systemctl --user daemon-reload"
  echo "  systemctl --user enable --now bash-scripts-backup.timer"
  exit 0
fi
