echo off
set branch_name=%~nx0
set call_path=..\..\pc_%branch_name:~0,-4%
chcp 65001
call %call_path%\PI整版更新_trunk_new.bat