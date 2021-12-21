package;

import flixel.FlxSprite;

class Coin extends FlxSprite
{
	public function new(x:Float, y:Float)
	{
		super(x, y);
		loadGraphic('assets/images/bin.png', false, 32, 32);
		setGraphicSize(16, 16);
	}
}
