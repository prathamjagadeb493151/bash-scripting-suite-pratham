# Presentation Slide — 1 slide (content + speaker notes)

Title: Bash Scripting Suite — Linux Automation Toolkit
Author: Pratham Jagadeb (ITER College) — Wipro Capstone Project

Slide content (bullets):
- Purpose: Automate everyday Linux admin tasks with portable Bash scripts
- Key scripts: system_info, backup (tar/rsync), log_cleaner, user_report
- Advanced but simple: rsync mode + user-level systemd timer included
- Demo: run system_info, run backup (rsync mode) on a small folder, run log_cleaner, show user_report
- Outcome: Reproducible, documented toolkit for ops tasks

Speaker notes (2–3 minutes):
1. Intro (15s): State purpose — quick automation toolkit for admins, useful in small infra.
2. system_info (30s): Run live — explain uptime, CPU, memory, disk, top processes.
3. backup (45s): Explain two modes: tar (timestamped archives) and rsync (incremental). Run demo on a tiny test folder; show backup destination and rotation. Mention retention parameter.
4. log_cleaner (20s): Demonstrate on a copied large log file; explain safe truncation and compressed backups.
5. user_report (20s): Run and highlight user list, lastlog and sudoers.
6. Closing (10s): How to run installer and enable systemd timer for scheduled backups. Invite Q&A.

Tip: Use a prepared small test folder for demo to avoid long waits.
