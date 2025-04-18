#!/usr/bin/env bash

# Set save directory for recordings
SAVE_DIR="$HOME/Videos/Recordings"
mkdir -p "$SAVE_DIR"

# Recording status file for Waybar
STATUS_FILE="/tmp/recording_status.txt"
PID_FILE="/tmp/recording_pid.txt"  # File to store the PID of the current recording

# Notify function to show notifications using swaync
notify() {
  local title="$1"
  local message="$2"
  notify-send "$title: $message"  # Use swaync for notification
}

# Update Waybar status
update_waybar() {
  echo "$1" > "$STATUS_FILE"
}

# Start recording
start_recording() {
  if [[ -f "$PID_FILE" ]]; then
      stop_recording
      return
  fi
  # Define the output filename with timestamp
  local output_file="$SAVE_DIR/$(date +%Y%m%d_%H%M%S).mp4"
  
  # Start wf-recorder
  wf-recorder -f "$output_file" &
  RECORD_PID=$!

  # Save the PID to a file
  echo $RECORD_PID > "$PID_FILE"

  # Notify start and update Waybar
  notify "Recording Started" "Recording has started, saving to: $output_file"
  update_waybar "Recording... $output_file"
}

# Stop recording and rename (if requested)
stop_recording() {
  # Check if PID file exists
  if [[ ! -f "$PID_FILE" ]]; then
    notify "Error" "No recording is currently active."
    return
  fi

  # Read the PID from the file
  RECORD_PID=$(cat "$PID_FILE")

  # Stop the recording by killing the wf-recorder process
  kill $RECORD_PID
  wait $RECORD_PID 2>/dev/null

  # Get the last recorded file
  last_recorded_file=$(ls -t "$SAVE_DIR"/*.mp4 | head -n 1)

  # Notify stop and ask for renaming if desired
  notify "Recording Finished" "Recording stopped. File saved to: $last_recorded_file"
  update_waybar "Stopped. File saved: $last_recorded_file"

  # Prompt for renaming
  rename_prompt "$last_recorded_file"

  # Remove the PID file after stopping the recording
  rm -f "$PID_FILE"
}

# Rename the recording file
rename_prompt() {
  local file="$1"
  # Ask user for new name
  new_name=$(zenity --entry --title="Rename Recording" --text="Enter new name (without extension):" --entry-text "$(basename "$file" .mp4)")

  if [[ -n "$new_name" ]]; then
    # Rename the file
    mv "$file" "$SAVE_DIR/$new_name.mp4"
    notify "Recording Renamed" "Recording renamed to: $new_name.mp4"
    update_waybar "Renamed to: $new_name.mp4"
  else
    notify "No Rename" "Recording not renamed."
  fi
}

# Status function for Waybar
get_status() {
  # Check if a recording is ongoing
  if [[ -f "$PID_FILE" ]]; then
    # Read the PID from the file
    RECORD_PID=$(cat "$PID_FILE")
    
    # Check if the process is still running
    if ps -p $RECORD_PID > /dev/null; then
      echo ""
    else
      echo ""  # Recording finished
    fi
  else
    echo ""  # No recording
  fi
}

# Main
case "$1" in
  start)
    start_recording
    ;;
  # stop)
  #   stop_recording
  #   ;;
  status)
    get_status  # Show recording status for Waybar
  ;;
  *)
    echo "Usage: $0 {start|stop|status}"
    ;;
esac

