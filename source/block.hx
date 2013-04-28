package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxObject;

class Block extends FlxSprite {

	private var screenBuffer:Int = 50;
	private var friction:Int = 300;
	private var colTimer:Float;
	private var colTime:Float  = .08;

	override public function new(X:Int,Y:Int) {

		super(X * 16,Y * 16);
		makeGraphic(14,14,0xffff0000);
		colTimer = colTime;

	}

	override public function update() {

		// debounce collisions
		if (allowCollisions == FlxObject.NONE) {
			if (colTimer <= 0) {
				allowCollisions = FlxObject.ANY;
				colTimer = colTime;
			}
			else {
				colTimer -= FlxG.elapsed;
			}
		}
	}

	public function disableCol() {
		allowCollisions = FlxObject.NONE;
	}

}
