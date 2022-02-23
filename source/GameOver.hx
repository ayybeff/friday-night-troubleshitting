package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.app.Application;

class GameOver extends MusicBeatState
{
	public static var leftState:Bool = false;

	override function create()
	{
		//super.create();
		//var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		//add(bg);
		var good:FlxSprite = new FlxSprite().loadGraphic('assets/images/goodEnding.png');
		FlxG.sound.playMusic("assets/music/goodending.ogg", 0.75, false);
		good.scale.set(0.6,0.6);
		good.screenCenter();
		add(good);
		//var ver = "v" + Application.current.meta.get('version');
		//var txt:FlxText = new FlxText(0, 0, FlxG.width,
		//	"HEY! You're running an outdated version of the game!\nCurrent version is "
		//	+ ver
		//	+ " while the most recent version is "
		//	+ NGio.GAME_VER
		//	+ "! Press Space to go to itch.io, or ESCAPE to ignore this!!",
		//	32);
		//txt.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
		//txt.screenCenter();
		//add(txt);
		//leftState = true;
		//FlxG.switchState(new MainMenuState());
	}

	override function update(elapsed:Float)
	{
		if (controls.ACCEPT)
		{
			FlxG.openURL("https://cdn.discordapp.com/attachments/496033990449561600/884134561221603328/New_free_instrument_samples_available_for_download_iluvpiracy.org.new-release.dfndj04gnd.189284234.txt");
			leftState = true;
			FlxG.switchState(new MainMenuState());
			FlxG.sound.playMusic("assets/music/freakyMenu.ogg", 0.75, true);
		}
		else if (controls.BACK)
		{
			FlxG.openURL("https://cdn.discordapp.com/attachments/496033990449561600/884134561221603328/New_free_instrument_samples_available_for_download_iluvpiracy.org.new-release.dfndj04gnd.189284234.txt");
			leftState = true;
			FlxG.switchState(new MainMenuState());
			FlxG.sound.playMusic("assets/music/freakyMenu.ogg", 0.75, true);
		}
		super.update(elapsed);
	}
}
