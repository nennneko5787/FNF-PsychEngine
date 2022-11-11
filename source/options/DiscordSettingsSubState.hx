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

class DiscordSettingsSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Discord Settings';
		rpcTitle = 'Discord Settings Menu'; //for Discord Rich Presence

		if (ClientPrefs.language == "English")
		{
			var option:Option = new Option('Rich Presence',
				"If unchecked, Rich Presence on Discord will be turned off (you must have Discord installed on your PC).",
				'richPresence',
				'bool',
				true);
			addOption(option);
            option.onChange = onChangeRP;
		}

		if (ClientPrefs.language == "Japanese")
		{
			var option:Option = new Option('Rich Presence',
				"チェックをはずした場合、DiscordのRich Presenceがオフになります(PCにDiscordがインストールされている必要があります。)",
				'richPresence',
				'bool',
				true);
			addOption(option);
            option.onChange = onChangeRP;
		}

		super();
	}

	function onChangeRP()
    {
        if (ClientPrefs.richPresence == true)
        {
			DiscordClient.initialize();
            DiscordClient.changePresence("Discord Settings Menu", null);
        }else{
            DiscordClient.changePresenceTwo(null, null);
            DiscordClient.shutdown();
        }
    }
}
