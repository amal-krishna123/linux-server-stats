# Linux Server Performance Monitor

A lightweight, zero-dependency Bash script that aggregates core server health metrics into a clean, color-coded terminal dashboard. This tool is designed for system administrators and DevOps engineers to quickly assess server health without running multiple manual commands.

## Features

- **Core Resource Tracking:** Real-time metrics for total CPU usage, RAM utilization (Free vs. Used with percentages), and overall storage/disk space.
- **Process Auditing:** Instantly identifies the Top 5 processes consuming the most CPU and the Top 5 processes consuming the most Memory.
- **System Telemetry:** Displays the OS version, system uptime, and exact load averages (1, 5, and 15-minute intervals).
- **Security & User Activity:** Displays the number of currently logged-in users and tracks historical failed login attempts to catch potential brute-force attacks.

## Prerequisites

This script targets any modern Linux distribution (Ubuntu, Debian, RHEL, CentOS) and relies entirely on native system utilities:
- `top`
- `free`
- `df`
- `ps`
- `uptime`

## Installation & Usage

1. **Clone the repository or download the script:**
```bash
   cd ~/
   # (If cloning) git clone [https://github.com/YOUR_USERNAME/YOUR_REPO.git](https://github.com/YOUR_USERNAME/YOUR_REPO.git)
   # cd YOUR_REPO
