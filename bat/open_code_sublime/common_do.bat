echo off
set bat_name=%1
set file_path=..\..\%bat_name:~0,-4%
echo "%file_path%"
start "" "C:\Program Files\Sublime Text 3\sublime_text.exe" "%file_path%"