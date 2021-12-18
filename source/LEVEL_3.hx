package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;

class LEVEL_3 extends FlxState
{
	var player:Player;
	var map:FlxOgmo3Loader;
	var walls:FlxTilemap;
	var tel:FlxSprite;

	var coins:FlxTypedGroup<Coin>;

	override public function create()
	{
		map = new FlxOgmo3Loader(AssetPaths.HelloWorld__ogmo, AssetPaths.room_003__json);
		coins = new FlxTypedGroup<Coin>();

		walls = map.loadTilemap(AssetPaths.tiles__png, "walls");
		walls.follow();
		walls.setTileProperties(1, NONE);
		walls.setTileProperties(2, ANY);
		player = new Player();
		map.loadEntities(placeEntities, "entities");
		add(walls);

		add(coins);
		add(player);
		FlxG.camera.follow(player, TOPDOWN, 1);
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		FlxG.collide(player, walls);
		FlxG.overlap(player, coins, playerTouchCoin);
	}

	function placeEntities(entity:EntityData)
	{
		if (entity.name == "player")
		{
			player.setPosition(entity.x, entity.y);
		}
		else if (entity.name == "coin")
		{
			coins.add(new Coin(entity.x + 4, entity.y + 4));
		}
	}

	function playerTouchCoin(player:Player, coin:Coin)
	{
		if (player.alive && player.exists && coin.alive && coin.exists)
		{
			coin.kill();
		}
	}
}
