# Attendance Tracker Project

This is my project factory script for the attendance tracker assignment.

## How to run it

### Open terminal in this folder and type:

chmod +x project_factory.sh
./project_factory.sh

### It will ask you a few things:

- project name (like v1) and it makes a folder called attendance_tracker_v1
- if you want to change the thresholds, type y or n
- if you said y it asks for warning and failure numbers. just press enter if you want the defaults 75 and 50

### After it runs you get a folder that looks like this:

attendance_tracker_v1/
  attendance_checker.py
  Helpers/
    assets.csv
    config.json
  reports/
    reports.log

## How to trigger the archive feature

If you stop the script before its done you can press Ctrl+C.

When you do that it makes a file called attendance_tracker_{name}_archive and deletes the folder that was being made. so if something goes wrong your folder doesnt just stay there half finished.

## Video walkthrough
https://youtu.be/bWDmf-mayAQ