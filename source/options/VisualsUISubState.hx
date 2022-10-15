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

class VisualsUISubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Visuals and UI';
		rpcTitle = 'Visuals & UI Settings Menu'; //for Discord Rich Presence

		if (ClientPrefs.language == "English")
		{
			var option:Option = new Option('Note Splashes',
				"If unchecked, hitting \"Sick!\" notes won't show particles.",
				'noteSplashes',
				'bool',
				true);
			addOption(option);

			var option:Option = new Option('Hide HUD',
				'If checked, hides most HUD elements.',
				'hideHud',
				'bool',
				false);
			addOption(option);
			
			var option:Option = new Option('Time Bar:',
				"What should the Time Bar display?",
				'timeBarType',
				'string',
				'Time Left',
				['Time Left', 'Time Elapsed', 'Song Name', 'Disabled']);
			addOption(option);

			var option:Option = new Option('Flashing Lights',
				"Uncheck this if you're sensitive to flashing lights!",
				'flashing',
				'bool',
				true);
			addOption(option);

			var option:Option = new Option('Camera Zooms',
				"If unchecked, the camera won't zoom in on a beat hit.",
				'camZooms',
				'bool',
				true);
			addOption(option);

			var option:Option = new Option('Score Text Zoom on Hit',
				"If unchecked, disables the Score text zooming\neverytime you hit a note.",
				'scoreZoom',
				'bool',
				true);
			addOption(option);

			var option:Option = new Option('Health Bar Transparency',
				'How much transparent should the health bar and icons be.',
				'healthBarAlpha',
				'percent',
				1);
			option.scrollSpeed = 1.6;
			option.minValue = 0.0;
			option.maxValue = 1;
			option.changeValue = 0.1;
			option.decimals = 1;
			addOption(option);
			
			#if !mobile
			var option:Option = new Option('Show FPS',
				'If unchecked, hide the FPS counter.' ,
				'showFPS',
				'bool',
				true);
			addOption(option);

			var option:Option = new Option('Show Memory Usage',
				'If unchecked, hide memory usage.' ,
				'showMemory',
				'bool',
				true);
			addOption(option);

			var option:Option = new Option('Show Memory Heap',
				'If unchecked, hide the maximum memory usage.' ,
				'showMemoryHeap',
				'bool',
				true);
			addOption(option);

			var option:Option = new Option('Show Version',
				'If unchecked, hide the version.' ,
				'showVersion',
				'bool',
				true);
			addOption(option);
			#end
			
			var option:Option = new Option('Pause Screen Song:',
				"What song do you prefer for the Pause Screen?",
				'pauseMusic',
				'string',
				'Tea Time',
				['None', 'Breakfast', 'Tea Time']);
			addOption(option);
			option.onChange = onChangePauseMusic;
			
			#if CHECK_FOR_UPDATES
			var option:Option = new Option('Check for Updates',
				'On Release builds, turn this on to check for updates when you start the game.',
				'checkForUpdates',
				'bool',
				true);
			addOption(option);
			#end

			var option:Option = new Option('Combo Stacking',
				"If unchecked, Ratings and Combo won't stack, saving on System Memory and making them easier to read",
				'comboStacking',
				'bool',
				true);
			addOption(option);

			var option:Option = new Option('Language:',
				"Currently there are only two choices, English and Japanese!",
				'language',
				'string',
				'English',
				['English','Japanese']);
			addOption(option);

			var option:Option = new Option('Free Play Auto song playback',
				"If checked, the song will play automatically during free play." ,
				'freeplayAutoPlaySong',
				'bool',
				false);
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
			var option:Option = new Option('Note Splashes',
				"チェックを外すと、「Sick!」ノーツを打ってもパーティクルが表示されなくなります。",
				'noteSplashes',
				'bool',
				true);
			addOption(option);

			var option:Option = new Option('Hide HUD',
				'チェックすると、ほとんどのHUD要素を非表示にします。',
				'hideHud',
				'bool',
				false);
			addOption(option);
			
			var option:Option = new Option('Time Bar:',
				"タイムバーには何を表示しますか？",
				'timeBarType',
				'string',
				'Time Left',
				['Time Left', 'Time Elapsed', 'Song Name', 'Disabled']);
			addOption(option);

			var option:Option = new Option('Flashing Lights',
				"光の点滅が苦手な方はチェックを外してください。",
				'flashing',
				'bool',
				true);
			addOption(option);

			var option:Option = new Option('Camera Zooms',
				"チェックを外すと、ビートヒット時にカメラがズームインしなくなります。",
				'camZooms',
				'bool',
				true);
			addOption(option);

			var option:Option = new Option('Score Text Zoom on Hit',
				"チェックを外すと、音符を叩くたびにスコアの文字が拡大表示される機能を無効にします。",
				'scoreZoom',
				'bool',
				true);
			addOption(option);

			var option:Option = new Option('Health Bar Transparency',
				'体力バーとアイコンはどの程度透過させるべきでしょうか。',
				'healthBarAlpha',
				'percent',
				1);
			option.scrollSpeed = 1.6;
			option.minValue = 0.0;
			option.maxValue = 1;
			option.changeValue = 0.1;
			option.decimals = 1;
			addOption(option);
			
			#if !mobile
			var option:Option = new Option('Show FPS',
				'チェックを外すと、FPSカウンターを非表示にします。',
				'showFPS',
				'bool',
				true);
			addOption(option);

			var option:Option = new Option('Show Memory Usage',
				'チェックを外すと、メモリ使用量を非表示にします。',
				'showMemory',
				'bool',
				true);
			addOption(option);

			var option:Option = new Option('Show Memory Heap',
				'チェックを外すと、最大メモリ使用量を非表示にします。',
				'showMemoryHeap',
				'bool',
				true);
			addOption(option);

			var option:Option = new Option('Show Version',
				'チェックを外すと、バージョンを非表示にします。',
				'showVersion',
				'bool',
				true);
			addOption(option);
			#end
			
			var option:Option = new Option('Pause Screen Song:',
				"ポーズ画面の曲は何がいいですか？",
				'pauseMusic',
				'string',
				'Tea Time',
				['None', 'Breakfast', 'Tea Time']);
			addOption(option);
			option.onChange = onChangePauseMusic;
			
			#if CHECK_FOR_UPDATES
			var option:Option = new Option('Check for Updates',
				'リリースビルドの場合、これをオンにすると、ゲーム起動時にアップデートを確認するようになります。',
				'checkForUpdates',
				'bool',
				true);
			addOption(option);
			#end

			var option:Option = new Option('Combo Stacking',
				"チェックを外すと、レーティングとコンボはスタックされず、システムメモリを節約し、読みやすくなります。",
				'comboStacking',
				'bool',
				true);
			addOption(option);

			var option:Option = new Option('Language:',
				"現在、選択できる言語は英語と日本語の二種類だけです！",
				'language',
				'string',
				'English',
				['English','Japanese']);
			addOption(option);

			var option:Option = new Option('Free Play Auto song playback',
				"チェックをつけると、フリープレイ時に曲が自動再生されます。",
				'freeplayAutoPlaySong',
				'bool',
				false);
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

	var changedMusic:Bool = false;
	function onChangePauseMusic()
	{
		if(ClientPrefs.pauseMusic == 'None')
			FlxG.sound.music.volume = 0;
		else
			FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath(ClientPrefs.pauseMusic)));

		changedMusic = true;
	}

	override function destroy()
	{
		if(changedMusic) FlxG.sound.playMusic(Paths.music('freakyMenu'));
		super.destroy();
	}

	/*
	#if !mobile
	function onChangeFPSCounter()
	{
		if(Main.fpsVar != null)
			Main.fpsVar.visible = ClientPrefs.showFPS;
	}
	#end
	*/
}
