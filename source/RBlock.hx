package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxObject;

class RBlock extends Block {

	override public function new(X:Int,Y:Int) {
		super(X,Y);
		makeGraphic(32,32,0xffff0000);
	}

	override public function update() {
		super.update();
	}

}
