package;

import org.flixel.FlxG;
import org.flixel.FlxGroup;
import org.flixel.FlxSprite;
import org.flixel.FlxObject;
import org.flixel.tweens.motion.LinearMotion;

class Player extends FlxSprite {

	public var rlife:Int = 3;
	public var glife:Int = 3;
	public var blife:Int = 3;
	public var currentColor:String;
	public var hurting:Bool;
	public var hurtTimer:Float;
	public var hurtTime:Float = .25;
	private var moveTimer:Float = 0;
	public var moveTime:Float = 0.15;
	private var targetX:Float;
	private var targetY:Float;

	override public function new(X:Int,Y:Int) {

		super(X * 16,Y * 16);

		loadGraphic("assets/player.png",true,true,20,20,true);
		width = 16;
		height = 16;
		offset.y = 2;
		offset.x = 2;

		addAnimation("idle", [0,1], 7, true);
		addAnimation("idle_down", [4,5], 7, true);
		addAnimation("idle_up", [8,9], 10, true);
		addAnimation("hurt_down", [16,17,18,19], 15, true);
		addAnimation("hurt_side", [12,13,14,15], 15, true);
		addAnimation("hurt_up", [21,22,23,24], 15, true);

		play("idle");

		currentColor = 'red';
		immovable = true;
		hurtTimer = hurtTime;

	}

	override public function update() {

		if (x < targetX) {
			x += 8;
		}
		else if (x > targetX) {
			x -= 8;
		}
		else if (targetY > y) {
			y += 8;
		}
		else if (targetY < y) {
			y -= 8;
		}

		if (moveTimer <= 0) {

			// move right
			if (FlxG.keys.pressed("RIGHT")) {
				if (!overlapsAt(x + 1, y, Registry.cBlocks) && !overlapsAt(x + 1, y, Registry.pBlocks) && !overlapsAt(x + 1, y, Registry.yBlocks) ) {
					targetX = x + 16;
					moveTimer = moveTime;
					facing = FlxObject.RIGHT;
				}
			}

			// move left
			else if (FlxG.keys.pressed("LEFT")) {
				if (!overlapsAt(x - 1, y, Registry.cBlocks) && !overlapsAt(x - 1, y, Registry.pBlocks) && !overlapsAt(x - 1, y, Registry.yBlocks) ) {
					targetX = x - 16;
					moveTimer = moveTime;
					facing = FlxObject.LEFT;
				}
			}

			// move up
			else if (FlxG.keys.pressed("UP")) {
				if (!overlapsAt(x, y - 1, Registry.cBlocks) && !overlapsAt(x, y - 1, Registry.pBlocks) && !overlapsAt(x, y - 1, Registry.yBlocks) ) {
					targetY = y - 16;
					moveTimer = moveTime;
					facing = FlxObject.UP;
				}
			}

			// movedown
			else if (FlxG.keys.pressed("DOWN")) {
				if (!overlapsAt(x, y + 1, Registry.cBlocks) && !overlapsAt(x, y + 1, Registry.pBlocks) && !overlapsAt(x, y + 1, Registry.yBlocks) ) {
					targetY = y + 16;
					moveTimer = moveTime;
					facing = FlxObject.DOWN;
				}
			}

		}

		if (moveTimer >= 0) {
			moveTimer -= FlxG.elapsed;
		}

		// animations
		if (facing == FlxObject.RIGHT || facing == FlxObject.LEFT) {
			if (hurting) {
				play('hurt_side');
			}
			else {
				play("idle");
			}
		}

		if (facing == FlxObject.DOWN) {
			if (hurting) {
				play('hurt_down');
			}
			else {
				play("idle_down");
			}
		}

		if (facing == FlxObject.UP) {
			if (hurting) {
				play('hurt_up');
			}
			else {
				play("idle_up");
			}
		}


		if (currentColor == 'red') {
			if (rlife > 0) {
				if (!hurting) {
					color = 0xffff0000;
				}
			}
			else {
				currentColor = 'green';
			}
		}
		else if (currentColor == 'green') {
			if (glife > 0) {
				if (!hurting) {
					color = 0xff00ff00;
				}
			}
			else {
				currentColor = 'blue';
			}
		}
		else if (currentColor == 'blue') {
			if (blife > 0) {
				if (!hurting) {
					color = 0xff0000ff;
				}
			}
			else {
				currentColor = 'red';
			}
		}

		if (FlxG.keys.justPressed("SPACE")) {
			switch (currentColor) {
				case 'red':
					if (blife > 0) {
						FlxG.play("switch_color");
						currentColor = 'blue';
					}
					else if (glife > 0) {
						FlxG.play("switch_color");
						currentColor = 'green';
					}
				case 'blue':
					if (glife > 0) {
						FlxG.play("switch_color");
						currentColor = 'green';
					}
					else if (rlife > 0) {
						FlxG.play("switch_color");
						currentColor = 'red';
					}
				case 'green':
					if (rlife > 0) {
						FlxG.play("switch_color");
						currentColor = 'red';
					}
					else if (blife > 0) {
						FlxG.play("switch_color");
						currentColor = 'blue';
					}
			}
		}

		if (hurting) {
			color = 0xfffffff;
			if (hurtTimer <= 0) {
				hurting = false;
				hurtTimer = hurtTime;
			}
			else {
				hurtTimer -= FlxG.elapsed;
			}
		}

	}

	public function hurtzDonut() {
		FlxG.play('hurt');
		hurting = true;
	}

}
