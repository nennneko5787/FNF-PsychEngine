import sys.io.File;
import Controls.Control;
import flixel.FlxG;
import openfl.events.IOErrorEvent;
import openfl.events.Event;
import openfl.net.FileReference;
import haxe.Json;
import flixel.input.keyboard.FlxKey;
import openfl.utils.Dictionary;

typedef ReplayJSON =
{
	public var songName:String;
	public var songDiff:Int;
	public var songDiffName:String;
	public var timestamp:Date;
	public var replayGameVer:String;
	public var sf:Float;
	public var noteSpeed:Float;
	public var isDownscroll:Bool;
	public var ismiddlescroll:Bool;
	public var ispracticeMode:Bool;
	public var israndomcharts:Bool;
	public var isvsmode:Bool;
	public var isopponentPlay:Bool;
	public var healthGain:Float;
	public var healthLoss:Float;
	public var instakillOnmiss:Int;
	public var songNotes:Map<String, Int>;
	public var songJudgements:Float;
}

class Replay
{
	public static var version:String = MainMenuState.nekoEngineVersion;
	public var path:String = "";
	public var replay:ReplayJSON;

	public function new(path:String)
	{
		this.path = path;
		replay = {
			songName: "tutorial",
			songDiff: 1,
			songDiffName: "Normal",
			timestamp: Date.now(),
			replayGameVer: MainMenuState.nekoEngineVersion,
			sf: ClientPrefs.safeFrames,
			noteSpeed: 1,
			isDownscroll: ClientPrefs.downScroll,
			ismiddlescroll: ClientPrefs.middleScroll,
			ispracticeMode: false,
			israndomcharts: false,
			isvsmode: false,
			isopponentPlay: false,
			healthGain: 1,
			healthLoss: 1,
			instakillOnmiss: 0,
			songNotes: ["2145" => 0, "7832" => 0],
			songJudgements: 1,
		};
	}

	public static function LoadReplay(path:String):Replay
	{
		var rep:Replay = new Replay(path);

		rep.LoadFromJSON();

		trace('basic replay data:\nSong Name: ' + rep.replay.songName + '\nSong Diff: ' + rep.replay.songDiff + "\nSong Diff Name:" + rep.replay.songDiffName);

		return rep;
	}

	public function LoadFromJSON()
	{
		trace('loading ' + path + ' replay...');
		try
		{
			var repl:ReplayJSON = cast Json.parse(File.getContent(path));
			replay = repl;
		}
		catch (e)
		{
			trace('failed!\n' + e.message);
		}
	}
}
