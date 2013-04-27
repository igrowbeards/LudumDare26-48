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

class MenuState extends FlxState {

	public var player:Player;
	public var level:FlxTilemap;
	public var blocks:FlxGroup;
	public var blockMat:FlxSprite;

	override public function create():Void {
		FlxG.bgColor = 0xff000000;
		FlxG.mouse.hide();

		blockMat = new FlxSprite(50,50);
		blockMat.makeGraphic(FlxG.width -100, FlxG.height - 100, 0xffffffff);
		add(blockMat);

		player = new Player(2,3);
		add(player);
		Registry.player = player;

		blocks = new FlxGroup();
		blocks.add(new Block(4,5));
		add(blocks);
 	}

	override public function destroy():Void {
		super.destroy();
	}

	override public function update():Void {
		super.update();
		FlxG.collide(blocks,player);
	}

}