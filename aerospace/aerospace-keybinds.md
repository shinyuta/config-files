# AeroSpace Keybinds Documentation

## Layout Control

| Keybind       | Action                                 | Description                        |
| ------------- | -------------------------------------- | ---------------------------------- |
| `Alt-/`       | Tiles Layout (Horizontal/Vertical)     | Change window layout to tiling.    |
| `Alt-,`       | Accordion Layout (Horizontal/Vertical) | Change window layout to accordion. |
| `Alt-Shift-m` | Fullscreen Current Window              | Maximizes the current window.      |

---

## Focus Navigation

| Keybind | Action             | Description                            |
| ------- | ------------------ | -------------------------------------- |
| `Alt-h` | Focus Left Window  | Move focus to the window on the left.  |
| `Alt-j` | Focus Down Window  | Move focus to the window below.        |
| `Alt-k` | Focus Up Window    | Move focus to the window above.        |
| `Alt-l` | Focus Right Window | Move focus to the window on the right. |

---

## Move Windows

| Keybind       | Action            | Description                   |
| ------------- | ----------------- | ----------------------------- |
| `Alt-Shift-h` | Move Window Left  | Move the active window left.  |
| `Alt-Shift-j` | Move Window Down  | Move the active window down.  |
| `Alt-Shift-k` | Move Window Up    | Move the active window up.    |
| `Alt-Shift-l` | Move Window Right | Move the active window right. |

---

## Resize Windows

| Keybind       | Action                | Description                       |
| ------------- | --------------------- | --------------------------------- |
| `Alt-Shift--` | Shrink Current Window | Reduce window size by 50 units.   |
| `Alt-Shift-=` | Expand Current Window | Increase window size by 50 units. |

---

## Workspace Navigation

| Keybind                        | Action                         | Description                                |
| ------------------------------ | ------------------------------ | ------------------------------------------ |
| `Alt-1` to `Alt-6`             | Switch to Workspace 1-6        | Jump to specified workspace.               |
| `Alt-Shift-1` to `Alt-Shift-6` | Move Window to Workspace 1-6   | Move active window to specified workspace. |
| `Alt-Tab`                      | Workspace Back and Forth       | Toggle between current and last workspace. |
| `Alt-Shift-Tab`                | Move Workspace to Next Monitor | Move active workspace to the next monitor. |

---

## Service Mode

| Keybind             | Action                    | Description                                                        |
| ------------------- | ------------------------- | ------------------------------------------------------------------ |
| `Alt-Shift-;`       | Enter Service Mode        | Switch to service mode for advanced commands.                      |
| `Esc`               | Reload Config             | Reload Aerospace configuration.                                    |
| `r`                 | Reset Layout              | Flatten workspace tree layout.                                     |
| `f`                 | Toggle Floating/Tiling    | Change between floating and tiling modes.                          |
| `Backspace`         | Close All But Current     | Closes all other windows in workspace.                             |
| `Alt-Shift-h/j/k/l` | Join Window with Neighbor | Merge current window with its neighbor in the specified direction. |

---

## Automatic Workspace Assignment

| App                | Workspace |
| ------------------ | --------- |
| Zen Browser (zen)  | 1         |
| Safari             | 1         |
| iTerm2             | 2         |
| Notes              | 3         |
| Calendar           | 3         |
| Finder             | 4         |
| Stremio            | 5         |
| Poolside           | 5         |
| System Preferences | 6         |

---

## Additional Behavior

- Mouse follows focus when monitor changes.
- Mouse recenters on newly focused window.
- All other unlisted apps default to floating windows.

---

## Config Path

This documentation corresponds to the configuration found at:

`~/.aerospace.toml`

---
