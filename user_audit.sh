#!/bin/bash

# 1. Check if a username argument was provided
if [ -z "$1" ]; then
    echo "Error: No username provided."
    echo "Usage: $0 <username>"
    exit 1
fi

USERNAME="$1"

# 2. Check if the user exists on the system using the 'id' command
# &> /dev/null hides the default terminal error output if the user isn't found
if id "$USERNAME" &> /dev/null; then
    echo "[SUCCESS] User '$USERNAME' exists!"
    
    # 3. Extract and display User ID (UID) and Default Shell
    # We use 'getent passwd' to look up user details safely
    USER_INFO=$(getent passwd "$USERNAME")
    UID_VAL=$(echo "$USER_INFO" | cut -d: -f3)
    SHELL_VAL=$(echo "$USER_INFO" | cut -d: -f7)

    echo "-----------------------------------"
    echo " Username : $USERNAME"
    echo " UID      : $UID_VAL"
    echo " Shell    : $SHELL_VAL"
    echo "-----------------------------------"
else
    echo "[ERROR] User '$USERNAME' does not exist on this system."
    exit 1
fi
