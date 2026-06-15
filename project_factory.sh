#!/bin/bash

read -p "Enter project name: " input
project_dir="attendance_tracker_${input}"

cleanup() {
  tar -cf "attendance_tracker_${input}_archive" "$project_dir"
  rm -rf "$project_dir"
  exit
}
trap cleanup SIGINT

mkdir -p "$project_dir/Helpers"
mkdir -p "$project_dir/reports"
cp attendance_checker.py "$project_dir/"
cp assets.csv "$project_dir/Helpers/"
cp config.json "$project_dir/Helpers/"
cp reports.log "$project_dir/reports/"

read -p "Update attendance thresholds? (y/n): " choice
if [ "$choice" = "y" ]; then
  read -p "Warning threshold (default 75): " warning
  warning=${warning:-75}
  if ! [[ "$warning" =~ ^[0-9]+$ ]]; then
    warning=75
  fi
  read -p "Failure threshold (default 50): " failure
  failure=${failure:-50}
  if ! [[ "$failure" =~ ^[0-9]+$ ]]; then
    failure=50
  fi
  sed -i '' "s/\"warning\": 75/\"warning\": $warning/" "$project_dir/Helpers/config.json"
  sed -i '' "s/\"failure\": 50/\"failure\": $failure/" "$project_dir/Helpers/config.json"
fi

if python3 --version; then
  echo "SUCCESS: python3 is installed"
else
  echo "WARNING: python3 is not installed"
fi

if [ -f "$project_dir/attendance_checker.py" ] && [ -f "$project_dir/Helpers/assets.csv" ] && [ -f "$project_dir/Helpers/config.json" ] && [ -f "$project_dir/reports/reports.log" ]; then
  echo "SUCCESS: Directory structure is valid"
else
  echo "WARNING: Directory structure is incomplete"
fi
