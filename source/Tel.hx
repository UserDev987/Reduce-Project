package;

import flixel.FlxSprite;

class Tel extends FlxSprite
{
	public function new(x:Float, y:Float)
	{
		super(x, y);
		loadGraphic(AssetPaths.image__png, false, 8, 8);
	}
}
