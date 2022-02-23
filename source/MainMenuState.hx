package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import io.newgrounds.NG;
import lime.app.Application;
import lime.utils.Assets;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.addons.display.FlxBackdrop;
import flixel.animation.FlxBaseAnimation;
import flixel.util.FlxTimer;

using StringTools;

class MainMenuState extends MusicBeatState
{
	
	var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;
	
	//var configText:FlxText;
	//var configSelected:Int = 0;
	
	var optionShit:Array<String> = ['story mode', 'freeplay', 'donate', "options", 'credits'];

	var magenta:FlxSprite;
	var camFollow:FlxObject;
	var virus:FlxSprite;

	var versionText:FlxText;
	var keyWarning:FlxText;

	override function create()
	{

		openfl.Lib.current.stage.frameRate = 144;

		if (!FlxG.sound.music.playing)
		{	
			FlxG.sound.playMusic("assets/music/klaskiiLoop.ogg", 0.75);
		}

		persistentUpdate = persistentDraw = true;

		var bg:FlxSprite = new FlxSprite(-80).loadGraphic('assets/images/menuBG.png');
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0;
		bg.setGraphicSize(Std.int(bg.width * 1.18));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

		var checker:FlxBackdrop = new FlxBackdrop(Paths.image('checkaboard'), 0.2, 0.2, true, true);
		checker.scrollFactor.set(0, 0.0);
		add(checker);
		checker.x = 200;
		checker.y = 200;
		checker.antialiasing = true;
		FlxTween.tween(checker, { x: 600, y: 1200 }, 40, { type: FlxTween.LOOPING });

		var bg:FlxSprite = new FlxSprite(-80).loadGraphic('assets/images/menuGradient.png');
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0;
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);
		
		var bg:FlxSprite = new FlxSprite(-80).loadGraphic('assets/images/scanline.png');
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0;
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

		var virus:FlxSprite = new FlxSprite(364, -35);
		virus.frames = Paths.getSparrowAtlas('virusBop');
		virus.animation.addByPrefix('cutebop', "virus anim", 24, true);
		virus.animation.play('cutebop');
		virus.scrollFactor.x = 0;
		virus.scrollFactor.y = 0;
		virus.antialiasing = true;
		add(virus);

		var bg:FlxSprite = new FlxSprite(-80).loadGraphic('assets/images/menuGeo.png');
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0;
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);
	
		magenta = new FlxSprite(-80).loadGraphic('assets/images/menuBGMagenta.png');
		magenta.scrollFactor.x = 0;
		magenta.scrollFactor.y = 0;
		magenta.setGraphicSize(Std.int(magenta.width * 1.18));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = true;
		add(magenta);

		var checker:FlxBackdrop = new FlxBackdrop(Paths.image('checkaboardMagenta'), 0.2, 0.2, true, true);
		checker.scrollFactor.set(0, 0);
		add(checker);
		checker.x = 200;
		checker.y = 200;
		checker.antialiasing = true;
		FlxTween.tween(checker, { x: 600, y: 1200 }, 40, { type: FlxTween.LOOPING });

		var bg:FlxSprite = new FlxSprite(-80).loadGraphic('assets/images/menuGradientMaegenter.png');
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0;
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);
		
		var bg:FlxSprite = new FlxSprite(-80).loadGraphic('assets/images/scanline.png');
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0;
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

		var virus:FlxSprite = new FlxSprite(364, -35);
		virus.frames = FlxAtlasFrames.fromSparrow('assets/images/virusBop.png', 'assets/images/virusBop.xml');
		virus.animation.addByPrefix('cutebop', "virus anim", 24, true);
		virus.animation.play('cutebop');
		virus.scrollFactor.x = 0;
		virus.scrollFactor.y = 0;
		virus.antialiasing = true;
		add(virus);

		var bg:FlxSprite = new FlxSprite(-80).loadGraphic('assets/images/menuGeo.png');
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0;
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

		var barz:FlxBackdrop = new FlxBackdrop(Paths.image('menubarz'), 0.2, true);
		barz.scrollFactor.set(0, 0);
		add(checker);
		barz.x = -5;
		barz.antialiasing = true;
		FlxTween.tween(checker, { x: 600}, 40, { type: FlxTween.LOOPING });

		// magenta.scrollFactor.set();

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var tex = FlxAtlasFrames.fromSparrow('assets/images/FNF_main_menu_assets.png', 'assets/images/FNF_main_menu_assets.xml');

		for (i in 0...optionShit.length)
		{
			var menuItem:FlxSprite = new FlxSprite(600, 160 + (i * 70));
			menuItem.frames = tex;
			
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItem.x = -1;
			menuItem.scale.set(0.6, 0.6);
			menuItems.add(menuItem);
			menuItem.scrollFactor.set();
			menuItem.antialiasing = true;
		}

		FlxG.camera.follow(camFollow, null, 0.004);
		FlxG.camera.flash(FlxColor.WHITE, 0.5);

		versionText = new FlxText(5, FlxG.height - 21, 0, Assets.getText('assets/data/version.txt'), 16);
		versionText.scrollFactor.set();
		versionText.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionText);

		keyWarning = new FlxText(5, FlxG.height - 21 + 16, 0, "If your controls aren't working, try pressing BACKSPACE to reset them.", 16);
		keyWarning.scrollFactor.set();
		keyWarning.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		keyWarning.alpha = 0;
		add(keyWarning);

		FlxTween.tween(versionText, {y: versionText.y - 16}, 0.75, {ease: FlxEase.quintOut, startDelay: 10});
		FlxTween.tween(keyWarning, {alpha: 1, y: keyWarning.y - 16}, 0.75, {ease: FlxEase.quintOut, startDelay: 10});

		// NG.core.calls.event.logEvent('swag').send();

		changeItem();
		
		//Offset Stuff
		Config.reload();

		super.create();
	}
	
	override function beatHit(){
		virus.animation.play('cutebop');
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
	
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if (!selectedSomethin)
		{
			if (controls.UP_P)
			{
				FlxG.sound.play('assets/sounds/scrollMenu' + TitleState.soundExt);
				changeItem(-1);
			}

			if (controls.DOWN_P)
			{
				FlxG.sound.play('assets/sounds/scrollMenu' + TitleState.soundExt);
				changeItem(1);
			}

			if (FlxG.keys.justPressed.BACKSPACE)
			{
				KeyBinds.resetBinds();
				FlxG.switchState(new MainMenuState());
			}

			if (controls.BACK)
			{
				FlxG.switchState(new TitleStateNormal());
			}

			if (controls.ACCEPT)
			{
			
				//Config.write(offsetValue, accuracyType, healthValue / 10.0, healthDrainValue / 10.0);
			
				if (optionShit[curSelected] == 'donate')
				{
					#if linux
					Sys.command('/usr/bin/xdg-open', ["https://www.kickstarter.com/projects/funkin/friday-night-funkin-the-full-ass-game", "&"]);
					#else
					FlxG.openURL('https://www.kickstarter.com/projects/funkin/friday-night-funkin-the-full-ass-game');
					#end
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play('assets/sounds/confirmMenu' + TitleState.soundExt);
					
					var daChoice:String = optionShit[curSelected];
					
					switch (daChoice){
						case 'freeplay':
							FlxG.sound.music.stop();
						case 'options':
							FlxG.sound.music.stop();
						case 'credits':
							FlxG.sound.music.stop();
					}

					FlxFlicker.flicker(magenta, 1.1, 0.15, false);
					FlxG.camera.flash(FlxColor.WHITE, 0.5);


					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {alpha: 0}, 0.4, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});
						}
						else
						{
							FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
							{
								//var daChoice:String = optionShit[curSelected];

								switch (daChoice)
								{
									case 'story mode':
										FlxG.switchState(new StoryMenuState());
										trace("Story Menu Selected");
									case 'freeplay':
										FreeplayState.startingSelection = 0;
										FlxG.switchState(new FreeplayState());
										trace("Freeplay Menu Selected");
									case 'options':
										FlxG.switchState(new ConfigMenu());
										trace("options time");
									case 'credits':
										new FlxTimer().start(0.2, function(tmr:FlxTimer)
											{
												FlxG.switchState(new CreditsShit());
												trace("thanks for checking out da credits");
											});
								}
							});
						}
					});
				}
			}
		}
	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;
		//configSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
 		if (curSelected < 0)
			curSelected = menuItems.length - 1;
			
		/*if (configSelected > 3)
			configSelected = 0;
		if (configSelected < 0)
			configSelected = 3;*/

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y);
			}

			spr.updateHitbox();
		});
	}
}
