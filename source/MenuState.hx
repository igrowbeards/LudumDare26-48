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
	private var spawnTime:Float = 1;

	public var timerText:FlxText;
	public var gameTime:Float = 60;


	override public function create():Void {
		FlxG.bgColor = 0xff000000;
		FlxG.mouse.hide();

		blockMat = new FlxSprite(49,49);
		blockMat.loadGraphic("assets/bounds.png");
		add(blockMat);

		//add(new FlxBackdrop("assets/temp_grid.png",true,true));

		rBlocks = new FlxGroup();
		rBlocks.add(new RBlock(4,5));
		rBlocks.add(new RBlock(9,5));
		add(rBlocks);
		Registry.rBlocks = rBlocks;

		bBlocks = new FlxGroup();
		bBlocks.add(new BBlock(8,6));
		bBlocks.add(new BBlock(12,6));
		bBlocks.add(new BBlock(14,16));
		add(bBlocks);
		Registry.bBlocks = bBlocks;

		gBlocks = new FlxGroup();
		gBlocks.add(new GBlock(10,5));
		gBlocks.add(new GBlock(4,9));
		add(gBlocks);
		Registry.gBlocks = gBlocks;

		pBlocks = new FlxGroup();
		add(pBlocks);
		Registry.pBlocks = pBlocks;

		yBlocks = new FlxGroup();
		add(yBlocks);
		Registry.yBlocks = yBlocks;

		cBlocks = new FlxGroup();
		add(cBlocks);
		Registry.cBlocks = cBlocks;

		wBlocks = new FlxGroup();
		add(wBlocks);

		player = new Player(3,3);
		add(player);
		Registry.player = player;


		rlifeBar = new FlxBar(5, 5, FlxBar.FILL_LEFT_TO_RIGHT, 20, 4, player, "rlife");
		add(rlifeBar);

		glifeBar = new FlxBar(5, 10, FlxBar.FILL_LEFT_TO_RIGHT, 20, 4, player, "glife");
		add(glifeBar);

		blifeBar = new FlxBar(5, 15, FlxBar.FILL_LEFT_TO_RIGHT, 20, 4, player, "blife");
		add(blifeBar);

		timerText = new FlxText(0,10,FlxG.width, "Time");
		timerText.alignment = 'center';
		timerText.size = 16;
		add(timerText);

 	}

	override public function destroy():Void {
		super.destroy();
	}

	override public function update():Void {
		super.update();

		timerText.text = Std.string(Std.int(gameTime));
		gameTime -= FlxG.elapsed;

		// player collisions
		FlxG.overlap(rBlocks,player,playerHitRBlock);
		FlxG.overlap(bBlocks,player,playerHitBBlock);
		FlxG.overlap(gBlocks,player,playerHitGBlock);

		// hot block on block collisions
		FlxG.overlap(rBlocks,bBlocks,RBcollide);
		FlxG.overlap(rBlocks,gBlocks,RGcollide);
		FlxG.overlap(bBlocks,gBlocks,BGcollide);

		FlxG.overlap(cBlocks,rBlocks,makeWhiteBlock);
		FlxG.overlap(yBlocks,bBlocks,makeWhiteBlock);
		FlxG.overlap(pBlocks,gBlocks,makeWhiteBlock);

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

		// gameover conditions
		if (Registry.player.rlife <= 0 && Registry.player.glife <= 0 && Registry.player.blife <= 0) {
			FlxG.resetState();
		}

		if (gameTime <= 0) {
			FlxG.resetState();
		}

		if (FlxG.keys.justPressed("R")) {
			FlxG.resetState();
		}


		if (spawnTimer >= 0) {
			spawnTimer -= FlxG.elapsed;
		}
		else {
			spawnBlock();
			spawnTimer = spawnTime;
		}

	}

	public function playerHitRBlock(blockRef:FlxObject,playerRef:FlxObject) {
		var p:Player = cast(playerRef,Player);
		var b:RBlock = cast(blockRef,RBlock);
		if (Registry.player.currentColor != 'red') {
			p.hurtzDonut();
			if (Registry.player.currentColor == 'blue') {
				p.blife--;
			}
			else if (Registry.player.currentColor == 'green') {
				p.glife--;
			}
		}
		moveBlock(p,b);
	}

	public function playerHitBBlock(blockRef:FlxObject,playerRef:FlxObject) {
		var p:Player = cast(playerRef,Player);
		var b:BBlock = cast(blockRef,BBlock);
		if (Registry.player.currentColor != 'blue') {
			p.hurtzDonut();
			if (Registry.player.currentColor == 'red') {
				p.rlife--;
			}
			else if (Registry.player.currentColor == 'green') {
				p.glife--;
			}
		}
		moveBlock(p,b);
	}

	public function playerHitGBlock(blockRef:FlxObject,playerRef:FlxObject) {
		var p:Player = cast(playerRef,Player);
		var b:GBlock = cast(blockRef,GBlock);
		if (Registry.player.currentColor != 'green') {
			p.hurtzDonut();
			if (Registry.player.currentColor == 'red') {
				p.rlife--;
			}
			else if (Registry.player.currentColor == 'blue') {
				p.blife--;
			}
		}
		moveBlock(p,b);
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
		FlxG.score += 100;
		gameTime += 5;
		var spawn:FlxPoint = blockFuse(b1,b2);
		wBlocks.add(new WBlock(Std.int(spawn.x),Std.int(spawn.y)));
	}

	public function blockFuse(b1:FlxObject,b2:FlxObject):FlxPoint {
		var fuseX:Int;
		var fuseY:Int;
		fuseX = Std.int(b2.x);
		fuseY = Std.int(b2.y);
		b1.exists = false;
		b2.exists = false;

		return(new FlxPoint(fuseX,fuseY));
	}

	public function moveBlock(p:Player,b:Block) {
		if (p.x < b.x) {
			b.x += 16;
		}
		else if (p.x > b.x) {
			b.x -= 16;
		}
		else if (p.y > b.y) {
			b.y -= 16;
		}
		else if (p.y < b.y) {
			b.y += 16;
		}
		b.disableCol();
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