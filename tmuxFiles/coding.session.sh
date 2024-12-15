# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/Desktop/School/Y2S2"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "School/Code"; then

  new_window "term"
  new_window "edit"
  new_window "note"
  new_window "test"
  select_window 3
  run_cmd "cd ~/notes"
  run_cmd "nvim"
  select_window 2  
  run_cmd "nvim"

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
