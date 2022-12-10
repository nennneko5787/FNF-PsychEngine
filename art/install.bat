@echo off
color 0a
echo START INSTALL
haxelib install lime
haxelib install openfl
haxelib install flixel
haxelib install flixel-addons
haxelib install flixel-ui
haxelib install hscript
haxelib install newgrounds
haxelib run lime setup
haxelib install flixel-tools
haxelib run flixel-tools setup
haxelib git polymod https://github.com/larsiusprime/polymod.git
haxelib git discord_rpc https://github.com/Aidan63/linc_discord-rpc
haxelib git linc_luajit https://github.com/nebulazorua/linc_luajit
haxelib install hxCodec
haxelib install hxcpp
haxelib git flixel-addons https://github.com/HaxeFlixel/flixel-addons
haxelib install hxcpp-debug-server
pause