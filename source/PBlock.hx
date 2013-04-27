package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxObject;

class PBlock extends FlxSprite {

	override public function new(X:Int,Y:Int) {
		super(X,Y);
		makeGraphic(32,32,0xffff00ff);
	}

	override public function update() {
		super.update();
	}

}
