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

#if sys
import sys.FileSystem;
import sys.io.File;
#end

using StringTools;

class ReplaysMenuSubState extends MusicBeatSubstate
{
	var options:Array<String> = [];
	var replays:Array<String> = [];
	var songPath:String = "";

	private var grpTexts:FlxTypedGroup<Alphabet>;
	private var directories:Array<String> = [null];

	private var curSelected = 0;
	private var curDirectory = 0;
	private var directoryTxt:FlxText;

	override function create()
	{
		replays = sys.FileSystem.readDirectory("assets/replays/");
		options.push("Please Select");
		for (i in 0...replays.length)
		{
			options.push(replays[i]);
		}
		FlxG.camera.bgColor = FlxColor.BLACK;

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.scrollFactor.set();
		bg.color = 0xFFea71fd;
		add(bg);

		grpTexts = new FlxTypedGroup<Alphabet>();
		add(grpTexts);

		var titleText:Alphabet = new Alphabet(75, 40, 'Replays Menu', true);
		titleText.scaleX = 0.6;
		titleText.scaleY = 0.6;
		titleText.alpha = 0.4;
		add(titleText);

		#if desktop
		DiscordClient.changePresence("Replays Menu", null);
		#end

		for (i in 0...options.length)
		{
			var leText:Alphabet = new Alphabet(90, 320, options[i], true);
			leText.isMenuItem = true;
			leText.targetY = i;
			grpTexts.add(leText);
			leText.snapToPosition();
		}
		
		changeSelection();

		FlxG.mouse.visible = false;
		Sys.sleep(0.5);
		super.create();
	}

	override function update(elapsed:Float)
	{
		if (controls.UI_UP_P)
		{
			changeSelection(-1);
		}
		if (controls.UI_DOWN_P)
		{
			changeSelection(1);
		}

		if (controls.BACK)
		{
			close();
		}

		if (controls.ACCEPT)
		{
			if (options.length != 0 && options[curSelected] != "Please Select"){
				trace('Selected '+options[curSelected]);
				WeekData.reloadWeekFiles(false);
				PlayState.rep = Replay.LoadReplay("assets/replays/"+options[curSelected]);
				var poop:String = Highscore.formatSong(PlayState.rep.replay.songName, PlayState.rep.replay.songDiff);
				PlayState.SONG = Song.loadFromJson(poop,PlayState.rep.replay.songName);
				PlayState.isStoryMode = false;
				PlayState.loadRep = true;
				PlayState.storyDifficulty = PlayState.rep.replay.songDiff;
				LoadingState.loadAndSwitchState(new PlayState());
			}
		}
		
		var bullShit:Int = 0;
		for (item in grpTexts.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
		super.update(elapsed);
	}

	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = options.length - 1;
		if (curSelected >= options.length)
			curSelected = 0;
	}
}
