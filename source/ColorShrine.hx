package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxObject;

class ColorShrine extends FlxSprite {

	private var colorTimer:Float;
	private var colorTime:Float = 1.5;
	public var currentColor:String;

	override public function new(X:Int,Y:Int) {
		super(X * 16,Y * 16);
		loadGraphic("assets/colorshrine.png");
		immovable = true;
		colorTimer = colorTime;
		currentColor = 'red';
		color = 0xffff0000;
	}

	override public function update() {
		FlxG.log(currentColor);
		if (colorTimer >= 0) {
			colorTimer -= FlxG.elapsed;
		}
		else {
			switch(currentColor) {
				case 'red':
					currentColor = 'blue';
					color = 0xff0000ff;
				case 'green':
					currentColor = 'red';
					color = 0xffff0000;
				case 'blue':
					currentColor = 'green';
					color = 0xff00ff00;
			}
			colorTimer = colorTime;
		}
	}

}
