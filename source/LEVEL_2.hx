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

class LEVEL_2 extends FlxState
{
	static var player:Player;
	static var tel:FlxSprite;
	static var coins:FlxTypedGroup<Coin>;

	var points:Int = 100;
	var pointsT:FlxText;

	var map:FlxOgmo3Loader;
	var walls:FlxTilemap;

	override public function create()
	{
		map = new FlxOgmo3Loader(AssetPaths.HelloWorld__ogmo, 'assets/data/room-002.json');
		coins = new FlxTypedGroup<Coin>();
		tel = new Tel(448, 384);
		pointsT = new FlxText(0, 60, 0, "", 14);
		pointsT.font = 'assets/data/ComicMono.ttf';
		walls = map.loadTilemap(AssetPaths.tiles__png, "walls");
		walls.follow();
		walls.setTileProperties(1, ANY);
		walls.setTileProperties(2, ANY);
		player = new Player();
		map.loadEntities(placeEntities, "entities");
		add(walls);
		add(tel);
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
				FlxG.switchState(new Stop('2', "8 plastic bags are consumed", 2));
				tel.visible = false;
			});
		}
	}

	override public function update(elapsed:Float)
	{
		FlxG.overlap(player, coins, playerTouchCoin);
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
	}
}
