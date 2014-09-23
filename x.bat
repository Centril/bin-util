@ECHO OFF

set loc=%1
IF "%loc%" == "" set loc=%PROGRAMMING%

cmd /k "%CMDER%vendor\init.bat"  -new_console:d:"%loc%"