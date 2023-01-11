package options;

#if desktop
import lime.app.Application;
import openfl.events.UncaughtErrorEvent;
import haxe.CallStack;
import haxe.io.Path;
import Discord.DiscordClient;
import sys.FileSystem;
import sys.io.File;
import sys.io.Process;
#end

import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;

using StringTools;

class RidiculousOptionsSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Ridiculous Settings';
		rpcTitle = 'Ridiculous Settings Menu'; //for Discord Rich Presence

		if (ClientPrefs.language == "English")
		{
			var option:Option = new Option('Replace with old BF icons on the beat',
				"If checked, replace with old BF icons on the beat." ,
				'onbeattooldbf',
				'bool',
				false);
			addOption(option);
		}

		if (ClientPrefs.language == "Japanese")
		{
			var option:Option = new Option('Replace with old BF icons on the beat',
				"チェックをつけた場合、ビートすると古いBFのアイコンと入れ替えます。",
				'onbeattooldbf',
				'bool',
				false);
			addOption(option);
		}

		super();
	}
}
