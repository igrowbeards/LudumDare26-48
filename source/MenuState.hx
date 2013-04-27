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
import org.flixel.plugin.photonstorm.FlxVelocity;

class MenuState extends FlxState {

	public var player:Player;

	public var level:FlxTilemap;

	public var rBlocks:FlxGroup;
	public var bBlocks:FlxGroup;
	public var gBlocks:FlxGroup;
	public var pBlocks:FlxGroup;
	public var yBlocks:FlxGroup;
	public var cBlocks:FlxGroup;
	public var wBlocks:FlxGroup;

	public var blockMat:FlxSprite;
	public var rlifeBar:FlxBar;
	public var glifeBar:FlxBar;
	public var blifeBar:FlxBar;

	private var spawnTimer:Float;
	private var spawnTime:Float = 0.1;


	override public function create():Void {
		FlxG.bgColor = 0xff000000;
		FlxG.mouse.hide();

		blockMat = new FlxSprite(49,49);
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

		pBlocks = new FlxGroup();
		add(pBlocks);

		yBlocks = new FlxGroup();
		add(yBlocks);

		cBlocks = new FlxGroup();
		add(cBlocks);

		wBlocks = new FlxGroup();
		add(wBlocks);

		rlifeBar = new FlxBar(5, 5, FlxBar.FILL_LEFT_TO_RIGHT, 20, 4, player, "rlife");
		add(rlifeBar);

		glifeBar = new FlxBar(5, 10, FlxBar.FILL_LEFT_TO_RIGHT, 20, 4, player, "glife");
		add(glifeBar);

		blifeBar = new FlxBar(5, 15, FlxBar.FILL_LEFT_TO_RIGHT, 20, 4, player, "blife");
		add(blifeBar);

 	}

	override public function destroy():Void {
		super.destroy();
	}

	override public function update():Void {
		super.update();

		// player collisions
		FlxG.collide(rBlocks,player,playerHitRBlock);
		FlxG.collide(bBlocks,player,playerHitBBlock);
		FlxG.collide(gBlocks,player,playerHitGBlock);
		FlxG.collide(player,pBlocks);
		FlxG.collide(player,yBlocks);
		FlxG.collide(player,cBlocks);

		// hot block on block collisions
		FlxG.collide(rBlocks,bBlocks,RBcollide);
		FlxG.collide(rBlocks,gBlocks,RGcollide);
		FlxG.collide(bBlocks,gBlocks,BGcollide);

		FlxG.collide(cBlocks,rBlocks,makeWhiteBlock);
		FlxG.collide(yBlocks,bBlocks,makeWhiteBlock);
		FlxG.collide(pBlocks,gBlocks,makeWhiteBlock);

		// blocks collide with themselves
		FlxG.collide(rBlocks,rBlocks);
		FlxG.collide(bBlocks,bBlocks);
		FlxG.collide(gBlocks,gBlocks);
		FlxG.collide(bBlocks,bBlocks);
		FlxG.collide(pBlocks,pBlocks);
		FlxG.collide(yBlocks,yBlocks);
		FlxG.collide(cBlocks,cBlocks);

		// blocks collide with all other non merging blocks
		FlxG.collide(cBlocks,bBlocks);
		FlxG.collide(cBlocks,gBlocks);
		FlxG.collide(pBlocks,rBlocks);
		FlxG.collide(pBlocks,bBlocks);
		FlxG.collide(yBlocks,rBlocks);
		FlxG.collide(yBlocks,gBlocks);

		// gameover condition
		if (Registry.player.rlife <= 0 && Registry.player.glife <= 0 && Registry.player.blife <= 0) {
			FlxG.resetState();
		}

		if (FlxG.keys.justPressed("R")) {
			FlxG.resetState();
		}

		/*

		if (spawnTimer >= 0) {
			spawnTimer -= FlxG.elapsed;
		}
		else {
			spawnBlock();
			spawnTimer = spawnTime;
		}

		*/

	}

	public function playerHitRBlock(blockRef:FlxObject,playerRef:FlxObject) {
		var p:Player = cast(playerRef,Player);
		if (Registry.player.currentColor != 'red') {
			p.hurting = true;
			if (Registry.player.currentColor == 'blue') {
				p.blife--;
			}
			else if (Registry.player.currentColor == 'green') {
				p.glife--;
			}

		}
	}

	public function playerHitBBlock(blockRef:FlxObject,playerRef:FlxObject) {
		var p:Player = cast(playerRef,Player);
		if (Registry.player.currentColor != 'blue') {
			p.hurting = true;
			if (Registry.player.currentColor == 'red') {
				p.rlife--;
			}
			else if (Registry.player.currentColor == 'green') {
				p.glife--;
			}

		}
	}

	public function playerHitGBlock(blockRef:FlxObject,playerRef:FlxObject) {
		var p:Player = cast(playerRef,Player);
		if (Registry.player.currentColor != 'green') {
			p.hurting = true;
			if (Registry.player.currentColor == 'red') {
				p.rlife--;
			}
			else if (Registry.player.currentColor == 'blue') {
				p.blife--;
			}

		}
	}

	public function RBcollide(b1:FlxObject,b2:FlxObject) {
		var spawn:FlxPoint = blockFuse(b1,b2);
		pBlocks.add(new PBlock(Std.int(spawn.x),Std.int(spawn.y)));
	}

	public function RGcollide(b1:FlxObject,b2:FlxObject) {
		var spawn:FlxPoint = blockFuse(b1,b2);
		yBlocks.add(new YBlock(Std.int(spawn.x),Std.int(spawn.y)));
	}

	public function BGcollide(b1:FlxObject,b2:FlxObject) {
		var spawn:FlxPoint = blockFuse(b1,b2);
		cBlocks.add(new CBlock(Std.int(spawn.x),Std.int(spawn.y)));
	}

	public function makeWhiteBlock(b1:FlxObject,b2:FlxObject) {
		var spawn:FlxPoint = blockFuse(b1,b2);
		wBlocks.add(new WBlock(Std.int(spawn.x),Std.int(spawn.y)));
	}

	public function blockFuse(b1:FlxObject,b2:FlxObject):FlxPoint {
		var fuseX:Int;
		var fuseY:Int;
		if (b1.x > b2.x) {
			fuseX = Std.int(b1.x);
		}
		else {
			fuseX = Std.int(b2.x);
		}
		if (b1.y > b2.y) {
			fuseY = Std.int(b1.y);
		}
		else {
			fuseY = Std.int(b2.y);
		}
		b1.exists = false;
		b2.exists = false;

		return(new FlxPoint(fuseX,fuseY));
	}

	public function spawnBlock():Void {
		var spawnX:Int;
		var spawnY:Int;

		var min:Int = 3;
		var max:Int = 21;

		spawnX = min + Std.int(Math.random() * ((max - min) + 1));
		spawnY = min + Std.int(Math.random() * ((max - min) + 1));

		switch (Std.random(3)) {
			case 0:
				rBlocks.add(new RBlock(spawnX,spawnY));
			case 1:
				bBlocks.add(new BBlock(spawnX,spawnY));
			case 2:
				gBlocks.add(new GBlock(spawnX,spawnY));
		}
	}

}