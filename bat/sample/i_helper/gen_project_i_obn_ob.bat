echo off
setlocal enabledelayedexpansion
set source=obn.bat
set SVNS[0]=obn.bat
set SVNS[1]=ob.bat
set SVNS[2]=obn_sea.bat
set SVNS[3]=ob_sea.bat
set SVNS[4]=obn_vn.bat
set SVNS[5]=ob_vn.bat
set SVNS[6]=obn_jp.bat
set SVNS[7]=ob_jp.bat
set MAX_SVN_NUM=7
for /l %%n in (0,1,%MAX_SVN_NUM%) do ( 
	copy /Y !source! !SVNS[%%n]!
)
pause
