#!/bin/bash

read -p "Enter project name: " input
project_dir="attendance_tracker_${input}"

cleanup() {
  tar -cf "attendance_tracker_${input}_archive" "$project_dir"
  rm -rf "$project_dir"
  exit
}
trap cleanup SIGINT

if [ -d "$project_dir" ]; then
  echo "WARNING: $project_dir already exists"
fi

mkdir -p "$project_dir/Helpers"
mkdir -p "$project_dir/reports"

cp attendance_checker.py "$project_dir/"
cp assets.csv "$project_dir/Helpers/"
cp config.json "$project_dir/Helpers/"
cp reports.log "$project_dir/reports/"

if [ ! -f "$project_dir/attendance_checker.py" ]; then
  echo "ERROR: Could not copy attendance_checker.py"
  exit 1
fi
if [ ! -f "$project_dir/Helpers/assets.csv" ]; then
  echo "ERROR: Could not copy assets.csv"
  exit 1
fi
if [ ! -f "$project_dir/Helpers/config.json" ]; then
  echo "ERROR: Could not copy config.json"
  exit 1
fi
if [ ! -f "$project_dir/reports/reports.log" ]; then
  echo "ERROR: Could not copy reports.log"
  exit 1
fi

read -p "Update attendance thresholds? (y/n): " choice
if [ "$choice" = "y" ]; then
  read -p "Warning threshold (default 75): " warning
  if [ -z "$warning" ]; then
    warning=75
  fi
  case $warning in
    *[!0-9]*)
      warning=75
      ;;
  esac
  read -p "Failure threshold (default 50): " failure
  if [ -z "$failure" ]; then
    failure=50
  fi
  case $failure in
    *[!0-9]*)
      failure=50
      ;;
  esac
  sed -i '' "s/\"warning\": 75/\"warning\": $warning/" "$project_dir/Helpers/config.json"
  sed -i '' "s/\"failure\": 50/\"failure\": $failure/" "$project_dir/Helpers/config.json"
fi

if python3 --version; then
  echo "SUCCESS: python3 is installed"
else
  echo "WARNING: python3 is not installed"
fi

if [ -f "$project_dir/attendance_checker.py" ]; then
  if [ -f "$project_dir/Helpers/assets.csv" ]; then
    if [ -f "$project_dir/Helpers/config.json" ]; then
      if [ -f "$project_dir/reports/reports.log" ]; then
        echo "SUCCESS: Directory structure is valid"
      else
        echo "WARNING: Directory structure is incomplete"
      fi
    else
      echo "WARNING: Directory structure is incomplete"
    fi
  else
    echo "WARNING: Directory structure is incomplete"
  fi
else
  echo "WARNING: Directory structure is incomplete"
fi
