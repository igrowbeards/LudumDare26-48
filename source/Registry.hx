package;

import org.flixel.FlxG;
import org.flixel.FlxGroup;
import org.flixel.FlxSprite;
import org.flixel.FlxTilemap;
import org.flixel.plugin.photonstorm.FlxWeapon;

class Registry {

    public static var player:Player;
    public static var level:FlxTilemap;
    public static var shrine:ColorShrine;

    public static function erase():Void {
        player = null;
    }

}