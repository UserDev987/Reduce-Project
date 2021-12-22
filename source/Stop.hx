package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class Stop extends FlxState
{
	var stopCamera:FlxCamera;
	var image:FlxSprite;
	var text:String;
	var txt:FlxText;
	var stopNum:String;
	var path:String;
	var skipButton:FlxButton;
	var curLvl:Int;

	override public function new(stop:String, textString:String, nowLvl:Int)
	{
		curLvl = nowLvl;
		/*
			stopCamera = new FlxCamera(0, 0, FlxG.width, FlxG.height);
			stopCamera.bgColor = FlxColor.GREEN;
			FlxG.cameras.add(stopCamera);
		 */

		// fix the camera

		// this.camera = stopCamera;
		super();

		stopNum = stop;
		text = textString;

		switch (stopNum)
		{
			case '1':
				path = 'assets/images/stop img/1.png';
			case '2':
				path = 'assets/images/stop img/2.png';
			case '3':
				path = 'assets/images/stop img/3.png';
			case '4':
				path = 'assets/images/stop img/4.png';
		}
		image = new FlxSprite();
		image.loadGraphic(path);
		image.screenCenter();
		image.antialiasing = false;
		image.setGraphicSize(256);

		skipButton = new FlxButton(0, 0, "SKIP", skip);

		txt = new FlxText(208, 304, 0, text, 14);

		txt.antialiasing = false;
		txt.font = 'assets/data/ComicMono.ttf';

		txt.alignment = CENTER;

		add(image);
		add(txt);
		add(skipButton);
	}

	function skip()
	{
		switch (curLvl)
		{
			case 1:
				FlxG.switchState(new LEVEL_2());
			case 2:
				FlxG.switchState(new LEVEL_3());
			case 3:
				trace("level 4 is unexistent; remaining on a black screen");
			case _:
				throw("invalid level");
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
