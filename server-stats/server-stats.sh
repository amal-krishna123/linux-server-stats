#!/bin/bash

# Define colors for output
CYAN='\033[0;36m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${CYAN}====================================================${NC}"
echo -e "${CYAN}               SERVER PERFORMANCE STATS             ${NC}"
echo -e "${CYAN}====================================================${NC}\n"

# ---------------------------------------------------------
# STRETCH GOALS (OS, Uptime, Load, Users)
# ---------------------------------------------------------
echo -e "${GREEN}--- System Information ---${NC}"

# OS Version
OS_VERSION=$(cat /etc/os-release | grep "PRETTY_NAME" | cut -d '"' -f 2)
echo -e "OS Version:    ${YELLOW}$OS_VERSION${NC}"

# Uptime
UPTIME=$(uptime -p)
echo -e "Uptime:        ${YELLOW}$UPTIME${NC}"

# Load Average
LOAD=$(uptime | awk -F'load average:' '{ print $2 }' | xargs)
echo -e "Load Average:  ${YELLOW}$LOAD${NC}"

# Logged in users
USERS=$(who | wc -l)
echo -e "Logged Users:  ${YELLOW}$USERS${NC}"

# Failed login attempts (Debian/Ubuntu usually use auth.log, RHEL/CentOS use secure)
if [ -f /var/log/auth.log ]; then
    FAILED_LOGINS=$(sudo grep -c "Failed password" /var/log/auth.log 2>/dev/null || echo "Require Sudo")
elif [ -f /var/log/secure ]; then
    FAILED_LOGINS=$(sudo grep -c "Failed password" /var/log/secure 2>/dev/null || echo "Require Sudo")
else
    FAILED_LOGINS="Log file not found"
fi
echo -e "Failed Logins: ${YELLOW}$FAILED_LOGINS${NC}\n"

# ---------------------------------------------------------
# CORE STATS (CPU, Memory, Disk)
# ---------------------------------------------------------

echo -e "${GREEN}--- Resource Usage ---${NC}"

# Total CPU Usage (100% minus the idle percentage)
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8"%"}')
echo -e "Total CPU Usage: ${YELLOW}$CPU_USAGE${NC}"

# Total Memory Usage (Free vs Used including percentage)
echo -e "Total Memory Usage:"
free -m | awk 'NR==2{printf "  Used: \033[1;33m%s MB\033[0m / Total: %s MB (%.2f%%)\n  Free: \033[1;33m%s MB\033[0m\n", $3, $2, $3*100/$2, $4 }'

# Total Disk Usage (Free vs Used including percentage)
echo -e "Total Disk Usage:"
df -h --total | awk '/^total/ {printf "  Used: \033[1;33m%s\033[0m / Total: %s (%s)\n  Free: \033[1;33m%s\033[0m\n", $3, $2, $5, $4}'
echo ""

# ---------------------------------------------------------
# TOP PROCESSES
# ---------------------------------------------------------

echo -e "${GREEN}--- Top 5 Processes by CPU Usage ---${NC}"
# PID, User, Command, CPU%, Memory%
ps -eo pid,user,cmd,%cpu,%mem --sort=-%cpu | head -n 6 | awk 'NR==1{print "\033[1;36m"$0"\033[0m"} NR>1{print $0}'
echo ""

echo -e "${GREEN}--- Top 5 Processes by Memory Usage ---${NC}"
# PID, User, Command, Memory%, CPU%
ps -eo pid,user,cmd,%mem,%cpu --sort=-%mem | head -n 6 | awk 'NR==1{print "\033[1;36m"$0"\033[0m"} NR>1{print $0}'
echo ""

echo -e "${CYAN}====================================================${NC}"
