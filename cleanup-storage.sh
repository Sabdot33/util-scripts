#!/bin/bash

# Cleanup Script for Ubuntu: RUN ONLY IN BASH
# Removes old logs, cleans up temp files, and frees up disk space.

echo "Starting system cleanup..."

# 1. Remove old system logs
echo "Cleaning up old system logs..."
sudo journalctl --vacuum-time=7d  # Keep only 7 days of logs

# 2. Clear APT cache
echo "Cleaning up APT cache..."
sudo apt-get clean               # Removes downloaded package files
sudo apt-get autoclean           # Removes outdated package files

# 3. Remove orphaned packages
echo "Removing orphaned packages..."
sudo apt-get autoremove -y       # Removes unused dependencies

# 4. Clear temporary files
echo "Cleaning up temporary files..."
sudo rm -rf /tmp/*               # Clears the /tmp directory
sudo rm -rf /var/tmp/*           # Clears the /var/tmp directory

# 5. Remove old logrotate archives
echo "Removing old logrotate archives..."
sudo find /var/log -type f -name "*.gz" -delete  # Deletes compressed logs
sudo find /var/log -type f -name "*.1" -delete   # Deletes rotated logs (e.g., syslog.1)

# 6. Clear user-level cache (optional)
echo "Clearing user cache..."
rm -rf ~/.cache/*                # Clears the user's cache directory

# 7. Remove unused Docker data (if Docker is installed)
if command -v docker &> /dev/null; then
    echo "Cleaning up unused Docker data..."
    docker system prune -af      # Removes unused Docker containers, images, and volumes
fi

# 8. Check for large files in home directory (optional)
echo "Do you want to search for large files (>100MB) in your home directory? (y/n)"
read -t 10 -n 1 -r
echo    # move to a new line

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Searching for large files in your home directory (>100MB)..."
    find ~ -type f -size +100M
elif [ -z "$REPLY" ]; then
    echo "No input received. Skipping large file search."
else
    echo "Skipping large file search."
fi

# Final message
echo "System cleanup completed!"
