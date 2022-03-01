package;

import flixel.graphics.tile.FlxGraphicsShader;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import openfl.display.BitmapData;
import flixel.system.FlxAssets.FlxGraphicSource;
import flixel.graphics.FlxGraphic;
import lime.utils.Assets;
import haxe.io.Path;
import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;
import openfl.utils.AssetType;
import openfl.utils.Assets as OpenFlAssets;

using StringTools;

class Paths {
	inline public static var SOUND_EXT = #if web "mp3" #else "ogg" #end;

	static var currentLevel:String;

	static var currentStage:String;

	static public function setCurrentLevel(name:String) {
		currentLevel = name.toLowerCase();
	}

	static public function setCurrentStage(stage:String) {
		currentStage = stage;
	}

	static function getPath(file:String, type:AssetType, library:Null<String>) {
		if (library != null)
			return getLibraryPath(file, library);
		
		if (currentLevel != null) {
			var levelPath = getLibraryPathForce(file, currentLevel);
			/*
			if (!(levelPath.contains("NOTE_assets") || levelPath.contains("alphabet"))) {
				trace(levelPath + " | " + OpenFlAssets.exists(levelPath, type));
			}
			*/
			if (OpenFlAssets.exists(levelPath, type))
				return levelPath;

			levelPath = getLibraryPathForce(file, "shared");
			if (OpenFlAssets.exists(levelPath, type))
				return levelPath;
		}

		return getPreloadPath(file);
	}

	static public function getLibraryPath(file:String, library = "preload") {
		return if (library == "preload" || library == "default") getPreloadPath(file); else getLibraryPathForce(file, library);
	}

	inline static function getLibraryPathForce(file:String, library:String) {
		return '$library:assets/$library/$file';
	}

	inline static function getPreloadPath(file:String) {
		return 'assets/$file';
	}

	inline static public function file(file:String, type:AssetType = TEXT, ?library:String) {
		return getPath(file, type, library);
	}

	inline static public function txt(key:String, ?library:String) {
		return getPath('data/$key.txt', TEXT, library);
	}

	inline static public function xml(key:String, ?library:String) {
		return getPath('data/$key.xml', TEXT, library);
	}

	inline static public function json(key:String, ?library:String) {
		return getPath('data/$key.json', TEXT, library);
	}

	static public function sound(key:String, ?library:String) {
		return getPath('sounds/$key.$SOUND_EXT', SOUND, library);
	}

	static public function stageMusic(key:String, ?stage:String) {
		if (stage == null) stage = currentStage;
		return getLibraryPathForce('$stage/music/$key.$SOUND_EXT', "stages");
	}

	inline static public function stageImage(key:String, ?stage:String) {
		if (stage == null) stage = currentStage;
		return getLibraryPathForce('$stage/images/$key.png', "stages");
	}

	inline static public function stageSparrow(key:String, ?stage:String) {
		if (stage == null) stage = currentStage;
		return FlxAtlasFrames.fromSparrow(stageImage(key, stage), getLibraryPathForce('$stage/images/$key.xml', "stages"));
	}

	inline static public function stagePacker(key:String, ?stage:String) {
		if (stage == null) stage = currentStage;
		return FlxAtlasFrames.fromSpriteSheetPacker(stageImage(key, stage), getLibraryPathForce('$stage/images/$key.txt', "stages"));
	}

	inline static public function soundRandom(key:String, min:Int, max:Int, ?library:String) {
		return sound(key + FlxG.random.int(min, max), library);
	}

	inline static public function music(key:String, ?library:String) {
		return getPath('music/$key.$SOUND_EXT', MUSIC, library);
	}

	inline static public function voices(song:String) {
		return 'songs:assets/songs/${song.toLowerCase()}/Voices.$SOUND_EXT';
	}

	inline static public function inst(song:String) {
		return 'songs:assets/songs/${song.toLowerCase()}/Inst.$SOUND_EXT';
	}

	inline static public function voicesNoLib(song:String) {
		return 'assets/songs/${song.toLowerCase()}/Voices.$SOUND_EXT';
	}

	inline static public function instNoLib(song:String) {
		return 'assets/songs/${song.toLowerCase()}/Inst.$SOUND_EXT';
	}

	inline static public function PEvoices(song:String) {
		return 'mods/songs/${song.toLowerCase()}/Voices.$SOUND_EXT';
	}

	inline static public function PEinst(song:String) {
		return 'mods/songs/${song.toLowerCase()}/Inst.$SOUND_EXT';
	}

	inline static public function getLuaPath(song:String) {
		return 'mods/songs/${song.toLowerCase()}/script.lua';
	}

	static public function skinIcon(char:String):String {
		if (char == "bf") {
			return Options.customBfPath + 'icon.png';
		}
		else if (char == "dad") {
			return Options.customDadPath + 'icon.png';
		}
		else if (char == "gf") {
			return Options.customGfPath + 'icon.png';
		}
		return null;
	}

	inline static public function modsIcon(char:String) {
		return 'mods/characters/$char/icon.png';
	}

	inline static public function PEgetSparrowAtlas(key:String, ?library:String) {
		#if sys
		return FlxAtlasFrames.fromSparrow(BitmapData.fromBytes(sys.io.File.getBytes(key + ".png")), sys.io.File.getContent(key + ".xml"));
		#else
		return Paths.getSparrowAtlas('DADDY_DEAREST');
		#end
	}

	inline static public function font(key:String) {
		return 'assets/fonts/$key';
	}

	inline static public function image(key:String, ?library:String) {
		return getPath('images/$key.png', IMAGE, library);
	}

	inline static public function video(key:String, ?library:String) {
		return getPath('cutscenes/$key.mp4', BINARY, library);
	}

	inline static public function getSparrowAtlas(key:String, ?library:String) {
		return FlxAtlasFrames.fromSparrow(image(key, library), file('images/$key.xml', library));
	}

	inline static public function weekimage(key:String, week:Int, ?library:String) {
		return getPath('week$week/images/$key.png', IMAGE, library);
	}

	inline static public function getWeekSparrowAtlas(key:String, week:Int, ?library:String) {
		return FlxAtlasFrames.fromSparrow(weekimage(key, week, library), file('week$week/images/$key.xml', library));
	}

	inline static public function getPackerAtlas(key:String, ?library:String) {
		return FlxAtlasFrames.fromSpriteSheetPacker(image(key, library), file('images/$key.txt', library));
	}
}
