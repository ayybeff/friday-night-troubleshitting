package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.net.curl.CURLCode;
import flixel.addons.display.FlxBackdrop;

using StringTools;

class StoryMenuState extends MusicBeatState
{
	var scoreText:FlxText;

	public static var weekData:Array<Dynamic>;
	var curDifficulty:Int = 1;

	public static var weekUnlocked:Array<Bool> = [true, true];

	public static var weekNames:Array<String>;

	var txtWeekTitle:FlxText;

	var weekThing:MenuItem;

	var curWeek:Int = 0;

	var txtTracklist:FlxText;
	var isCutscene:Bool = false;

	var virusweek:FlxSprite;

	var grpWeekText:FlxTypedGroup<MenuItem>;

	var grpLocks:FlxTypedGroup<FlxSprite>;

	var ui_tex:FlxAtlasFrames;
	var video:MP4Handler;

	var difficultySelectors:FlxGroup;
	var sprDifficulty:FlxSprite;
	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;

	override function create()
	{

		openfl.Lib.current.stage.frameRate = 144;
	
		weekData = [
			['Torrent', 'Sensory-Overload', 'Jailbreak']
		];
		weekNames = CoolUtil.coolTextFile("assets/data/weekNames.txt");
	
		FlxG.sound.playMusic("assets/music/freakyStory.ogg", 0.75);


		persistentUpdate = persistentDraw = true;
		
		var bg:FlxSprite = new FlxSprite(-80).loadGraphic('assets/images/storyMenuGradient1.png');
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0;
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
		checker.alpha = 0.3;
		
		var virusweek:FlxSprite = new FlxSprite(-80).loadGraphic('assets/images/viruslPrev.png');
		virusweek.scrollFactor.x = 0;
		virusweek.scrollFactor.y = 0;
		virusweek.updateHitbox();
		virusweek.antialiasing = true;
		add(virusweek);
		virusweek.x = 10;

		var geometry:FlxSprite = new FlxSprite(-80).loadGraphic('assets/images/storyMenuGeo.png');
		geometry.scrollFactor.x = 0;
		geometry.scrollFactor.y = 0;
		geometry.updateHitbox();
		geometry.screenCenter();
		geometry.antialiasing = true;
		add(geometry);

		scoreText = new FlxText(10, 10, 0, "SCORE: 49324858", 36);
		scoreText.setFormat("VCR OSD Mono", 32);

		txtWeekTitle = new FlxText(FlxG.width * 0.7, 10, 0, "", 32);
		txtWeekTitle.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, RIGHT);
		txtWeekTitle.alpha = 0.3;

		var rankText:FlxText = new FlxText(0, 10);
		rankText.text = 'RANK: GREAT';
		rankText.setFormat("assets/fonts/vcr.ttf", 32);
		rankText.size = scoreText.size;
		rankText.screenCenter(X);

		var bg:FlxSprite = new FlxSprite(-80).loadGraphic('assets/images/storyMenuGradient2.png');
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0;
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

		ui_tex = FlxAtlasFrames.fromSparrow('assets/images/campaign_menu_UI_assets.png', 'assets/images/campaign_menu_UI_assets.xml');

		grpWeekText = new FlxTypedGroup<MenuItem>();
		add(grpWeekText);

		grpLocks = new FlxTypedGroup<FlxSprite>();
		add(grpLocks);

		trace("Line 70");

		for (i in 0...weekData.length)
		{
			var weekThing:MenuItem = new MenuItem(0, 0);
			weekThing.x = 80.35;
			weekThing.y = 621.8;
			grpWeekText.add(weekThing);

			weekThing.antialiasing = true;
			// weekThing.updateHitbox();

			// Needs an offset thingie
			if (!weekUnlocked[i])
			{
				var lock:FlxSprite = new FlxSprite(weekThing.width + 10 + weekThing.x);
				lock.frames = ui_tex;
				lock.animation.addByPrefix('lock', 'lock');
				lock.animation.play('lock');
				lock.ID = i;
				lock.antialiasing = true;
				grpLocks.add(lock);
			}
		}

		trace("Line 96");

		difficultySelectors = new FlxGroup();
		add(difficultySelectors);

		trace("Line 124");

		leftArrow = new FlxSprite(grpWeekText.members[0].x + grpWeekText.members[0].width + 10, grpWeekText.members[0].y + 10);
		leftArrow.frames = ui_tex;
		leftArrow.animation.addByPrefix('idle', "arrow left");
		leftArrow.animation.addByPrefix('press', "arrow push left");
		leftArrow.animation.play('idle');
		difficultySelectors.add(leftArrow);

		sprDifficulty = new FlxSprite(leftArrow.x + 130, leftArrow.y);
		sprDifficulty.frames = ui_tex;
		sprDifficulty.animation.addByPrefix('easy', 'EASY');
		sprDifficulty.animation.addByPrefix('normal', 'NORMAL');
		sprDifficulty.animation.addByPrefix('hard', 'HARD');
		sprDifficulty.animation.play('easy');
		changeDifficulty();

		difficultySelectors.add(sprDifficulty);

		rightArrow = new FlxSprite(sprDifficulty.x + sprDifficulty.width + 50, leftArrow.y);
		rightArrow.frames = ui_tex;
		rightArrow.animation.addByPrefix('idle', 'arrow right');
		rightArrow.animation.addByPrefix('press', "arrow push right", 24, false);
		rightArrow.animation.play('idle');
		difficultySelectors.add(rightArrow);

		trace("Line 150");

		txtTracklist = new FlxText(FlxG.width * 0.05, 100, 0, "Tracks", 32);
		txtTracklist.alignment = CENTER;
		txtTracklist.font = rankText.font;
		txtTracklist.color = 0xFF2e408e;
		add(txtTracklist);
		txtTracklist.x = 1036;
		txtTracklist.y = 562;
		// add(rankText);
		add(scoreText);
		add(txtWeekTitle);

		updateText();

		trace("Line 165");

		super.create();
	}

	override function update(elapsed:Float)
	{
		// scoreText.setFormat('VCR OSD Mono', 32);
		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, 0.5));

		scoreText.text = "WEEK SCORE:" + lerpScore;

		txtWeekTitle.text = weekNames[curWeek].toUpperCase();
		txtWeekTitle.x = FlxG.width - (txtWeekTitle.width + 10);

		// FlxG.watch.addQuick('font', scoreText.font);

		difficultySelectors.visible = weekUnlocked[curWeek];

		grpLocks.forEach(function(lock:FlxSprite)
		{
			lock.y = grpWeekText.members[lock.ID].y;
		});

		if (!movedBack)
		{
			if (!selectedWeek)
			{
				if (controls.UP_P)
				{
					changeWeek(-1);
				}

				if (controls.DOWN_P)
				{
					changeWeek(1);
				}

				if (controls.RIGHT)
					rightArrow.animation.play('press')
				else
					rightArrow.animation.play('idle');

				if (controls.LEFT)
					leftArrow.animation.play('press');
				else
					leftArrow.animation.play('idle');

				if (controls.RIGHT_P)
					changeDifficulty(1);
				if (controls.LEFT_P)
					changeDifficulty(-1);
			}

			if (controls.ACCEPT)
			{
				selectWeek();
			}
		}

		if (controls.BACK && !movedBack && !selectedWeek)
		{
			FlxG.sound.play('assets/sounds/cancelMenu' + TitleState.soundExt);
			FlxG.sound.playMusic("assets/music/freakyMenu.ogg", 0.75);
			movedBack = true;
			FlxG.switchState(new MainMenuState());
		}

		super.update(elapsed);
	}

	var movedBack:Bool = false;
	var selectedWeek:Bool = false;
	var stopspamming:Bool = false;

	function selectWeek()
	{
		if (weekUnlocked[curWeek])
		{
			if (stopspamming == false)
			{
				FlxG.sound.play('assets/sounds/confirmMenu' + TitleState.soundExt);
				FlxG.camera.flash(FlxColor.WHITE, 0.5);
				grpWeekText.members[curWeek].week.animation.resume();
				stopspamming = true;
			}

			PlayState.storyPlaylist = weekData[curWeek];
			PlayState.isStoryMode = true;
			selectedWeek = true;

			var diffic = "";

			switch (curDifficulty)
			{
				case 0:
					diffic = '-easy';
				case 2:
					diffic = '-hard';
			}
				new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						var video:MP4Handler = new MP4Handler();
						video.playMP4(Paths.video('newestIntroAnimation'), new PlayState()); 
					});
				PlayState.storyDifficulty = curDifficulty;

				PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + diffic, PlayState.storyPlaylist[0].toLowerCase());
				PlayState.storyWeek = curWeek;
				PlayState.returnLocation = "main";
				PlayState.campaignScore = 0;
		}

	}

	function changeDifficulty(change:Int = 0):Void
	{
		curDifficulty += change;

		if (curDifficulty < 0)
			curDifficulty = 2;
		if (curDifficulty > 2)
			curDifficulty = 0;

		sprDifficulty.offset.x = 0;

		switch (curDifficulty)
		{
			case 0:
				sprDifficulty.animation.play('easy');
				sprDifficulty.offset.x = 20;
			case 1:
				sprDifficulty.animation.play('normal');
				sprDifficulty.offset.x = 70;
			case 2:
				sprDifficulty.animation.play('hard');
				sprDifficulty.offset.x = 20;
		}

		sprDifficulty.alpha = 0;

		// USING THESE WEIRD VALUES SO THAT IT DOESNT FLOAT UP
		sprDifficulty.y = leftArrow.y - 15;
		intendedScore = Highscore.getWeekScore(curWeek, curDifficulty);

		#if !switch
		intendedScore = Highscore.getWeekScore(curWeek, curDifficulty);
		#end

		FlxTween.tween(sprDifficulty, {y: leftArrow.y + 15, alpha: 1}, 0.07);
	}

	var lerpScore:Int = 0;
	var intendedScore:Int = 0;

	function changeWeek(change:Int = 0):Void
	{
		curWeek += change;

		if (curWeek >= weekData.length)
			curWeek = 0;
		if (curWeek < 0)
			curWeek = weekData.length - 1;

		sprDifficulty.frames = ui_tex;
		sprDifficulty.animation.addByPrefix('easy', 'EASY');
		sprDifficulty.animation.addByPrefix('normal', 'NORMAL');
		sprDifficulty.animation.addByPrefix('hard', 'HARD');
		changeDifficulty();

		var bullShit:Int = 0;

		for (item in grpWeekText.members)
		{
			item.targetY = bullShit - curWeek;
			if (weekUnlocked[curWeek])
			{
				item.alpha = 1;
				item.y = 347;
			}
			else
				item.alpha = 0.6;
			bullShit++;
		}

		FlxG.sound.play('assets/sounds/scrollMenu' + TitleState.soundExt);

		updateText();
	}

	function updateText()
	{
		txtTracklist.text = "Tracks\n";

		var stringThing:Array<String> = weekData[curWeek];

		for (i in stringThing)
		{
			txtTracklist.text += "\n" + i;
		}

		txtTracklist.text += "\n";

		txtTracklist.text = txtTracklist.text.toUpperCase();


		// offset text
		// there's prolly better way to do this but my brain is mush
		switch (curWeek){
			case 0:
				txtTracklist.x = 956;
			case 1:
				txtTracklist.x = 956;
		}
		//txtTracklist.x = FlxG.width * 0.35;

		#if !switch
		intendedScore = Highscore.getWeekScore(curWeek, curDifficulty);
		#end
	}
}
