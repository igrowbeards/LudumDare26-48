package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxObject;

class YBlock extends FlxSprite {

	override public function new(X:Int,Y:Int) {
		super(X,Y);
		makeGraphic(16,16,0xffffff00);
		immovable = true;
	}

	override public function update() {
		super.update();
	}

}
