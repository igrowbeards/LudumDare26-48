package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxObject;

class Block extends FlxSprite {

	private var screenBuffer:Int = 50;
	private var friction:Int = 300;

	override public function new(X:Int,Y:Int) {

		super(X * 16,Y * 16);
		makeGraphic(14,14,0xffff0000);

	}

	override public function update() {

		if (x < screenBuffer) {
			x = screenBuffer;
		}

		if (x > FlxG.width - this.width - screenBuffer) {
			x = FlxG.width - this.width - screenBuffer;
		}

		if (y < screenBuffer) {
			y = screenBuffer;
		}

		if (y > FlxG.height - this.height - screenBuffer) {
			y = FlxG.height - this.height - screenBuffer;
		}

	}

}
