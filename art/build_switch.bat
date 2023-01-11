@echo off
color 0a
cd ..
echo BUILDING GAME
lime build switch -final -clean -v
echo.
echo done.
pause
pwd
explorer.exe export\release\switch\bin