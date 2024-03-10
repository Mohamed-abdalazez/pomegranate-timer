#!/bin/bash

source ./validate_lib.sh
source ./session_lib.sh
# Main function.
main() {

  initialize
  start_session
  save_session_info
  clear
}

# Execute main function
main
