#!/bin/bash

# Initialize the year directory and create the current date.json file
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
wlecome_message() {
  message="Hey, dude👋, this is a POMEGRANATE TIMER⌛️.\n\n🪐 Your life is like a pomegranate;\n🪐 every single granule you eat is never back again,\n🪐 and unfortunately, you do not have unlimited granules.\n🪐 So, exploit every single granule.\n"
  echo -e "$message"
}

# Start the new focus session
start_session() {
  clear
  wlecome_message
  echo -e "▫️ Now, you have to set the time you want to spend focusing\nand provide a few pieces of information for later analysis."
  echo -e "▫️ Please set the time you want to focus as hours, minutes, and seconds now:"

  read -p "🏁 Set the number of hours: " hours
  while ! validate_input_is_positive "$hours"; do
    echo "Invalid input. Please enter a valid positive integer."
    read -p "🏁 Set the number of hours: " hours
  done

  read -p "🏁 Set the number of minutes: " minutes
  while ! validate_input_is_positive "$minutes"; do
    echo "Invalid input. Please enter a valid positive integer."
    read -p "🏁 Set the number of minutes: " minutes
  done

  read -p "🏁 Set the number of seconds: " seconds
  while ! validate_input_is_positive "$seconds"; do
    echo "Invalid input. Please enter a valid positive integer."
    read -p "🏁 Set the number of seconds: " seconds
  done

  total_time=$(printf "%02d:%02d:%02d" "$hours" "$minutes" "$seconds")
  echo -e "▫️ Answer those three simple questions, please."
  read -p "〰️ What are you focusing on now? " activity
  read -p "〰️ Your motivational quote: " motivation
  read -p "〰️ On a scale of 1 to 10, how is your mood? " mood

  while ! validate_mood "$mood" 1 10; do
    echo "Invalid input. Please enter a number between 1 and 10."
    read -p "〰️ On a scale of 1 to 10, how is your mood? " mood
  done

  # calculate the total seconds
  total_seconds=$((hours * 3600 + minutes * 60 + seconds))
  remaining_seconds=$total_seconds
  # Clear the terminal screen
  clear
  display_pomegranate_timer
  play_alarm
}

# Play alarm after the timer is done
play_alarm() {
  # You can replace 'paplay' with any command that plays an alarm sound
  # And you can also customize the sound by adding the path of your sound.
  paplay /usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga
}

# Save the session information.
save_session_info() {

  start_time=$(date +"%T")
  total_time="$total_time"
  full_date=$(date +"%Y-%m-%d")

  sleep "$total_seconds"
  end_time=$(date +"%T")

  # Append session information to JSON file
  cat <<EOF >>"$today_json"
{
    "date": "$full_date",
    "start_time": "$start_time",
    "end_time": "$end_time",
    "total_time": "$total_time",
    "activity": "$activity",
    "motivation": "$motivation",
    "mood": "$mood"
}
EOF
}

# Display the fun art for simple decoration
display_pomegranate_timer() {
  cols=$(tput cols)
  width=20 # Width of the art
  spaces=$(((cols - width) / 2))

  # Print spaces and then the art
  for ((i = 0; i < 6; i++)); do
    printf "%*s" $spaces
    case $i in
    0) echo "    .--." ;;
    1) echo "   |o_o |" ;;
    2) echo "   |:_/ |" ;;
    3) echo "   |____|" ;;
    4) echo -e " Pomegranate" ;;
    5) echo "   timer⌛️" ;;
    esac
  done

  # Start the timer
  while [ $remaining_seconds -gt 0 ]; do
    hours_left=$((remaining_seconds / 3600))
    minutes_left=$(((remaining_seconds % 3600) / 60))
    seconds_left=$((remaining_seconds % 60))
    printf "\r⏰ Time remaining: %02d hours, %02d minutes, %02d seconds" "$hours_left" "$minutes_left" "$seconds_left"
    sleep 1
    remaining_seconds=$((remaining_seconds - 1))
  done
  # Print that the session is done
  echo -e "\nThe session is done, and your progress is saved✔️"
}
