# Set a custom session root path. Default is `$HOME`.
session_root "~/Desktop"

# Create session with specified name if it does not already exist.
if initialize_session "coding"; then

  # Create first window "wiki"
  new_window "wiki"
  window_root "~/Desktop/wiki"

  # Create second window "terminal" and auto-run nvim
  new_window "terminal"
  run_cmd "nvim"

  # Create third window "extra"
  new_window "extra"

  # Select first window by default
  select_window 1

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
