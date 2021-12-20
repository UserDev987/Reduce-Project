package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class Stop_1 extends FlxState
{
	var skipButton:FlxButton;

	override public function create()
	{
		skipButton = new FlxButton(0, 0, "SKIP", clickPlay);
		add(skipButton);
		skipButton.screenCenter();
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	function clickPlay()
	{
		FlxG.switchState(new LEVEL_2());
	}
}
