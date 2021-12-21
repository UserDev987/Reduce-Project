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

	override public function new(stop:String, textString:String)
	{
		stopCamera = new FlxCamera(0, 0, FlxG.width, FlxG.height);
		stopCamera.bgColor = FlxColor.GREEN;
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

		txt = new FlxText(0, 310, 0, text, 10);
		txt.screenCenter(X);
		txt.font = 'assets/data/FONT.ttf';

		txt.alignment = CENTER;

		add(image);
		add(txt);
		add(skipButton);
	}

	function skip()
	{
		FlxG.switchState(new LEVEL_2());
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
