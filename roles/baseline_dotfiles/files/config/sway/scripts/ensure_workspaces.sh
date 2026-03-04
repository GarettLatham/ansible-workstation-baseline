#!/usr/bin/env bash
set -euo pipefail

# Check which outputs exist
if swaymsg -t get_outputs | grep -q '^Output DP-3'; then
  swaymsg 'workspace 1; move workspace to output DP-3'
fi

if swaymsg -t get_outputs | grep -q '^Output DP-5'; then
  swaymsg 'workspace 2; move workspace to output DP-5'
fi

# If undocked (only laptop screen)
if swaymsg -t get_outputs | grep -q '^Output eDP-1' && ! swaymsg -t get_outputs | grep -q '^Output DP-3'; then
  swaymsg 'workspace 1; move workspace to output eDP-1'
  swaymsg 'workspace 1'
fi
