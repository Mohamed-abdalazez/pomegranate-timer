#!/bin/bash

# Initialize the year directory and create the current date.json file.
initialize() {
  year=$(date +"%Y")
  month=$(date +"%m")
  day=$(date +"%d")

  year_dir="$year"
  today_json="$year_dir/$month-$day-$year.json"

  # Create directory if it doesn't exist.
  mkdir -p "$year_dir"

  # Create JSON file if it doesn't exist.

  if [ ! -f "$today_json" ]; then
    touch "$today_json"
  fi
}

# Welcome Message.
#wlecome_message() {}

# Start the new focus session.
#start_session() {}

# Play alarm after the timer is done.
#play_alarm() {}

# Save the session information.
#save_session_info() {}

# Display the fun art for simple decoration.
#display_pomegranate_timer

# Main function.
main() {
  initialize
}
# Execute main function
main
