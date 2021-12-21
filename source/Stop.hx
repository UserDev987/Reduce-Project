package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class Stop extends FlxState
{
	var image:FlxSprite;
	var text:FlxText;
	var path:String;
	var skipButton:FlxButton;

	override public function new(imagePath:String, textString:String)
	{
		super();

		path = imagePath;
		image = new FlxSprite();
		image.loadGraphic(path);
		image.screenCenter();

		skipButton = new FlxButton(0, 0, "SKIP", skip);

		text = new FlxText(90, 400, 0, textString, 14);
		text.alignment = CENTER;

		add(image);
		add(text);
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
