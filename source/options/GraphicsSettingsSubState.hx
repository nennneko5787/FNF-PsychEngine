package options;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxCamera;
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
import openfl.Lib;

using StringTools;

class GraphicsSettingsSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Graphics';
		rpcTitle = 'Graphics Settings Menu'; //for Discord Rich Presence

		if (ClientPrefs.language == "English")
		{
			//I'd suggest using "Low Quality" as an example for making your own option since it is the simplest here
			var option:Option = new Option('Low Quality', //Name
				'If checked, disables some background details,\ndecreases loading times and improves performance.', //Description
				'lowQuality', //Save data variable name
				'bool', //Variable type
				false); //Default value
			addOption(option);

			var option:Option = new Option('Anti-Aliasing',
				'If unchecked, disables anti-aliasing, increases performance\nat the cost of sharper visuals.',
				'globalAntialiasing',
				'bool',
				true);
			option.showBoyfriend = true;
			option.onChange = onChangeAntiAliasing; //Changing onChange is only needed if you want to make a special interaction after it changes the value
			addOption(option);

			var option:Option = new Option('Shaders', //Name
				'If unchecked, disables shaders.\nIt\'s used for some visual effects, and also CPU intensive for weaker PCs.', //Description
				'shaders', //Save data variable name
				'bool', //Variable type
				true); //Default value
			addOption(option);

			#if !html5 //Apparently other framerates isn't correctly supported on Browser? Probably it has some V-Sync shit enabled by default, idk
			var option:Option = new Option('Framerate',
				"Pretty self explanatory, isn't it?",
				'framerate',
				'int',
				60);
			addOption(option);

			option.minValue = 1;
			option.maxValue = 240;
			option.displayFormat = '%v FPS';
			option.onChange = onChangeFramerate;
			#end
		}
		if (ClientPrefs.language == "Japanese")
		{
			//I'd suggest using "Low Quality" as an example for making your own option since it is the simplest here
			var option:Option = new Option('Low Quality', //Name
				'チェックすると、背景の内容を一部無効化し、読み込み時間を短縮してパフォーマンスを向上させることができます。', //Description
				'lowQuality', //Save data variable name
				'bool', //Variable type
				false); //Default value
			addOption(option);

			var option:Option = new Option('Anti-Aliasing',
				'チェックを外すと、アンチエイリアシングが無効になり、鮮明なビジュアルと引き換えにパフォーマンスが向上します。',
				'globalAntialiasing',
				'bool',
				true);
			option.showBoyfriend = true;
			option.onChange = onChangeAntiAliasing; //Changing onChange is only needed if you want to make a special interaction after it changes the value
			addOption(option);

			var option:Option = new Option('Shaders', //Name
				'チェックを外すと、シェーダーを無効にします。シェーダーは一部の視覚効果に使用され、低スペックPCでは少し重いかもしれません。', //Description
				'shaders', //Save data variable name
				'bool', //Variable type
				true); //Default value
			addOption(option);

			#if !html5 //Apparently other framerates isn't correctly supported on Browser? Probably it has some V-Sync shit enabled by default, idk
			var option:Option = new Option('Framerate',
				"かなり自明ではないでしょうか？",
				'framerate',
				'int',
				60);
			addOption(option);

			option.minValue = 1;
			option.maxValue = 240;
			option.displayFormat = '%v FPS';
			option.onChange = onChangeFramerate;
			#end
		}
		super();
	}

	function onChangeAntiAliasing()
	{
		for (sprite in members)
		{
			var sprite:Dynamic = sprite; //Make it check for FlxSprite instead of FlxBasic
			var sprite:FlxSprite = sprite; //Don't judge me ok
			if(sprite != null && (sprite is FlxSprite) && !(sprite is FlxText)) {
				sprite.antialiasing = ClientPrefs.globalAntialiasing;
			}
		}
	}

	function onChangeFramerate()
	{
		if(ClientPrefs.framerate > FlxG.drawFramerate)
		{
			FlxG.updateFramerate = ClientPrefs.framerate;
			FlxG.drawFramerate = ClientPrefs.framerate;
		}
		else
		{
			FlxG.drawFramerate = ClientPrefs.framerate;
			FlxG.updateFramerate = ClientPrefs.framerate;
		}
	}
}