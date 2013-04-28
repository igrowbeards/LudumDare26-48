package;

import nme.Lib;
import org.flixel.FlxGame;

class ProjectClass extends FlxGame {
	public function new() {
		super(400,400, MenuState, 2, 30, 30);
	}
}
