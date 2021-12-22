package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;

class LEVEL_3 extends FlxState
{
	var player:Player;
	var map:FlxOgmo3Loader;
	var walls:FlxTilemap;
	var tel:FlxSprite;

	var points:Int = 300;
	var pointsT:FlxText;

	var coins:FlxTypedGroup<Coin>;

	override public function create()
	{
		map = new FlxOgmo3Loader(AssetPaths.HelloWorld__ogmo, 'assets/data/room-003.json');
		coins = new FlxTypedGroup<Coin>();
		pointsT = new FlxText(0, 60, 0, "", 14);
		tel = new Tel(448, 384);
		pointsT.font = 'assets/data/ComicMono.ttf';
		walls = map.loadTilemap(AssetPaths.tiles__png, "walls");
		walls.follow();
		walls.setTileProperties(1, ANY);
		walls.setTileProperties(2, ANY);
		player = new Player();
		map.loadEntities(placeEntities, "entities");
		add(walls);
		add(coins);
		add(player);
		add(pointsT);

		FlxG.camera.follow(player, TOPDOWN, 1);
		super.create();
	}

	function placeEntities(entity:EntityData)
	{
		if (entity.name == "player")
		{
			player.setPosition(entity.x, entity.y);
		}
		else if (entity.name == "coin")
		{
			coins.add(new Coin(entity.x + 4, entity.y - 8));
		}
		else if (entity.name == "tel")
		{
			tel.setPosition(entity.x, entity.y);
		}
	}

	function playerTouchCoin(player:Player, coin:Coin)
	{
		if (player.alive && player.exists && coin.alive && coin.exists)
		{
			coin.kill();
			points = points + 25;
		}
	}

	function playerTeleport(player:Player, tel:Tel)
	{
		if (player.alive && player.exists && tel.alive && tel.exists)
		{
			FlxG.camera.fade(FlxColor.BLACK, 1, false, function()
			{
				FlxG.switchState(new Stop('3', "12 plastic bags are consumed", 3));
				tel.visible = false;
			});
		}
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
		pointsT.text = Std.string(points);
		super.update(elapsed);
		FlxG.overlap(player, tel, playerTeleport);
		FlxG.collide(player, walls);
		FlxG.overlap(player, coins, playerTouchCoin);
	}
}
