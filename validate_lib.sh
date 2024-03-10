#!/bin/bash

# validate if input is a positive integer
validate_input_is_positive() {
  if [[ $1 =~ ^[0-9]+$ ]]; then
    return 0
  else
    return 1
  fi
}

# Validate and set mood (scale of 1 to 10)
validate_mood() {
  local input=$1
  local min=$2
  local max=$3
  if [[ $input =~ ^[1-9]$|^10$ && $input -ge $min && $input -le $max ]]; then
    return 0
  else
    return 1
  fi
}