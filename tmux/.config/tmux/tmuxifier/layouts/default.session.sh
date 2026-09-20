# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
# session_root "~"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "default"; then

  # Create a new window inline within session layout definition.
  new_window "misc"
  new_window "notes"

  # Select the default active window on session creation.
  select_window "notes"
  run_cmd "cd ~/Documents/Main"
  run_cmd "nvim -c 'Neotree filesystem current'"

  select_window "misc"
  run_cmd "yazi"

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
