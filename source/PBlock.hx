package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxObject;

class PBlock extends FlxSprite {

	override public function new(X:Int,Y:Int) {
		super(X,Y);
		loadGraphic("assets/purple.png");
		immovable = true;
	}

	override public function update() {
		super.update();

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
	}

}
