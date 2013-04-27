package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxObject;

class BBlock extends Block {

	override public function new(X:Int,Y:Int) {
		super(X,Y);
		makeGraphic(32,32,0xff0000ff);
	}

	override public function update() {
		super.update();
	}

}
