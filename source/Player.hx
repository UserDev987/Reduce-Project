package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

class Player extends FlxSprite
{
	static inline var SPEED:Float = 100;

	public var gravity:Int = 200;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		drag.x = drag.y = 1600;
		velocity.y = 100;
		acceleration.y = gravity;
		setSize(8, 8);
		offset.set(4, 4);
		loadGraphic(AssetPaths.player__png, true, 16, 16);
		setFacingFlip(LEFT, false, false);
		setFacingFlip(RIGHT, true, false);
		animation.add("lr", [3, 4, 3, 5], 6, false);
		animation.add("u", [6, 7, 6, 8], 6, false);
		animation.add("d", [0, 1, 0, 2], 6, false);
	}

	function movement()
	{
		var right = FlxG.keys.anyPressed([RIGHT, D]);
		var left = FlxG.keys.anyPressed([LEFT, A]);

		if (right && left)
		{
			right = left = false;
		}
		else if (right)
		{
			velocity.x = SPEED;
			animation.play("lr");
			flipX = true;
		}
		else if (left)
		{
			velocity.x = -SPEED;
			animation.play("lr");
			flipX = false;
		}
		else
		{
			this.animation.stop();
		}
	}

	override function update(elapsed:Float)
	{
		movement();

		super.update(elapsed);
	}
}
