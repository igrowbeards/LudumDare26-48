package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxObject;

class CBlock extends FlxSprite {

	override public function new(X:Int,Y:Int) {
		super(X,Y);
		loadGraphic("assets/cyan.png");
		immovable = true;
	}

	override public function update() {
		super.update();
	}

}
