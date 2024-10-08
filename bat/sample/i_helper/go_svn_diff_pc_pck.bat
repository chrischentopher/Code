echo off
set branch_name=%1
set branch_name=%branch_name:~0,-4%
set source_dir=D:\Projects\branch_code\project_I\branch_%branch_name%\Azure\Output\Lua
svn up %source_dir%
set dest_dir=pck\Lua
REM pck目录存在，删除再复制
rmdir pck /s /q
REM 复制Lua中更改的文件
setlocal enabledelayedexpansion
for /f "delims=" %%F in ('svn diff --summarize "%source_dir%"') do (
  set file=%%F
  set source_file=!file:~8!
  set dir_file=!source_file:%source_dir%=%dest_dir%!
  echo F | xcopy /i /y /q !source_file! !dir_file!
)
set call_path=..\..\pc_%branch_name%\Azure\Output\pck
REM pck目录存在，删除再复制
rmdir %call_path% /s /q
xcopy pck %call_path% /E /I /Y
if exist %call_path% (
    start %call_path%
) else (
    start ..\..\pc_%branch_name%\Azure\Output
)