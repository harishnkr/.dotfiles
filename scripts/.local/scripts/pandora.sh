#!/bin/bash

# Check if the filename and recipient are provided
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <filename.gpg> <recipient>"
  exit 1
fi

# File variables
encrypted_file="$1"
decrypted_file="${encrypted_file%.gpg}"
recipient="$2"

# Decrypt the file
gpg --output "$decrypted_file" --decrypt "$encrypted_file"
if [ $? -ne 0 ]; then
  echo "Decryption failed."
  exit 1
fi

# Open the file in an editor
$EDITOR "$decrypted_file"

# Re-encrypt the file after editing
gpg --output "$encrypted_file" --encrypt --recipient "$recipient" "$decrypted_file"
if [ $? -ne 0 ]; then
  echo "Re-encryption failed."
  exit 1
fi

# Delete the decrypted file
rm -f "$decrypted_file"

echo "File has been decrypted, edited, re-encrypted for $recipient, and the decrypted file has been deleted."

