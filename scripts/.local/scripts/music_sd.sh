
#!/bin/bash

# Set paths
SOURCE="/home/harishnkr/Music"
DEST="/run/media/harishnkr/disk/Music"

# Check if source exists
if [ ! -d "$SOURCE" ]; then
    echo "Error: Source folder does not exist: $SOURCE"
    exit 1
fi

# Check if destination exists
if [ ! -d "$DEST" ]; then
    echo "Error: Destination folder does not exist: $DEST"
    exit 1
fi

# Show what will happen
echo "About to sync:"
echo "  Source:      $SOURCE/"
echo "  Destination: $DEST/"
echo
read -p "Do you want to continue? (y/N): " confirm

if [[ "$confirm" =~ ^[Yy]$ ]]; then
    echo "Running rsync..."
    rsync -avh --delete --progress "$SOURCE"/ "$DEST"/
    echo "Done."
else
    echo "Aborted."
    exit 0
fi
