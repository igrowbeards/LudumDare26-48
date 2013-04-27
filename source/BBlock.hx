package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxObject;

class BBlock extends Block {

	override public function new(X:Int,Y:Int) {
		super(X,Y);
		loadGraphic("assets/blue.png");
	}

	override public function update() {
		super.update();
	}

}
