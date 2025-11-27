# Bash Scripting Suite — Linux Automation Toolkit

**Project:** Bash Scripting Suite — Linux Automation Toolkit  
**Author:** Pratham Jagadeb  
**College:** ITER College  
**Capstone:** Wipro Capstone Project  
**Date:** 2025-11-03

## Project summary
A compact but slightly advanced Bash scripting toolkit that automates common Linux admin tasks:
- System information reporting
- Flexible backups (tar *or* rsync mode) with rotation
- Safe log rotation/trimming
- User account reporting
- Installer helper that can install a systemd timer for scheduled backups

This project is easy to present and demonstrates competency with shell scripting, `rsync`, cron/systemd timers, and basic Linux administration.

## Files
```
bash-scripting-suite-pratham/
├── README.md
├── LICENSE
├── .gitignore
├── scripts/
│   ├── system_info.sh
│   ├── backup.sh
│   ├── log_cleaner.sh
│   ├── user_report.sh
│   └── install.sh
├── systemd/
│   ├── bash-scripts-backup.service
│   └── bash-scripts-backup.timer
├── presentation_one_slide.md
└── github_publish_guide.md
```

## Quick start
```bash
# unzip the package (if zipped) and go into scripts
cd scripts
./install.sh           # make scripts executable
# run examples
./system_info.sh > system-report.txt
./backup.sh /path/to/test-folder ~/backups rsync 7
./log_cleaner.sh /path/to/logfile.log 5120
./user_report.sh > user-report.txt
```

## Enhanced features
- `backup.sh` supports both tar archives and `rsync` incremental backups.
- `install.sh --systemd` can install a user-level systemd timer (no root required if using --user) to schedule daily backups.
- Clear documentation and presentation notes included.

## Submission
1. Publish the whole folder as a public GitHub repo.
2. Include a short demo video or run live demo during presentation using the provided notes.

Good luck — contact me (the author) for tweaks.
