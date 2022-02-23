package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.app.Application;
import flixel.effects.FlxFlicker;
import flixel.util.FlxTimer;

class EpilepsyWarning extends MusicBeatState
{
	public static var leftState:Bool = false;

	var warnText:FlxText;
	override function create()
	{
		super.create();

		warnText = new FlxText(0, 0, FlxG.width,
			"Hey.\n
			This Mod contains some flashing lights.\n
			Unfortunately, you can't turn them off.\n
			If you are sensitive to this, or have photosensitive epilepsy,\n
			we recommend being careful while watching or playing this mod.\n
            (Press ENTER to continue)",
			32);
		warnText.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
		warnText.screenCenter(Y);
		add(warnText);
	}

	override function update(elapsed:Float)
	{
			if (controls.ACCEPT){
                FlxG.sound.play("assets/sounds/scrollMenu.ogg");
                FlxG.switchState(new TitleVidState());
			}
		
		super.update(elapsed);
	}
}