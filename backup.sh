#!/bin/bash

# This checks if the number of arguments is correct
# If the number of arguments is incorrect ( $# != 2) print error message and exit
if [[ $# != 2 ]]
then
  echo "backup.sh target_directory_name destination_directory_name"
  exit
fi

# This checks if argument 1 and argument 2 are valid directory paths
if [[ ! -d $1 ]] || [[ ! -d $2 ]]
then
  echo "Invalid directory path provided"
  exit
fi

# [TASK 1]
targetDirectory=$1
destinationDirectory=$2

# [TASK 2]
echo "Target directory: $targetDirectory"
echo "Destination directory: $destinationDirectory"

# [TASK 3]
currentTS=$(date +%s)

# [TASK 4]
backupFileName="backup-${currentTS}.tar.gz"

# We're going to:
  # 1: Go into the target directory
  # 2: Create the backup file
  # 3: Move the backup file to the destination directory

# To make things easier, we will define some useful variables...

# [TASK 5]
origAbsPath=$(pwd)

# [TASK 6]

# Change to the destination directory
cd "$destinationDirectory" || exit 1

# Save the absolute path of the destination directory
destDirAbsPath=$(pwd)

# [TASK 7]

# Return to the original directory
cd "$origAbsPath" || exit 1

# Change to the source directory
cd "$targetDirectory" || exit 1

# [TASK 8]
# Calculate the Unix timestamp from 24 hours ago
yesterdayTS=$((currentTS - 24 * 60 * 60))

# Create an empty array to store files for backup
declare -a toBackup

# [TASK 9]

# Loop through all non-hidden files and directories
for file in *
do

    # [TASK 10]

    # Check whether the file was modified in the last 24 hours
    if [[ $(date -r "$file" +%s) -gt $yesterdayTS ]]
    then

        # [TASK 11]

        # Add the file to the backup array
        toBackup+=("$file")

    fi
done


# [TASK 12]

# Create a compressed archive containing the selected files
tar -czvf "$backupFileName" "${toBackup[@]}"


# [TASK 13]

# Move the backup archive to the destination directory
mv "$backupFileName" "$destDirAbsPath/"

# Congratulations! You completed the final project for this course!
