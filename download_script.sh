#!/bin/bash

# Function to download data file and store in timestamped directory
download_data() {
    local url="$1"
    local file_name="$2"
    local timestamp=$(date +"%Y%m%d%H%M%S")
    local directory="./data/$timestamp"

    # Create timestamped directory
    mkdir -p "$directory"

    # Download data file
    wget -qc "$url" -O "$directory/$file_name"

    echo "Downloaded file: $directory/$file_name"
}

# Function to delete files older than 3 days
delete_old_files() {
    find ./data/* -type d -mtime +3 -exec rm -rf {} \;
}

# Main function
main() {
    # GitHub repository details
    OWNER="owid"
    REPO="covid-19-data"
    FILE="public/data/owid-covid-data.csv"
    URL="https://github.com/$OWNER/$REPO/raw/master/$FILE"

    # Download data file and store in timestamped directory
    download_data "$URL" "owid-covid-data.csv"

    # Delete files older than 3 days
    delete_old_files
}

# Call the main function
main


