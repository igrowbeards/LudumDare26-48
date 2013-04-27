package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxObject;

class YBlock extends FlxSprite {

	override public function new(X:Int,Y:Int) {
		super(X,Y);
		loadGraphic("assets/yellow.png");
		immovable = true;
	}

	override public function update() {
		super.update();
	}

}
