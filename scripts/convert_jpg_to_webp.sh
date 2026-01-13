#!/bin/bash

# Script to convert all JPG files to WebP format
# Uses cwebp tool with quality setting of 85

QUALITY=85
ASSETS_DIR="assets"
CONVERTED_COUNT=0
FAILED_COUNT=0

# Find cwebp command (check common locations)
CWEBP_CMD=""
if command -v cwebp &> /dev/null; then
    CWEBP_CMD="cwebp"
elif [ -f "/opt/homebrew/bin/cwebp" ]; then
    CWEBP_CMD="/opt/homebrew/bin/cwebp"
elif [ -f "/usr/local/bin/cwebp" ]; then
    CWEBP_CMD="/usr/local/bin/cwebp"
else
    echo "Error: cwebp is not installed."
    echo "Install it using: brew install webp (on macOS)"
    echo "Or download from: https://developers.google.com/speed/webp/download"
    exit 1
fi

echo "Starting JPG to WebP conversion..."
echo "Quality setting: $QUALITY"
echo ""

# Function to convert a single file
convert_file() {
    local jpg_file="$1"
    local webp_file="${jpg_file%.jpg}.webp"
    
    # Skip if WebP already exists
    if [ -f "$webp_file" ]; then
        echo "Skipping $jpg_file (WebP already exists)"
        return 0
    fi
    
    # Convert using cwebp
    if "$CWEBP_CMD" -q "$QUALITY" "$jpg_file" -o "$webp_file" 2>/dev/null; then
        echo "✓ Converted: $jpg_file → $webp_file"
        ((CONVERTED_COUNT++))
        return 0
    else
        echo "✗ Failed: $jpg_file"
        ((FAILED_COUNT++))
        return 1
    fi
}

# Find and convert all JPG files recursively
find "$ASSETS_DIR" -type f \( -iname "*.jpg" -o -iname "*.JPG" \) | while read -r jpg_file; do
    convert_file "$jpg_file"
done

echo ""
echo "Conversion complete!"
echo "Converted: $CONVERTED_COUNT files"
if [ $FAILED_COUNT -gt 0 ]; then
    echo "Failed: $FAILED_COUNT files"
fi
