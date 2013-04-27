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
    public static var rBlocks:FlxGroup;
    public static var gBlocks:FlxGroup;
    public static var bBlocks:FlxGroup;
    public static var pBlocks:FlxGroup;
    public static var yBlocks:FlxGroup;
    public static var cBlocks:FlxGroup;

    public static function erase():Void {
        player = null;
    }

}