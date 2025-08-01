#!/bin/bash

# Base directory of category subfolders
BASE_DIR="/bwdata/THINGS"

# Destination base directory for output
SAVE_BASE="/bwdata/THINGS_segmented"

for CATEGORY_DIR in "$BASE_DIR"/*/; do
    CATEGORY_NAME=$(basename "$CATEGORY_DIR")

    for IMAGE_PATH in "$CATEGORY_DIR"*.jpg; do
        [ -e "$IMAGE_PATH" ] || continue  # Skip if no jpg

        IMAGE_NAME=$(basename "$IMAGE_PATH" .jpg)
        OUTPUT_DIR="${SAVE_BASE}/${CATEGORY_NAME}"
        OUTPUT_FILE="${OUTPUT_DIR}/${IMAGE_NAME}_object_transparent.png"

        if [ ! -f "$OUTPUT_FILE" ]; then
            echo "Processing $IMAGE_PATH (text: $CATEGORY_NAME)"
            python tools/sam_clip_text_seg.py \
                --input_image_path "$IMAGE_PATH" \
                --text "$CATEGORY_NAME"
        else
            echo "Skipping $IMAGE_PATH — already processed"
        fi
    done
done

