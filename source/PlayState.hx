package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tile.FlxTile;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	var player:Player;
	var tel:FlxSprite;
	var coins:FlxTypedGroup<Coin>;

	var map:FlxOgmo3Loader;
	var walls:FlxTilemap;
	var holder:FlxSprite;
	var canJump:Bool;

	public static var points:Int = 0;
	public static var pointsT:FlxText;

	override public function create()
	{
		FlxG.cameras.bgColor = FlxColor.fromRGB(153, 80, 80, 255);

		map = new FlxOgmo3Loader(AssetPaths.HelloWorld__ogmo, AssetPaths.room_001__json);
		coins = new FlxTypedGroup<Coin>();
		tel = new Tel(160, 272);

		walls = map.loadTilemap(AssetPaths.Yes__png, "walls");
		walls.follow();
		walls.setTileProperties(1, ANY);
		walls.setTileProperties(2, ANY);

		pointsT = new FlxText(0, 60, 0, "", 14); // TODO: points disappear whenever camera focus is lost. HUD camera maybe?

		pointsT.font = 'assets/data/ComicMono.ttf';
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
		FlxG.overlap(player, tel, playerTeleport);
		FlxG.collide(player, walls);
		FlxG.overlap(player, coins, playerTouchCoin);
		pointsT.text = Std.string(points);
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
				FlxG.switchState(new Stop('1', "4 plastic bags are consumed", 1));
				tel.visible = false;
			});
		}
	}
}
