echo off
setlocal enabledelayedexpansion
set source=obn2.bat
set SVNS[0]=obn2.bat
set SVNS[1]=obn.bat
set SVNS[2]=ob.bat
set SVNS[3]=obn2_sea.bat
set SVNS[4]=obn_sea.bat
set SVNS[5]=ob_sea.bat
set SVNS[6]=obn2_vn.bat
set SVNS[7]=obn_vn.bat
set SVNS[8]=ob_vn.bat
set SVNS[9]=obn2_jp.bat
set SVNS[10]=obn_jp.bat
set SVNS[11]=ob_jp.bat
set SVNS[12]=ob_red.bat
set SVNS[13]=harmony.bat
set MAX_SVN_NUM=13
for /l %%n in (0,1,%MAX_SVN_NUM%) do ( 
	copy /Y !source! !SVNS[%%n]!
)
pause
