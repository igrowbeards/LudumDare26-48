package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxObject;

class WBlock extends FlxSprite {

	private var deathTimer:Float;
	private var deathTime:Float = .5;

	override public function new(X:Int,Y:Int) {
		super(X,Y);
		loadGraphic("assets/white.png");
		loadGraphic("assets/white.png",true,true,16,16,true);
		addAnimation("idle", [0,1,2,3], 10, true);
		play('idle');
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
