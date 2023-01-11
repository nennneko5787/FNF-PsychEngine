package;

import flixel.graphics.FlxGraphic;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxState;
import flixel.util.FlxColor;
import openfl.Assets;
import openfl.Lib;
import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.display.StageScaleMode;
import lime.app.Application;

/*Screen Shot
import flixel.addons.plugin.screengrab.FlxScreenGrab;
import flash.display.BitmapData;
import flash.utils.ByteArray;
import flixel.addons.util.PNGEncoder;
#if sys
#if (!lime_legacy || lime < "2.9.0")
import openfl.display.PNGEncoderOptions;
#end
#else
import flash.net.FileReference;
#end
*/

#if desktop
import Discord.DiscordClient;
#end

//crash handler stuff
#if CRASH_HANDLER
import openfl.events.UncaughtErrorEvent;
import haxe.CallStack;
import haxe.io.Path;
import sys.FileSystem;
import sys.io.File;
import sys.io.Process;
#end

using StringTools;

class Main extends Sprite
{
	var game = {
		width: 1280, // WINDOW width
		height: 720, // WINDOW height
		initialState: TitleState, // initial game state
		zoom: -1.0, // game state bounds
		framerate: 60, // default framerate
		skipSplash: true, // if the default flixel splash screen should be skipped
		startFullscreen: false // if the game should start at fullscreen mode
	};
	public static var fpsVar:FPS;

	// You can pretty much ignore everything from here on - your code should go in your states.

	public static function main():Void
	{
		Lib.current.addChild(new Main());
	}

	public function new()
	{
		super();

		/*Screen Shot
		flixel.addons.plugin.screengrab.FlxScreenGrab.clearCaptureRegion();
		flixel.addons.plugin.screengrab.FlxScreenGrab.clearHotKeys();
		flixel.addons.plugin.screengrab.FlxScreenGrab.defineCaptureRegion(0, 0, game.width, game.height);
		flixel.addons.plugin.screengrab.FlxScreenGrab.defineHotKeys([F1], false, false);
		if (FlxG.keys.checkStatus(F1, JUST_PRESSED))
		{
			if (!sys.FileSystem.exists("assets/screenshots/") && !sys.FileSystem.isDirectory("assets/screenshots/"))
			{
				// path exists and is a directory
				sys.FileSystem.createDirectory("assets/screenshots/");
			}
			screenshot_save("assets/screenshots/"+Date.now().getTime()+".png");
		}
		*/
		if (stage != null)
		{
			init();
		}
		else
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}

	private function init(?E:Event):Void
	{
		if (hasEventListener(Event.ADDED_TO_STAGE))
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}

		setupGame();
	}

	private function setupGame():Void
	{
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		if (game.zoom == -1.0)
		{
			var ratioX:Float = stageWidth / game.width;
			var ratioY:Float = stageHeight / game.height;
			game.zoom = Math.min(ratioX, ratioY);
			game.width = Math.ceil(stageWidth / game.zoom);
			game.height = Math.ceil(stageHeight / game.zoom);
		}
	
		ClientPrefs.loadDefaultKeys();
		addChild(new FlxGame(game.width, game.height, game.initialState, #if (flixel < "5.0.0") game.zoom, #end game.framerate, game.framerate, game.skipSplash, game.startFullscreen));

		#if !mobile
		fpsVar = new FPS(10, 3, 0xFFFFFF);
		addChild(fpsVar);
		Lib.current.stage.align = "tl";
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		if(fpsVar != null) {
			fpsVar.visible = true;
		}
		#end

		#if html5
		FlxG.autoPause = false;
		FlxG.mouse.visible = false;
		#end
		
		#if CRASH_HANDLER
		Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onCrash);
		#end

		#if desktop
		if (!DiscordClient.isInitialized) {
			DiscordClient.initialize();
			Application.current.window.onClose.add(function() {
				DiscordClient.shutdown();
			});
		}
		#end
	}

	/*
	static function screenshot_save(Filename:String = ""):Void
	{
		if (FlxScreenGrab.screenshot.bitmapData == null)
		{
			return;
		}

		var png:ByteArray;
		#if flash
		png = PNGEncoder.encode(FlxScreenGrab.screenshot.bitmapData);
		#elseif openfl_legacy
		png = FlxScreenGrab.screenshot.bitmapData.encode(FlxScreenGrab.screenshot.bitmapData.rect, "png");
		#else
		png = FlxScreenGrab.screenshot.bitmapData.encode(FlxScreenGrab.screenshot.bitmapData.rect, new PNGEncoderOptions());
		#end

		#if !sys
		var file:FileReference = new FileReference();
		file.save(png, Filename);
		#elseif (!lime_legacy || lime < "2.9.0")
		var documentsDirectory = "";
		#if lime_legacy
		documentsDirectory = flash.filesystem.File.documentsDirectory.nativePath;
		#else
		documentsDirectory = lime.system.System.documentsDirectory;
		#end

		var path = "assets/screenshots/" + Filename;

		if (path != "" && path != null) // if path is empty, the user cancelled the save operation and we can safely do nothing
		{
			var f = sys.io.File.write(path, true);
			f.writeString(png.readUTFBytes(png.length));
			f.close();
		}
		#end
	}
*/
	// Code was entirely made by sqirra-rng for their fnf engine named "Izzy Engine", big props to them!!!
	// very cool person for real they don't get enough credit for their work
	#if CRASH_HANDLER
	function onCrash(e:UncaughtErrorEvent):Void
	{
		FlxG.fullscreen = false;
		var errMsg:String = "";
		var path:String;
		var callStack:Array<StackItem> = CallStack.exceptionStack(true);
		var dateNow:String = Date.now().toString();

		dateNow = dateNow.replace(" ", "_");
		dateNow = dateNow.replace(":", "'");

		path = "./crash/" + "PsychEngine_" + dateNow + ".txt";

		for (stackItem in callStack)
		{
			switch (stackItem)
			{
				case FilePos(s, file, line, column):
					errMsg += file + " (line " + line + ")\n";
				default:
					Sys.println(stackItem);
			}
		}

		errMsg += "\nUncaught Error: " + e.error + "\nPlease report this error to the GitHub page: https://github.com/nennneko5787/FNF-nekoEngine\n\n> Crash Handler written by: sqirra-rng";

		if (!FileSystem.exists("./crash/"))
			FileSystem.createDirectory("./crash/");

		File.saveContent(path, errMsg + "\n");

		Sys.println(errMsg);
		Sys.println("Crash dump saved in " + Path.normalize(path));

		Application.current.window.alert(errMsg, "Error!");
		DiscordClient.shutdown();
		Sys.exit(1);
	}
	#end
}
