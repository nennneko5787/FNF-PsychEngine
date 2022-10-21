package options;

#if desktop
import Discord.DiscordClient;
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

class ControllerSettingsSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Gameplay Settings';
		rpcTitle = 'Gameplay Settings Menu'; //for Discord Rich Presence

		if (ClientPrefs.language == "English")
		{
			var option:Option = new Option('Controller Mode',
				'Check this if you want to play with\na controller instead of using your Keyboard.',
				'controllerMode',
				'bool',
				false);
			addOption(option);

            #if !switch
            var option:Option = new Option('NS Pro Controller Mode',
                'Reverses the AB and XY buttons on the controller, respectively.' ,
                'nsProConMode',
                'bool',
                false);
            addOption(option);
            #end
		}

		if (ClientPrefs.language == "Japanese")
		{
            var option:Option = new Option('Controller Mode',
                'キーボードではなく、コントローラーでプレイしたい場合は、ここにチェックを入れてください。',
                'controllerMode',
                'bool',
                false);
            addOption(option);

            #if !switch
            var option:Option = new Option('NS Pro Controller Mode',
                'コントローラーのABボタン、XYボタンをそれぞれ反転させます。',
                'nsProConMode',
                'bool',
                false);
            addOption(option);
            #end
		}

		super();
	}
}