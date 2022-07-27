@echo off
if {%1} == {} goto noparms

echo run %1
python %1 
goto over

:noparms
echo no py file

:over
pause