package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	public var dialogueNum:Int = 1;

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;
	var dialogueFinished:Bool = false;

	var dropText:FlxText;
	var skipDir:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;
	var blackBarShit:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
		// 	case 'senpai':
		// 		//FlxG.sound.playMusic('assets/music/Lunchbox' + TitleState.soundExt, 0);
		// 		FlxG.sound.music.fadeIn(1, 0, 0.8);
		// 	case 'thorns':
		// 		FlxG.sound.playMusic('assets/music/LunchboxScary' + TitleState.soundExt, 0);
		// 		FlxG.sound.music.fadeIn(1, 0, 0.8);
		 	case 'torrent':
		 		FlxG.sound.playMusic('assets/music/ambience' + TitleState.soundExt, 0);
		 		FlxG.sound.music.fadeIn(1, 0, 0.8);
		 	case 'sensory-overload':
		 		FlxG.sound.playMusic('assets/music/ambience' + TitleState.soundExt, 0);
		 		FlxG.sound.music.fadeIn(1, 0, 0.8);
		 	case 'jailbreak':
		 		FlxG.sound.playMusic('assets/music/ambience' + TitleState.soundExt, 0);
		 		FlxG.sound.music.fadeIn(1, 0, 0.8);
		 
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		var blackBarShit:FlxSprite = new FlxSprite().makeGraphic(Std.int(FlxG.width * 1345.55), Std.int(FlxG.height * 30.85), FlxColor.BLACK);
		blackBarShit.x = -11.75;
		blackBarShit.y = 682.8;
		// dont question why i position shit like this
		add(blackBarShit);
		blackBarShit.alpha = 0.5;

		skipDir = new FlxText(5, FlxG.height - 21 + 16, 0, "<<Press SPACE to skip dialogue>>", 25);
		skipDir.setFormat("VCR OSD Mono", 25, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		skipDir.x = 377.95;
		skipDir.y = 679.65;
		skipDir.screenCenter(X);
		add(skipDir);

		portraitLeft = new FlxSprite(95, 40);
		portraitLeft.frames = FlxAtlasFrames.fromSparrow('assets/images/torrentPortrait.png', 'assets/images/torrentPortrait.xml');
		portraitLeft.animation.addByPrefix('enter', 'Symbol 1', 24, false);
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;

		portraitRight = new FlxSprite(0, 40);
		portraitRight.frames = FlxAtlasFrames.fromSparrow('assets/images/boyfriendPortrait.png', 'assets/images/boyfriendPortrait.xml');
		portraitRight.animation.addByPrefix('enter', 'Boyfriend Portrait Enter instance 1', 24, false);
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;

		box = new FlxSprite(-20, 45);

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				box.frames = FlxAtlasFrames.fromSparrow('assets/images/weeb/pixelUI/dialogueBox-pixel.png',
					'assets/images/weeb/pixelUI/dialogueBox-pixel.xml');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'roses':
				FlxG.sound.play('assets/sounds/ANGRY_TEXT_BOX' + TitleState.soundExt);

				box.frames = FlxAtlasFrames.fromSparrow('assets/images/weeb/pixelUI/dialogueBox-senpaiMad.png',
					'assets/images/weeb/pixelUI/dialogueBox-senpaiMad.xml');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				box.frames = FlxAtlasFrames.fromSparrow('assets/images/weeb/pixelUI/dialogueBox-evil.png', 'assets/images/weeb/pixelUI/dialogueBox-evil.xml');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic('assets/images/weeb/spiritFaceForward.png');
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);
			case 'torrent':
				box.frames = FlxAtlasFrames.fromSparrow('assets/images/weeb/pixelUI/dialogueBox-evil.png', 'assets/images/weeb/pixelUI/dialogueBox-evil.xml');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);
			case 'sensory-overload':
				box.frames = FlxAtlasFrames.fromSparrow('assets/images/weeb/pixelUI/dialogueBox-evil.png', 'assets/images/weeb/pixelUI/dialogueBox-evil.xml');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);
			case 'jailbreak':
				box.frames = FlxAtlasFrames.fromSparrow('assets/images/weeb/pixelUI/dialogueBox-evil.png', 'assets/images/weeb/pixelUI/dialogueBox-evil.xml');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);
			case 'bitcrush':
				box.frames = FlxAtlasFrames.fromSparrow('assets/images/weeb/pixelUI/dialogueBox-evil.png', 'assets/images/weeb/pixelUI/dialogueBox-evil.xml');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);
		}

		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		box.updateHitbox();
		add(box);

		handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic('assets/images/weeb/pixelUI/hand_textbox.png');
		add(handSelect);

		box.screenCenter(X);

		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'Pixel Arial 11 Bold';
		dropText.color = 0xFF353d36;
		add(dropText);

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'Pixel Arial 11 Bold';
		swagDialogue.color = 0xFFecffef;
		//swagDialogue.sounds = [FlxG.sound.load('assets/sounds/pixelText' + TitleState.soundExt, 0.6)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);

		this.dialogueList = dialogueList;
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;
	

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		

		if (FlxG.keys.justPressed.ENTER)
		{

			if(dialogueFinished){

				remove(dialogue);

				FlxG.sound.play('assets/sounds/clickText' + TitleState.soundExt, 0.8);

				if (dialogueList[1] == null)
				{
					if (!isEnding)
					{
						isEnding = true;

						if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns')
							FlxG.sound.music.fadeOut(2.2, 0);

						new FlxTimer().start(0.2, function(tmr:FlxTimer)
						{
							box.alpha -= 1 / 5;
							bgFade.alpha -= 1 / 5 * 0.7;
							portraitLeft.visible = false;
							portraitRight.visible = false;
							swagDialogue.alpha -= 1 / 5;
							dropText.alpha = swagDialogue.alpha;
						}, 5);

						new FlxTimer().start(1.2, function(tmr:FlxTimer)
						{
							finishThing();
							kill();
						});
					}
				}
				else
				{

					//FlxG.sound.pause();
					if (PlayState.SONG.song.toLowerCase() == 'torrent'){
						try {
							FlxG.sound.play('assets/sounds/song1_' + dialogueNum + '.ogg', 1.2);
							trace("tried to play: " + dialogueNum + '.ogg');
						}
						catch(e:Any){
							trace("ye voice line no exist innit");
						}
					}
					else if (PlayState.SONG.song.toLowerCase() == 'sensory-overload'){
						try {
							FlxG.sound.play('assets/sounds/song2_' + dialogueNum + '.ogg', 1.2);
							trace("tried to play: " + dialogueNum + '.ogg');
						}
						catch(e:Any){
							trace("ye voice line no exist innit");
						}
					}
					else if (PlayState.SONG.song.toLowerCase() == 'jailbreak'){

						try {
							FlxG.sound.play('assets/sounds/song3_' + dialogueNum + '.ogg', 1.2);
							trace("tried to play: " + dialogueNum + '.ogg');
						}
						catch(e:Any){
							trace("ye voice line no exist innit");
						}
					}

					dialogueNum++;

					trace("dialogueNum: "+dialogueNum);

					//FlxG.sound.play('assets/sounds/pixelText' + TitleState.soundExt, 0.6);
					dialogueList.remove(dialogueList[0]);
					startDialogue();
				}
			}
			else{

				swagDialogue.skip();
				dialogueFinished = true;

			}
		}
		
		if (FlxG.keys.justPressed.SPACE)
			{
				skipAllDialog();
			}
	

		super.update(elapsed);
	}

	var isEnding:Bool = false;
	var playedAlready:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();

		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);
		swagDialogue.completeCallback = function(){dialogueFinished = true;};

		if (PlayState.SONG.song.toLowerCase() == 'torrent' && playedAlready == false){
			FlxG.sound.play('assets/sounds/song1_0.ogg', 1.2);
			playedAlready = true;

		}
		else if (PlayState.SONG.song.toLowerCase() == 'sensory-overload' && playedAlready == false){
			FlxG.sound.play('assets/sounds/song2_0.ogg', 1.2);
			playedAlready = true;

		}
		else if (PlayState.SONG.song.toLowerCase() == 'jailbreak' && playedAlready == false){
			FlxG.sound.play('assets/sounds/song3_0.ogg', 1.2);
			playedAlready = true;

		}

		switch (curCharacter)
		{
			case 'dad':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'bf':
				portraitLeft.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
		dialogueFinished = false;
	}

	// meh

	function skipAllDialog():Void
		{
			remove(dialogue);

			FlxG.sound.play('assets/sounds/clickText' + TitleState.soundExt, 0.8);
			
			isEnding = true;
			dialogueFinished = true;
			// can't be too careful lol
			FlxG.sound.music.fadeOut(2.2, 0);
			
			new FlxTimer().start(0.2, function(tmr:FlxTimer)
				{
					box.alpha -= 1 / 5;
					bgFade.alpha -= 1 / 5 * 0.7;
					portraitLeft.visible = false;
					portraitRight.visible = false;
					swagDialogue.alpha -= 1 / 5;
					dropText.alpha = swagDialogue.alpha;
				}, 5);
			
			new FlxTimer().start(1.2, function(tmr:FlxTimer)
				{
					finishThing();
						kill();
				});
		}
}
