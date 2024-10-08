echo off
set branch_name=%1
set call_path=..\..\pc_%branch_name:~0,-4%
chcp 65001
call %call_path%\PI整版更新_azure_pc_mode.bat
