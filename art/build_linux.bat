@echo off
color 0a
cd ..
echo BUILDING GAME
lime build linux -release
echo.
echo done.
pause
pwd
explorer.exe export\linux\bin