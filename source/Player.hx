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

	override public function new(X:Int,Y:Int) {

		super(X * 16,Y * 16);

		loadGraphic("assets/player.png",true,true,16,16,true);

		addAnimation("idle", [0,1], 2, true);
		addAnimation("walk", [0,2,0,3], 10, true);
		addAnimation("idle_down", [4,5], 2, true);
		addAnimation("walk_down", [4,6,4,7], 10, true);
		addAnimation("idle_up", [8,9], 2, true);
		addAnimation("walk_up", [8,10,8,11], 10, true);

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
			play("walk");
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

		if ( velocity.y < 0 && velocity.x == 0) {
			play("walk_up");
		}
		else if (velocity.y > 0 && velocity.x == 0) {
			play("walk_down");
		}

		if (currentColor == 'red') {
			if (rlife > 0) {
				color = 0xffff0000;
			}
			else {
				currentColor = 'green';
			}
		}
		else if (currentColor == 'green') {
			if (glife > 0) {
				color = 0xff00ff00;
			}
			else {
				currentColor = 'blue';
			}
		}
		else if (currentColor == 'blue') {
			if (blife > 0) {
				color = 0xff0000ff;
			}
			else {
				currentColor = 'red';
			}
		}

	}

	public function resetController():Void {
		FlxControl.clear();
	}

}
