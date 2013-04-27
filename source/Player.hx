package;

import org.flixel.FlxG;
import org.flixel.FlxGroup;
import org.flixel.FlxSprite;
import org.flixel.FlxObject;

class Player extends FlxSprite {

	public var rlife:Int = 20;
	public var glife:Int = 20;
	public var blife:Int = 20;
	public var currentColor:String;
	public var hurting:Bool;
	private var moveTimer:Float = 0;
	public var moveTime:Float = 0.25;

	override public function new(X:Int,Y:Int) {

		super(X * 16,Y * 16);

		loadGraphic("assets/player.png",true,true,20,20,true);
		width = 16;
		height = 16;
		offset.y = 2;
		offset.x = 2;

		addAnimation("idle", [0,1], 2, true);
		addAnimation("walk", [0,2,0,3], 10, true);
		addAnimation("idle_down", [4,5], 2, true);
		addAnimation("walk_down", [4,6,4,7], 10, true);
		addAnimation("idle_up", [8,9], 2, true);
		addAnimation("walk_up", [8,10,8,11], 10, true);
		addAnimation("hurt_down", [16,17,18,19], 15, true);
		addAnimation("hurt_side", [12,13,14,15], 15, true);
		addAnimation("hurt_up", [21,22,23,24], 15, true);

		play("idle");

		currentColor = 'red';
		immovable = true;

	}

	override public function update() {


		// MOVEMENT

		if (moveTimer <= 0) {

			// move right
			if (FlxG.keys.pressed("RIGHT")) {
				if (!overlapsAt(x + 1, y, Registry.cBlocks) && !overlapsAt(x + 1, y, Registry.pBlocks) && !overlapsAt(x + 1, y, Registry.yBlocks) ) {
					x = x + 16;
					moveTimer = moveTime;
					FlxG.log(x / 16 + ", " + y /16);
					facing = FlxObject.RIGHT;
				}
			}

			// move left
			else if (FlxG.keys.pressed("LEFT")) {
				if (!overlapsAt(x - 1, y, Registry.cBlocks) && !overlapsAt(x - 1, y, Registry.pBlocks) && !overlapsAt(x - 1, y, Registry.yBlocks) ) {
					x = x - 16;
					moveTimer = moveTime;
					FlxG.log(x / 16 + ", " + y /16);
					facing = FlxObject.LEFT;
				}
			}

			// move up
			else if (FlxG.keys.pressed("UP")) {
				if (!overlapsAt(x, y - 1, Registry.cBlocks) && !overlapsAt(x, y - 1, Registry.pBlocks) && !overlapsAt(x, y - 1, Registry.yBlocks) ) {
					y = y - 16;
					moveTimer = moveTime;
					FlxG.log(x / 16 + ", " + y /16);
					facing = FlxObject.UP;
				}
			}

			// movedown
			else if (FlxG.keys.pressed("DOWN")) {
				if (!overlapsAt(x, y + 1, Registry.cBlocks) && !overlapsAt(x, y + 1, Registry.pBlocks) && !overlapsAt(x, y + 1, Registry.yBlocks) ) {

					y = y + 16;
					moveTimer = moveTime;
					FlxG.log(x / 16 + ", " + y /16);
					facing = FlxObject.DOWN;
				}
			}

		}

		if (moveTimer >= 0) {
			moveTimer -= FlxG.elapsed;
		}

		// animations

		if (velocity.x != 0 && velocity.y >= 0) {
			if (hurting) {
				play("hurt_side");
				color = 0x00ffffff;
			}
			else {
				play("walk");
			}
		}

		if (velocity.y == 0 && velocity.x == 0) {
			if (facing == FlxObject.DOWN) {
				play("idle_down");
			}
			else if (facing == FlxObject.UP){
				play("idle_up");
			}
			else {
				play("idle");
			}
		}

		if (velocity.y < 0 && velocity.x == 0) {
			if (hurting) {
				play('hurt_up');
				color = 0x00ffffff;
			}
			else {
				play("walk_up");
			}
		}
		else if (velocity.y > 0 && velocity.x == 0) {
			if (hurting) {
				play("hurt_down");
				color = 0x00ffffff;
			}
			else {
				play("walk_down");
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

		// switch color controls
		if (FlxG.keys.justPressed("ONE")) {
			currentColor = 'red';
		}
		else if (FlxG.keys.justPressed("TWO")) {
			currentColor = 'green';
		}
		else if (FlxG.keys.justPressed("THREE")) {
			currentColor = 'blue';
		}

		if (FlxG.keys.justPressed("SPACE")) {
			switch (currentColor) {
				case 'red':
					currentColor = 'blue';
				case 'blue':
					currentColor = 'green';
				case 'green':
					currentColor = 'red';
				}
		}

		hurting = false;

	}

}
