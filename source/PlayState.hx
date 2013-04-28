package;

import nme.Assets;
import nme.geom.Rectangle;
import org.flixel.FlxButton;
import org.flixel.FlxG;
import org.flixel.FlxSave;
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

class PlayState extends FlxState {

	public var player:Player;

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
	public var scoreText:FlxText;
	public var gameOverText:FlxText;
	public var gameOverDetails:FlxText;
	public var optionsText:FlxText;
	public var gameTime:Float = 45;

	public var score_block:FlxSprite;

	public var gameover:Bool;

	public var optionsIndicator:FlxSprite;
	public var gameOverDim:FlxSprite;
	public var gameOverOption:Int = 0;
	public var saveGame:FlxSave;

	override public function create():Void {

		saveGame = new FlxSave();
		saveGame.bind("save");

		if (saveGame.data.highScore != null) {
			Registry.highScore = saveGame.data.highScore;
		}

		FlxG.bgColor = 0xff000000;
		FlxG.mouse.hide();

		FlxG.score = 0;

		add(new FlxBackdrop("assets/grid.png",true,true));

		blockMat = new FlxSprite(47,47);
		blockMat.loadGraphic("assets/bounds.png");
		add(blockMat);

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

		rlifeBar = new FlxBar(48, 355, FlxBar.FILL_LEFT_TO_RIGHT, 64, 8, player, "rlife", 0, 3,true);
		rlifeBar.createFilledBar(0x3cff0000, 0xaaff0000, 0xffff0000);
		add(rlifeBar);

		glifeBar = new FlxBar(48, 365, FlxBar.FILL_LEFT_TO_RIGHT, 64, 8, player, "glife", 0, 3,true);
		glifeBar.createFilledBar(0x3c00ff00, 0xaa00ff00);
		add(glifeBar);

		blifeBar = new FlxBar(48, 375, FlxBar.FILL_LEFT_TO_RIGHT, 64, 8, player, "blife", 0, 3,true);
		blifeBar.createFilledBar(0x3c0000ff, 0xaa0000ff);
		add(blifeBar);

		timerText = new FlxText(0,12,FlxG.width, "Time");
		timerText.alignment = 'center';
		timerText.size = 16;
		add(timerText);

		scoreText = new FlxText(48,360, 304, "x  0");
		scoreText.alignment = 'right';
		scoreText.size = 16;
		add(scoreText);

		score_block = new FlxSprite(285,364);
		score_block.loadGraphic("assets/score_blocks.png");
		add(score_block);

		gameOverDim = new FlxSprite(0,0);
		gameOverDim.makeGraphic(FlxG.width,FlxG.height,0x99000000);
		gameOverDim.exists = false;
		add(gameOverDim);

		gameOverText = new FlxText(48,75,304, "GAME OVER");
		gameOverText.alignment = 'center';
		gameOverText.size = 40;
		gameOverText.exists = false;
		add(gameOverText);

		gameOverDetails = new FlxText(60,140,FlxG.width - 60 * 2, "");
		gameOverDetails.alignment = 'center';
		gameOverDetails.size = 16;
		gameOverDetails.exists = false;
		add(gameOverDetails);

		optionsText = new FlxText(60,245,FlxG.width - 60 * 2, "");
		optionsText.alignment = 'center';
		optionsText.size = 16;
		optionsText.exists = false;
		optionsText.text = "Play Again\nMenu\nCredits";
		add(optionsText);


		optionsIndicator = new FlxSprite(133,256);
		optionsIndicator.loadGraphic("assets/indicator.png");
		add(optionsIndicator);
		optionsIndicator.exists = false;

 	}

	override public function destroy():Void {
		super.destroy();
	}

	override public function update():Void {
		if (!gameover) {
			super.update();

			timerText.text = Std.string(Std.int(gameTime));
			gameTime -= FlxG.elapsed;

			if (gameTime <= 10) {
				timerText.color = 0xffff0000;
				timerText.size = 24;
				timerText.y = 8;
			}
			else {
				timerText.color = 0xffffffff;
				timerText.size = 16;
				timerText.y = 12;
			}

			if (FlxG.score - 9 > 0) {
				scoreText.text = "x " + Std.string(FlxG.score);
			}
			else {
				scoreText.text = "x  " + Std.string(FlxG.score);
			}

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
				if (FlxG.score > Registry.highScore) {
					gameOver("death",true);
				}
				else {
					gameOver("death");
				}
			}

			if (gameTime <= 0) {
				if (FlxG.score > Registry.highScore) {
					gameOver("time",true);
				}
				else {
					gameOver("time");
				}
			}

			// reset state for debug etc

			if (FlxG.keys.justPressed("R")) {
				FlxG.resetState();
			}

			// spawn blocks

			if (spawnTimer >= 0) {
				spawnTimer -= FlxG.elapsed;
			}
			else {
				spawnBlock();
				spawnTimer = spawnTime;
			}
		}
		else {

			if (FlxG.keys.justPressed("DOWN")) {
				FlxG.play('move_block');
				if (gameOverOption < 2) {
					gameOverOption++;
				}
				else {
					gameOverOption = 0;
				}
			}
			if (FlxG.keys.justPressed("UP")) {
				FlxG.play('move_block');
				if (gameOverOption == 0) {
					gameOverOption = 2;
				}
				else {
					gameOverOption--;
				}
			}

			switch (gameOverOption) {
				case 0:
					optionsIndicator.x = 133;
					optionsIndicator.y = 247;
				case 1:
					optionsIndicator.x = 158;
					optionsIndicator.y = 268;
				case 2:
					optionsIndicator.x = 150;
					optionsIndicator.y = 287;
			}

			if (FlxG.keys.justPressed("SPACE") || FlxG.keys.justPressed("ENTER")) {
				FlxG.play('start');
				switch (gameOverOption) {
					case 0:
						fadeOutToPlayState();
					case 1:
						fadeOutToMenu();
					case 2:
						fadeOutToCredits();
				}
			}
		}
	}

	public function fadeOutToCredits():Void {
		FlxG.fade(0xff000000,.5,loadCredits);
	}

	public function loadCredits() {
		FlxG.switchState(new CreditState());
	}

	public function fadeOutToPlayState():Void {
		FlxG.fade(0xff000000,.5,loadPlayState);
	}

	public function loadPlayState() {
		FlxG.switchState(new PlayState());
	}

	public function fadeOutToMenu():Void {
		FlxG.fade(0xff000000,.5,loadMenu);
	}

	public function loadMenu() {
		FlxG.switchState(new MenuState());
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
		FlxG.score += 1;
		FlxG.play("clear");
		gameTime += 5;
		var spawn:FlxPoint = blockFuse(b1,b2);
		wBlocks.add(new WBlock(Std.int(spawn.x),Std.int(spawn.y)));
	}

	public function blockFuse(b1:FlxObject,b2:FlxObject):FlxPoint {
		FlxG.play("merge");
		var fuseX:Int;
		var fuseY:Int;
		fuseX = Std.int(b2.x);
		fuseY = Std.int(b2.y);
		b1.exists = false;
		b2.exists = false;

		return(new FlxPoint(fuseX,fuseY));
	}

	public function moveBlock(p:Player,b:Block) {
		FlxG.play('move_block');
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

	public function gameOver(cause:String,newHighScore:Bool = false) {

		FlxG.play("death");
		gameover = true;

		if (newHighScore) {
			gameOverText.text = "New High Score!";
			gameOverText.size = 24;
			Registry.highScore = FlxG.score;
			if (saveGame.data.highScore != null) {
				saveGame.data.highScore = FlxG.score;
			}
			else {
				saveGame.data.highScore = FlxG.score;
			}
		}

		gameOverText.exists = true;
		gameOverDim.exists = true;
		gameOverDetails.exists = true;
		optionsText.exists = true;
		optionsIndicator.exists = true;

		if (cause == "death") {
			gameOverDetails.text = "You cleared " + FlxG.score + " pixels before dying.";
			if (!newHighScore) {
				gameOverDetails.text = gameOverDetails.text + "\nOnly " + Std.string(saveGame.data.highScore - FlxG.score) + " more to beat your High Score of " + Std.string(saveGame.data.highScore) + ".";
			}
		}
		else if (cause == "time") {
			gameOverDetails.text = "You cleared " + FlxG.score + " pixels before running out of time.";
			if (!newHighScore) {
				gameOverDetails.text = gameOverDetails.text + "\nOnly " + Std.string(saveGame.data.highScore - FlxG.score) + " more to beat your High Score of " + Std.string(saveGame.data.highScore) + ".";
			}
		}
	}

}