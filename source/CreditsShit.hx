package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import io.newgrounds.NG;
import lime.app.Application;
import flixel.addons.display.FlxBackdrop;

using StringTools;

class CreditsShit extends MusicBeatState
{
    public static var startSong = true;
    
    override function create()
        {
            FlxG.camera.fade(FlxColor.BLACK, 0.3, true);
            var bg:FlxSprite = new FlxSprite(-80).loadGraphic('assets/images/creditsSmile.png');
            bg.scrollFactor.x = 0;
            bg.scrollFactor.y = 0;
            bg.updateHitbox();
            bg.screenCenter();
            bg.antialiasing = true;
            add(bg);

            if(startSong)
                FlxG.sound.playMusic('assets/music/configurator' + TitleState.soundExt);
            else
                startSong = true;

                persistentUpdate = persistentDraw = true;
            FlxG.camera.fade(FlxColor.BLACK, 0.3, true);
        }
    override function update(elapsed:Float)
        {
            if (controls.BACK){
                FlxG.switchState(new MainMenuState());
                FlxG.sound.music.stop();
                FlxG.sound.play('assets/sounds/cancelMenu' + TitleState.soundExt);
                FlxG.sound.playMusic('assets/music/freakyMenu' + TitleState.soundExt, 0.8);
            }
        }
}