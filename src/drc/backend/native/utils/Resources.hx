package drc.backend.native.utils;

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

class Resources {

    public static function loadBytes(path:String, func:(Int, Dynamic)->Void):Void {

        var _bytes = File.getBytes(SDL.getBasePath() + path);
        
        func(200, _bytes);
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

    public static function loadProfile(path:String, func:(Int, Dynamic)->Void):Void {

        var _bytes = File.getBytes(SDL.getBasePath() + path);
        
        func(200, _bytes.toString());
    }
}