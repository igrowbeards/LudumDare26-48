package;

import nme.Assets;
import nme.geom.Rectangle;
import org.flixel.FlxButton;
import org.flixel.FlxG;
import org.flixel.FlxPath;
import org.flixel.FlxSave;
import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.FlxBasic;
import org.flixel.FlxText;
import org.flixel.FlxU;
import org.flixel.FlxTilemap;
import org.flixel.FlxObject;
import org.flixel.FlxPoint;
import org.flixel.FlxGroup;
import org.flixel.plugin.photonstorm.FlxMath;
import org.flixel.addons.FlxBackdrop;
import org.flixel.plugin.photonstorm.FlxBar;

class MenuState extends FlxState {

	public var player:Player;
	public var level:FlxTilemap;
	public var rBlocks:FlxGroup;
	public var bBlocks:FlxGroup;
	public var gBlocks:FlxGroup;
	public var blockMat:FlxSprite;
	public var rlifeBar:FlxBar;
	public var glifeBar:FlxBar;
	public var blifeBar:FlxBar;
	public var shrine:ColorShrine;

	override public function create():Void {
		FlxG.bgColor = 0xff000000;
		FlxG.mouse.hide();

		blockMat = new FlxSprite(49,49);
		//blockMat.makeGraphic(FlxG.width -100, FlxG.height - 100, 0x11ffffff);
		blockMat.loadGraphic("assets/bounds.png");
		add(blockMat);

		//add(new FlxBackdrop("assets/temp_grid.png",true,true));

		player = new Player(2,3);
		add(player);
		Registry.player = player;

		rBlocks = new FlxGroup();
		rBlocks.add(new RBlock(4,5));
		add(rBlocks);

		bBlocks = new FlxGroup();
		bBlocks.add(new BBlock(8,6));
		add(bBlocks);

		gBlocks = new FlxGroup();
		gBlocks.add(new GBlock(10,5));
		add(gBlocks);

		shrine = new ColorShrine(12,16);
		add(shrine);

		rlifeBar = new FlxBar(5, 5, FlxBar.FILL_LEFT_TO_RIGHT, 20, 4, player, "rlife");
		add(rlifeBar);

		glifeBar = new FlxBar(5, 10, FlxBar.FILL_LEFT_TO_RIGHT, 20, 4, player, "glife");
		add(glifeBar);

		blifeBar = new FlxBar(5, 15, FlxBar.FILL_LEFT_TO_RIGHT, 20, 4, player, "blife");
		add(blifeBar);

		FlxG.log(FlxG.height + ", " + FlxG.width);

 	}

	override public function destroy():Void {
		super.destroy();
	}

	override public function update():Void {
		super.update();
		FlxG.collide(rBlocks,player,playerHitRBlock);
		FlxG.collide(bBlocks,player,playerHitBBlock);
		FlxG.collide(gBlocks,player,playerHitGBlock);
	}

	public function playerHitRBlock(blockRef:FlxObject,playerRef:FlxObject) {
		var p:Player = cast(playerRef,Player);
		if (!Registry.player.red) {
			if (Registry.player.blue) {
				p.blife--;
			}
			else if (Registry.player.green) {
				p.glife--;
			}

		}
	}

	public function playerHitBBlock(blockRef:FlxObject,playerRef:FlxObject) {
		var p:Player = cast(playerRef,Player);
		if (!Registry.player.blue) {
			if (Registry.player.red) {
				p.rlife--;
			}
			else if (Registry.player.green) {
				p.glife--;
			}

		}
	}

	public function playerHitGBlock(blockRef:FlxObject,playerRef:FlxObject) {
		var p:Player = cast(playerRef,Player);
		if (!Registry.player.green) {
			if (Registry.player.red) {
				p.rlife--;
			}
			else if (Registry.player.blue) {
				p.blife--;
			}

		}
	}


}