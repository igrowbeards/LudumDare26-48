package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxObject;

class CBlock extends FlxSprite {

	override public function new(X:Int,Y:Int) {
		super(X,Y);
		makeGraphic(16,16,0xff00ffff);
		immovable = true;
	}

	override public function update() {
		super.update();
	}

}
