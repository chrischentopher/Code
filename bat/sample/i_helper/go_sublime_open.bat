echo off
set branch_name=%1
set svn_path=D:\Projects\branch_code\project_I\branch_%branch_name:~0,-4%
start %svn_path%
cd %svn_path%
svn up
if %2 equ "" (REM 空字符
	start "" "C:\Program Files\Sublime Text 3\sublime_text.exe" "%svn_path%"
)

