#!/bin/bash

# Base directory containing category subfolders
BASE_DIR="/bwdata/THINGS"

# Loop through each category folder
for CATEGORY_DIR in "$BASE_DIR"/*/; do
    # Get category name (e.g., 'acorn')
    CATEGORY_NAME=$(basename "$CATEGORY_DIR")

    # Loop through each image in the category folder
    for IMAGE_PATH in "$CATEGORY_DIR"*.jpg; do
        # Skip if no .jpg files are found
        [ -e "$IMAGE_PATH" ] || continue

        echo "Processing $IMAGE_PATH with text prompt: $CATEGORY_NAME"

        python tools/sam_clip_text_seg.py \
            --input_image_path "$IMAGE_PATH" \
            --text "$CATEGORY_NAME"
    done
done

