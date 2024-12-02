#!/bin/bash

CONFIG_DIR="$HOME/.config/sketchybar"
LABELS=("" "" "" "" "" "" "" "") # Adjust these as needed
INDEX=0

sketchybar --add event aerospace_workspace_change

# Add a bar item for each workspace
for sid in $(aerospace list-workspaces --all); do
    label="${LABELS[$INDEX]}"
    
    sketchybar --add item space.$sid left \
        --subscribe space.$sid aerospace_workspace_change \
        --set space.$sid \
        label.font="JetBrainsMono Nerd Font:Regular:15.0" \
        background.corner_radius=5 \
        background.height=20 \
        background.drawing=off \
        icon.padding_left=0 \
        icon.padding_right=0 \
        label.padding_left=3 \
        label.padding_right=3 \
        label="$label" \
        click_script="aerospace workspace $sid" \
        script="$CONFIG_DIR/plugins/aerospace.sh $sid"
    
    INDEX=$((INDEX + 1))
done
