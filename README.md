# Bash Scripting Suite for System Maintenance  
**Capstone Project — Wipro | ITER College**  
**Author:** Pratham Jagadeb  

---

##  Project Overview  
This project is a **System Maintenance Suite** built entirely using **Bash scripting**.  
It automates routine Linux administrative tasks such as **backups**, **updates**, and **log monitoring**.  
The suite integrates all functions into a **menu-based interface**, allowing users to easily run maintenance commands without manually typing complex terminal commands.

It can be executed on **Ubuntu Linux**, **other Linux distributions**, or **Windows 11 WSL (Windows Subsystem for Linux)**.

---

##  Objective  
To design and implement a set of Bash scripts that automate regular system maintenance activities including file backups, package updates, and log analysis — all within one unified script suite.

---

##  Features  
- **Automated Backups:** Creates timestamped, incremental backups using `rsync`.  
- **System Updates:** Detects package managers (`apt`, `dnf`, `pacman`) and runs updates and cleanup commands automatically.  
- **Log Monitoring:** Scans for failed SSH logins, high CPU usage processes, and disk usage warnings.  
- **Watch Mode:** Continuously monitors system activity with real-time updates.  
- **Centralized Logging:** All events are logged into a single file (`suite.log`).  
- **Interactive Menu:** Provides an easy-to-use text-based menu interface to access all scripts.

---



