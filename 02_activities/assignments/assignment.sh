#!/bin/bash
# set -x # disable debug trace 

# === COLORS ===
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color

echo -e "${MAGENTA}############################################${NC}"
echo -e "${MAGENTA}# DSI CONSULTING INC. Project setup script #${NC}"
echo -e "${MAGENTA}############################################${NC}"
echo -e "${MAGENTA}# This script creates standard analysis and output directories${NC}"
echo -e "${MAGENTA}# for a new project. It also creates a README file with the${NC}"
echo -e "${MAGENTA}# project name and a brief description of the project.${NC}"
echo -e "${MAGENTA}# Then it unzips the raw data provided by the client.${NC}"

if [ -d newproject ]; then
  echo "Directory 'newproject' already exists. Please remove it before running this script."
  exit 1
fi
mkdir newproject
cd newproject

mkdir analysis output
touch README.md
touch analysis/main.py

# download client data
curl -Lo rawdata.zip https://github.com/UofT-DSI/shell/raw/refs/heads/main/02_activities/assignments/rawdata.zip
unzip -q rawdata.zip
echo -e "${GREEN}Status: file unzipped${NC}"



###########################################
# Complete assignment here

# 1. Create a directory named data
mkdir -p ./data/raw
echo -e "${GREEN}Status: created folder: ./data/raw${NC}"

# *2. Move the files in ./rawdata directory to ./data/raw
## *Change to "COPY: to files in ./rawdata/* into /data/raw in case something are accidientally deleted and we dont need to run 'unzipped' 
cp ./rawdata/* ./data/raw
echo -e "${GREEN}Status: copied files${NC}"

# 3. List the contents of the ./data/raw directory
echo -e "${GREEN}Status: listing the content in the working folder:./data/raw${NC}"
ls -r ./data/raw

# 4. In ./data/processed, create the following directories: server_logs, user_logs, and event_logs
mkdir -p ./data/processed/server_logs
mkdir -p ./data/processed/user_logs
mkdir -p ./data/processed/event_logs

# 7. For user privacy, remove all files containing IP addresses (files with "ipaddr" in the filename) from ./data/raw and ./data/processed/user_logs
rm ./data/raw/*ipaddr*
echo -e "${YELLOW}Status: deleting privacy related files${NC}"
ls -r ./data/raw/*ipaddr* # it should return nothing and show as warming



# 5. Copy all server log files (files with "server" in the name AND a .log extension) from ./data/raw to ./data/processed/server_logs
cp ./data/raw/server_*.log  ./data/processed/server_logs

# 6. Repeat the above step for user logs and event logs
cp ./data/raw/user_*.log  ./data/processed/user_logs
cp ./data/raw/event_*.log  ./data/processed/event_logs

# 8. Create a file named ./data/inventory.txt that lists all the files in the subfolders of ./data/processed
echo -e "${GREEN}Status: creating inventory.txt${NC}"
ls -R ./data/processed > ./data/inventory.txt
ls -R ./data/processed # output to terminal for visual check

# *9. Delete the rawdata folder
rm -rf ./rawdata

###########################################

echo -e "${GREEN}Status: Project setup is complete!${NC}"
