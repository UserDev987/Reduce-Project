package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;

class LEVEL_3 extends FlxState
{
	var player:Player;
	var map:FlxOgmo3Loader;
	var walls:FlxTilemap;
	var tel:FlxSprite;

	var coins:FlxTypedGroup<Coin>;

	override public function create()
	{
		map = new FlxOgmo3Loader(AssetPaths.HelloWorld__ogmo, 'assets/data/room-003.json');
		coins = new FlxTypedGroup<Coin>();

		walls = map.loadTilemap(AssetPaths.tiles__png, "walls");
		walls.follow();
		walls.setTileProperties(1, NONE);
		walls.setTileProperties(2, ANY);
		player = new Player();
		map.loadEntities(PlayState.placeEntities, "entities");
		add(walls);

		add(coins);
		add(player);
		add(PlayState.pointsT);
		FlxG.camera.follow(player, TOPDOWN, 1);
		super.create();
	}

	override public function update(elapsed:Float)
	{
		walls.overlapsWithCallback(player, function(a:FlxObject, b:FlxObject)
		{
			var jump = FlxG.keys.anyPressed([UP, W, SPACE]);
			if (jump)
			{
				player.velocity.y = -player.gravity / 1.5;
			}
			return true;
		});
		super.update(elapsed);
		FlxG.overlap(player, tel, PlayState.playerTeleport);
		FlxG.collide(player, walls);
		FlxG.overlap(player, coins, PlayState.playerTouchCoin);
	}
}
