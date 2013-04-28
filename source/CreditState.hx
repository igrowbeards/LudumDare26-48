package;

import nme.Assets;
import nme.geom.Rectangle;
import org.flixel.FlxButton;
import org.flixel.FlxG;
import org.flixel.FlxPath;
import org.flixel.FlxSave;
import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.FlxBasic;
import org.flixel.FlxText;
import org.flixel.FlxU;
import org.flixel.FlxTilemap;
import org.flixel.FlxObject;
import org.flixel.FlxPoint;
import org.flixel.FlxGroup;
import org.flixel.plugin.photonstorm.FlxMath;
import org.flixel.addons.FlxBackdrop;
import org.flixel.plugin.photonstorm.FlxBar;
import org.flixel.plugin.photonstorm.FlxVelocity;

class CreditState extends FlxState {

	public var gameOverText:FlxText;
	public var gameOverDetails:FlxText;
	public var gameOverOptions:FlxText;
	public var optionsText:FlxText;
	public var blockMat:FlxSprite;
	public var optionsIndicator:FlxSprite;
	public var gameOverDim:FlxSprite;
	public var gameOverOption:Int = 0;

	override public function create():Void {
		//FlxG.playMusic("music");
		FlxG.bgColor = 0xff000000;
		FlxG.mouse.hide();

		add(new FlxBackdrop("assets/grid.png",true,true));

		blockMat = new FlxSprite(47,47);
		blockMat.loadGraphic("assets/bounds.png");
		add(blockMat);

		gameOverDim = new FlxSprite(0,0);
		gameOverDim.makeGraphic(FlxG.width,FlxG.height,0x99000000);
		add(gameOverDim);

		gameOverText = new FlxText(60,60,FlxG.width - 60 * 2, "This game was made for the 48 hour Ludum Dare #26 by Justin Edwards (aka igrowbeards).\n\nThe music is \"Data\" by Podington Bear - Courtesy of podingtonbear.com and freemusicarchive.org.\n\nIt was built with Sublime Text 2 and HaxeFlixel. Photoshop was used for the graphics, and as3sfx for the sound effects.\n ");
		gameOverText.size = 8;
		add(gameOverText);

		gameOverDetails = new FlxText(60,140,FlxG.width - 60 * 2, "");
		gameOverDetails.alignment = 'center';
		gameOverDetails.size = 16;
		add(gameOverDetails);

		optionsText = new FlxText(60,195,FlxG.width - 60 * 2, "");
		optionsText.alignment = 'center';
		optionsText.size = 16;
		optionsText.text = "Play Game\nMenu";
		add(optionsText);

		optionsIndicator = new FlxSprite(133,196);
		optionsIndicator.loadGraphic("assets/indicator.png");
		add(optionsIndicator);
 	}

	override public function destroy():Void {
		super.destroy();
	}

	override public function update():Void {
		if (FlxG.keys.justPressed("DOWN")) {
			FlxG.play('move_block');
			if (gameOverOption < 1) {
				gameOverOption++;
			}
			else {
				gameOverOption = 0;
			}
		}
		if (FlxG.keys.justPressed("UP")) {
			FlxG.play('move_block');
			if (gameOverOption == 0) {
				gameOverOption = 1;
			}
			else {
				gameOverOption--;
			}
		}

		switch (gameOverOption) {
			case 0:
				optionsIndicator.x = 133;
				optionsIndicator.y = 196;
			case 1:
				optionsIndicator.x = 158;
				optionsIndicator.y = 219;
			case 2:
				optionsIndicator.x = 150;
				optionsIndicator.y = 237;
		}

		if (FlxG.keys.justPressed("SPACE") || FlxG.keys.justPressed("ENTER")) {
			FlxG.play('start');
			switch (gameOverOption) {
				case 0:
					fadeOutToPlayState();
				case 1:
					fadeOutToMenu();
			}
		}
	}

	public function fadeOutToPlayState():Void {
		FlxG.fade(0xff000000,.5,loadPlayState);
	}

	public function loadPlayState() {
		FlxG.switchState(new PlayState());
	}

	public function fadeOutToMenu():Void {
		FlxG.fade(0xff000000,.5,loadMenu);
	}

	public function loadMenu() {
		FlxG.switchState(new MenuState());
	}


}