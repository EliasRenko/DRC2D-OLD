package drc.backend.native.utils;

import sdl.RWops;
import drc.core.Promise;
import drc.data.Profile;
import haxe.Json;
import haxe.io.UInt8Array;
import haxe.io.Bytes;
import drc.buffers.Uint8Array;
import sdl.SDL;
import sys.io.File;
import drc.format.PNG;
import drc.backend.native.data.Texture;

typedef TextureData = {

    var width: Int;

    var height: Int;

    var comp: Int;
}

@:enum abstract FileSeek(Int) from Int to Int {
	
    var set = 0;
	
    var cur = 1;
	
    var end = 2;
}

class Resources {

    public static function loadBytes(path:String, func:(Int, Dynamic)->Void):Void {

        var _mode:String = 'rb';

        var _file:RWops = SDL.RWFromFile(SDL.getBasePath() + path, _mode);

        var size:Int = 0;
		
		var _cur = SDL.RWtell(_file);

        var _bytes = File.read(SDL.getBasePath() + path, true);
        
        SDL.RWseek(_file, 0, FileSeek.end);
		
        size = SDL.RWtell(_file);
		
        SDL.RWseek(_file, 0, FileSeek.set);

        var dest:UInt8Array = new UInt8Array(size);

        if (size != 0) {

            //file_read(_file, _dest, _dest.length, 1);
            
            SDL.RWread(_file, dest.getData().bytes.getData(), size, 1);
        }
            
        SDL.RWclose(_file);

        trace(dest.view.buffer);

        func(200, dest);
    }

    public static function loadText(path:String, func:(Int, Dynamic)->Void):Void {

        var _bytes = File.getBytes(SDL.getBasePath() + path);
        
        func(200, _bytes.toString());
    }

    public static function loadTexture(path:String, func:(Int, Dynamic)->Void):Void {
        
        var input = File.read(SDL.getBasePath() + path, true);

        var png:PNG = new PNG(input);

        var _bytes:Bytes = png.extract();

        var header = PNG.getHeader(png.data);
        
        var _texture:Texture = new Texture(UInt8Array.fromBytes(_bytes), header.colbits, header.width, header.height);

        func(200, _texture);
    }

    public static function loadTexture2(path:String, func:(Int, Dynamic)->Void):Void {
        
        var _mode:String = 'rb';

        var _file:RWops = SDL.RWFromFile(SDL.getBasePath() + path, _mode);

        var size:Int = 0;
		
		var _cur = SDL.RWtell(_file);

        var _bytes = File.read(SDL.getBasePath() + path, true);
        
        SDL.RWseek(_file, 0, FileSeek.end);
		
        size = SDL.RWtell(_file);
		
        SDL.RWseek(_file, 0, FileSeek.set);

        var dest:UInt8Array = new UInt8Array(size);

        if (size != 0) {

            //file_read(_file, _dest, _dest.length, 1);
            
            SDL.RWread(_file, dest.getData().bytes.getData(), size, 1);
        }

        SDL.RWclose(_file);



        //func(200, _texture);
    }

    public static function loadProfile(path:String, func:(Int, Dynamic)->Void):Void {

        var _bytes = File.getBytes(SDL.getBasePath() + path);
        
        func(200, _bytes.toString());
    }
}