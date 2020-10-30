package drc.data;

import drc.core.GL.GLTexture;
import haxe.io.BytesData;
import stb.Image;
import drc.utils.Color;
import drc.data.Texture;
//import drc.buffers.Uint8Array;
//import haxe.io.UInt8Array;
import drc.core.Buffers;

interface Texture {

    /** Publics. **/

    public var bytes:UInt8Array;

    public var bytesPerPixel(get, null):Int;

    public var powerOfTwo(get, null):Bool;
    
    public var glTexture:GLTexture;

    public var height(get, null):Int;

    public var width(get, null):Int;

    /** Methods. **/

    public function create(width:Int, height:Int):Void;

    public function copyPixels(sourceTexture:drc.data.Texture, x:Int, y:Int, width:UInt, height:UInt):Void;

    public function draw(x:UInt, y:UInt, width:UInt, height:UInt, color:Color):Void;

    public function generate(width:Int, height:Int):Void;

    public function upload(data:UInt8Array, bytesPerPixel:Int, width:Int, height:Int):Void;

    /** Getters and setters. **/

    private function get_powerOfTwo():Bool;

    private function get_height():Int;

    private function get_width():Int;
}