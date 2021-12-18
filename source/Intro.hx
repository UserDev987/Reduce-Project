package;

import flixel.FlxCamera;
import flixel.FlxGame;

class Intro extends FlxCamera
{
	public function new()
	{
		super();
		addChild(new FlxGame(640, 360, MenuState));
	}
}
