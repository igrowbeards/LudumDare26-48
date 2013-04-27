package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxObject;

class GBlock extends Block {

	override public function new(X:Int,Y:Int) {
		super(X,Y);
		makeGraphic(16,16,0xff00ff00);
	}

	override public function update() {
		super.update();
	}

}
