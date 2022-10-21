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

class GameplaySettingsSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Gameplay Settings';
		rpcTitle = 'Gameplay Settings Menu'; //for Discord Rich Presence

		if (ClientPrefs.language == "English")
		{
			//I'd suggest using "Downscroll" as an example for making your own option since it is the simplest here
			var option:Option = new Option('Downscroll', //Name
				'If checked, notes go Down instead of Up, simple enough.', //Description
				'downScroll', //Save data variable name
				'bool', //Variable type
				false); //Default value
			addOption(option);

			var option:Option = new Option('Middlescroll',
				'If checked, your notes get centered.',
				'middleScroll',
				'bool',
				false);
			addOption(option);

			var option:Option = new Option('Opponent Notes',
				'If unchecked, opponent notes get hidden.',
				'opponentStrums',
				'bool',
				true);
			addOption(option);

			var option:Option = new Option('Ghost Tapping',
				"If checked, you won't get misses from pressing keys\nwhile there are no notes able to be hit.",
				'ghostTapping',
				'bool',
				true);
			addOption(option);

			var option:Option = new Option('Disable Reset Button',
				"If checked, pressing Reset won't do anything.",
				'noReset',
				'bool',
				false);
			addOption(option);

			var option:Option = new Option('Hitsound Volume',
				'Funny notes does \"Tick!\" when you hit them."',
				'hitsoundVolume',
				'percent',
				0);
			addOption(option);
			option.scrollSpeed = 1.6;
			option.minValue = 0.0;
			option.maxValue = 1;
			option.changeValue = 0.1;
			option.decimals = 1;
			option.onChange = onChangeHitsoundVolume;

			var option:Option = new Option('Rating Offset',
				'Changes how late/early you have to hit for a "Sick!"\nHigher values mean you have to hit later.',
				'ratingOffset',
				'int',
				0);
			option.displayFormat = '%vms';
			option.scrollSpeed = 20;
			option.minValue = -30;
			option.maxValue = 30;
			addOption(option);

			var option:Option = new Option('Sick! Hit Window',
				'Changes the amount of time you have\nfor hitting a "Sick!" in milliseconds.',
				'sickWindow',
				'int',
				45);
			option.displayFormat = '%vms';
			option.scrollSpeed = 15;
			option.minValue = 15;
			option.maxValue = 45;
			addOption(option);

			var option:Option = new Option('Good Hit Window',
				'Changes the amount of time you have\nfor hitting a "Good" in milliseconds.',
				'goodWindow',
				'int',
				90);
			option.displayFormat = '%vms';
			option.scrollSpeed = 30;
			option.minValue = 15;
			option.maxValue = 90;
			addOption(option);

			var option:Option = new Option('Bad Hit Window',
				'Changes the amount of time you have\nfor hitting a "Bad" in milliseconds.',
				'badWindow',
				'int',
				135);
			option.displayFormat = '%vms';
			option.scrollSpeed = 60;
			option.minValue = 15;
			option.maxValue = 135;
			addOption(option);

			var option:Option = new Option('Safe Frames',
				'Changes how many frames you have for\nhitting a note earlier or late.',
				'safeFrames',
				'float',
				10);
			option.scrollSpeed = 5;
			option.minValue = 2;
			option.maxValue = 10;
			option.changeValue = 0.1;
			addOption(option);

			var option:Option = new Option('Milliseconds display when a note is struck',
				"If unchecked, the milliseconds display when a note is hit is hidden." ,
				'msTiming',
				'bool',
				true);
			addOption(option);
		}

		if (ClientPrefs.language == "Japanese")
		{
			//I'd suggest using "Downscroll" as an example for making your own option since it is the simplest here
			var option:Option = new Option('Downscroll', //Name
				'チェックすると、ノーツは上から流れる、簡単なことです。', //Description
				'downScroll', //Save data variable name
				'bool', //Variable type
				false); //Default value
			addOption(option);

			var option:Option = new Option('Middlescroll',
				'チェックすると、ノートが中央に配置されます。',
				'middleScroll',
				'bool',
				false);
			addOption(option);

			var option:Option = new Option('Opponent Notes',
				'チェックを外すと、対戦相手のノーツが非表示になります。',
				'opponentStrums',
				'bool',
				true);
			addOption(option);

			var option:Option = new Option('Ghost Tapping',
				"チェックすると、タップ可能なノーツがないときにキーを押してもミスにならなくなります。",
				'ghostTapping',
				'bool',
				true);
			addOption(option);

			var option:Option = new Option('Disable Reset Button',
				"チェックが入っていると、リセットキーを押しても何も起こりません。",
				'noReset',
				'bool',
				false);
			addOption(option);

			var option:Option = new Option('Hitsound Volume',
				'面白い音は叩くと "チッ！"ってなるんだよ。',
				'hitsoundVolume',
				'percent',
				0);
			addOption(option);
			option.scrollSpeed = 1.6;
			option.minValue = 0.0;
			option.maxValue = 1;
			option.changeValue = 0.1;
			option.decimals = 1;
			option.onChange = onChangeHitsoundVolume;

			var option:Option = new Option('Rating Offset',
				'「Sick!」を出すために必要なタップのタイミングを変更します。値が高いほど、より遅くタップする必要があります。',
				'ratingOffset',
				'int',
				0);
			option.displayFormat = '%vms';
			option.scrollSpeed = 20;
			option.minValue = -30;
			option.maxValue = 30;
			addOption(option);

			var option:Option = new Option('Sick! Hit Window',
				'「Sick!」 を打つまでの時間をミリ秒単位で変更します。',
				'sickWindow',
				'int',
				45);
			option.displayFormat = '%vms';
			option.scrollSpeed = 15;
			option.minValue = 15;
			option.maxValue = 45;
			addOption(option);

			var option:Option = new Option('Good Hit Window',
				'「Good」を押したときの時間をミリ秒単位で変更します。',
				'goodWindow',
				'int',
				90);
			option.displayFormat = '%vms';
			option.scrollSpeed = 30;
			option.minValue = 15;
			option.maxValue = 90;
			addOption(option);

			var option:Option = new Option('Bad Hit Window',
				'「Bad」を押したときの時間をミリ秒単位で変更します。',
				'badWindow',
				'int',
				135);
			option.displayFormat = '%vms';
			option.scrollSpeed = 60;
			option.minValue = 15;
			option.maxValue = 135;
			addOption(option);

			var option:Option = new Option('Safe Frames',
				'音符を何フレーム早く鳴らすか、遅く鳴らすかを変更します。',
				'safeFrames',
				'float',
				10);
			option.scrollSpeed = 5;
			option.minValue = 2;
			option.maxValue = 10;
			option.changeValue = 0.1;
			addOption(option);

			var option:Option = new Option('Milliseconds display when a note is struck',
				"チェックを外した場合、ノーツを打ったときのミリ秒表示が非表示になります。" ,
				'msTiming',
				'bool',
				true);
			addOption(option);
		}

		super();
	}

	function onChangeHitsoundVolume()
	{
		FlxG.sound.play(Paths.sound('hitsound'), ClientPrefs.hitsoundVolume);
	}
}