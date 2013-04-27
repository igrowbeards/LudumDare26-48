package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxObject;

class WBlock extends FlxSprite {

	private var deathTimer:Float;
	private var deathTime:Float = .25;

	override public function new(X:Int,Y:Int) {
		super(X,Y);
		makeGraphic(32,32,0xffffffff);
		immovable = true;
		deathTimer = deathTime;
	}

	override public function update() {
		super.update();
		if (deathTimer >= 0) {
			deathTimer -= FlxG.elapsed;
		}
		else {
			this.exists = false;
		}
	}

}
