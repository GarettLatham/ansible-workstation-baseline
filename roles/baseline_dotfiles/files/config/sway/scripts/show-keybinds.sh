#!/usr/bin/env bash
set -euo pipefail

CONFIG="${HOME}/.config/sway/config"

# Build a list of "DISPLAY :: COMMAND" lines.
# - Skips bindsym options like --release/--locked/--to-code
# - Shows $mod as "Super" for readability (display-only)
entries="$(
  awk '
    BEGIN { OFS=" " }
    /^[[:space:]]*bindsym[[:space:]]/ {
      # Tokenize the line
      n = split($0, a, /[[:space:]]+/)

      # a[1] is bindsym
      i = 2

      # Skip bindsym flags: --release, --locked, --to-code, etc.
      while (i <= n && a[i] ~ /^--/) i++

      # Next token is the key combo
      key = a[i]; i++

      # Remaining tokens form the command
      cmd = ""
      for (; i <= n; i++) {
        cmd = cmd (cmd=="" ? "" : " ") a[i]
      }

      if (key != "" && cmd != "") {
        # Print as: key :: cmd
        print key, "::", cmd
      }
    }
  ' "$CONFIG" |
    sed 's/\$mod/Super/g'
)"

# Show in wofi and capture selection
selected="$(printf '%s\n' "$entries" | wofi --dmenu --prompt "Sway keybinds (Enter to run)" --width 1100 --height 700 || true)"
[ -z "${selected:-}" ] && exit 0

# Extract command (everything after " :: ")
cmd="${selected#* :: }"

# Execute through swaymsg
# (swaymsg understands commands like: exec ..., workspace 1, move ..., etc.)
swaymsg "$cmd" >/dev/null
