#!/usr/bin/env bash
# backup.sh - create timestamped backups and rotate old backups
# Supports two modes: 'tar' (default) and 'rsync'
# Usage: ./backup.sh <source_dir> <backup_dir> [mode] [retain_days]
# Examples:
#   ./backup.sh /home/user/test ~/backups tar 14
#   ./backup.sh /home/user/test ~/backups rsync 7

set -euo pipefail

SRC=${1:-}
DEST=${2:-}
MODE=${3:-tar}   # 'tar' or 'rsync'
RETAIN=${4:-14}  # days

if [[ -z "$SRC" || -z "$DEST" ]]; then
  echo "Usage: $0 <source_dir> <backup_dir> [mode] [retain_days]"
  exit 2
fi

if [[ ! -d "$SRC" ]]; then
  echo "Source directory '$SRC' does not exist"
  exit 3
fi

mkdir -p "$DEST"

timestamp=$(date +"%Y%m%dT%H%M%S")
base_name=$(basename "$SRC")

if [[ "$MODE" == "tar" ]]; then
  archive="$DEST/backup-${base_name}-${timestamp}.tar.gz"
  echo "Creating tar.gz backup of $SRC -> $archive"
  tar -czf "$archive" -C "$(dirname "$SRC")" "$base_name"
  echo "Backup complete: $archive"
elif [[ "$MODE" == "rsync" ]]; then
  # rsync incremental-style: store under a timestamped folder, keep previous backups for rotation
  dest_folder="$DEST/${base_name}-${timestamp}"
  echo "Creating rsync backup of $SRC -> $dest_folder"
  rsync -a --delete "$SRC"/ "$dest_folder"/
  echo "Rsync backup complete: $dest_folder"
else
  echo "Unknown mode: $MODE (choose 'tar' or 'rsync')"
  exit 4
fi

# Rotate old backups: remove files/folders older than RETAIN days
echo "Removing backups older than $RETAIN days in $DEST"
# only match our backup patterns
find "$DEST" -maxdepth 1 -mindepth 1 -type f -name 'backup-*' -mtime +"$RETAIN" -print -delete || true
find "$DEST" -maxdepth 1 -mindepth 1 -type d -name "${base_name}-*" -mtime +"$RETAIN" -print -exec rm -rf {} \; || true

echo "Rotation complete."
