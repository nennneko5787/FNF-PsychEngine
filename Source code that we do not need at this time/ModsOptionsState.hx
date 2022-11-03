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

import flixel.FlxObject;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import lime.app.Application;
import sys.io.File;
import sys.FileSystem;
import haxe.format.JsonParser;

using StringTools;

class ModsOptionsState extends BaseModsOptionsMenu
{
	public function new()
	{
		title = ModsMenuState.mods[curSelected].name + ' Options';
		rpcTitle = ModsMenuState.mods[curSelected].name + ' Options Menu'; //for Discord Rich Presence

        var cnt:Int = 0;
        var noModsTxt:FlxText;

        var path = Paths.mods(ModsMenuState.modOptionCur + '/options.json');
        if(FileSystem.exists(path)) {
			var rawJson:String = File.getContent(path);
			if(rawJson != null && rawJson.length > 0) {
				var stuff:Dynamic = Json.parse(rawJson);
                var optionName:Array<String> = Reflect.getProperty(stuff, "optionName");
                var optionDesc:Array<String> = Reflect.getProperty(stuff, "optionDesc");
                var optionVar:Array<String> = Reflect.getProperty(stuff, "optionVar");
                var optionType:Array<String> = Reflect.getProperty(stuff, "optionType");
                var optionValue:Array<Array> = Reflect.getProperty(stuff, "optionValue");
                
                for (v in optionName) {
                    var option:Option = new Option(optionName[cnt],
                        optionDesc[cnt],
                        optionVar[cnt],
                        optionType[cnt],
                        false);
                    addOption(option);

                    cnt++;
                }
            }else{
                noModsTxt = new FlxText(0, 0, FlxG.width, "THIS MOD HAS NO OPTIONS\nPRESS BACK TO EXIT AND INSTALL MODS WITH OPTIONS OR OPEN MODS WITH OPTIONS", 48);
                if(FlxG.random.bool(0.1)) noModsTxt.text += '\nBITCH.'; //meanie
                noModsTxt.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
                noModsTxt.scrollFactor.set();
                noModsTxt.borderSize = 2;
                add(noModsTxt);
                noModsTxt.screenCenter();
            }
        }

		super();
	}
}
