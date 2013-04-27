package;

import org.flixel.FlxG;
import org.flixel.FlxGroup;
import org.flixel.FlxSprite;
import org.flixel.FlxObject;
import org.flixel.plugin.photonstorm.FlxControl;
import org.flixel.plugin.photonstorm.FlxControlHandler;

class Player extends FlxSprite {

	public var rlife:Int = 100;
	public var glife:Int = 100;
	public var blife:Int = 100;
	public var currentColor:String;
	public var hurting:Bool;

	override public function new(X:Int,Y:Int) {

		super(X * 16,Y * 16);

		loadGraphic("assets/player.png",true,true,20,20,true);

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

		if (FlxG.getPlugin(FlxControl) == null) {
			FlxG.addPlugin(new FlxControl());
		}

		FlxControl.create(this, FlxControlHandler.MOVEMENT_INSTANT, FlxControlHandler.STOPPING_INSTANT, 1, true, true);
		FlxControl.player1.setCursorControl(true,true,true,true);
		FlxControl.player1.setStandardSpeed(150);

		currentColor = 'red';

	}

	override public function update() {


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

		if (x < 0) {
			x = 0;
		}

		if (x > FlxG.width - this.width) {
			x = FlxG.width - this.width;
		}

		if (y < 0) {
			y = 0;
		}

		if (y > FlxG.height - this.height) {
			y = FlxG.height - this.height;
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

	public function resetController():Void {
		FlxControl.clear();
	}

}
