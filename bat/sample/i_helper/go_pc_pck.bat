echo off
set branch_name=%1
set call_path=..\..\pc_%branch_name:~0,-4%\Azure\Output\pck
REM pck目录存在，删除再复制
if exist pck (
    rmdir %call_path% /s /q
	xcopy pck %call_path% /E /I /Y
) else (
    echo no pck copy
)
REM Output\pck 打开Output\pck, 否则打开Output
if exist %call_path% (
    start %call_path%
) else (
    start ..\..\pc_%branch_name:~0,-4%\Azure\Output
)