#!/bin/bash
set -x # debug trace ON

echo -e  "############################################"
echo -e  "# DSI CONSULTING INC. Project setup script #"
echo -e  "############################################\033[0m"
echo -e  "# This script creates standard analysis and output directories\033[0m"
echo -e  "# for a new project. It also creates a README file with the\033[0m"
echo -e  "# project name and a brief description of the project.\033[0m"
echo -e  "# Then it unzips the raw data provided by the client.\033[0m"

if [ -d newproject ]; then
  echo "Directory 'newproject' already exists. Please remove it before running this script."
  exit 1
fi
mkdir newproject
cd newproject

mkdir analysis output
touch README.md
echo "# Project Name: DSI Consulting Inc." > README.md
touch analysis/main.py

# download client data
curl -Lo rawdata.zip https://github.com/UofT-DSI/shell/raw/refs/heads/main/02_activities/assignments/rawdata.zip
unzip -q rawdata.zip
echo -e "\033[1;32mStatus: file unzipped\033[0m"

###########################################
# Complete assignment here

# 1. Create a directory named data
mkdir data
echo -e "\033[1;32mStatus: created folder: ./edata\033[0m"

# 2. Move the ./rawdata directory to ./data/raw
mv rawdata data/raw
echo -e "\033[1;32mStatus: files moved to ./data/raw\033[0m"

# 3. List the contents of the ./data/raw directory
echo -e "\033[1;32mStatus: listing the content in the working folder:./data/raw\033[0m"
ls data/raw/

# 4. In ./data/processed, create the following directories:cp data/raw/server_*.log  data/processed/server_logs server_logs, user_logs, and event_logs
mkdir -p data/processed/server_logs
mkdir -p data/processed/user_logs
mkdir -p data/processed/event_logs

echo -e "\033[1;32mStatus: create the following directories:
            ./data/processed/server_logs
            ./data/processed/user_logs
            ./data/processed/event_logs
            \033[0m"

# 5. Copy all server log files (files with "server" in the name AND a .log extension) from ./data/raw to ./data/processed/server_logs
cp data/raw/server_*.log  data/processed/server_logs

# 6. Repeat the above step for user logs and event logs
cp data/raw/user_*.log  data/processed/user_logs
cp data/raw/event_*.log  data/processed/event_logs

# 7. For user privacy, remove all files containing IP addresses (files with "ipaddr" in the filename) from ./data/raw and ./data/processed/user_logs
rm data/raw/*ipaddr*
rm data/processed/user_logs/*ipaddr*
echo -e "\033[1;33mStatus: deleting privacy related files\033[0m"
ls -R data/processed | grep ipaddr 

# 8. Create a file named ./data/inventory.txt that lists all the files in the subfolders of ./data/processed
echo -e "Status: creating inventory.txt"
find data/processed -type f > data/inventory.txt

###########################################
echo -e "\033[1;32mStatus: Project setup is complete!\033[0m"