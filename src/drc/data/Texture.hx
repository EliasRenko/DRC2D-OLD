package drc.data;

import opengl.WebGL.GLTexture;
import haxe.io.BytesData;
import stb.Image;

interface Texture {

    /** Publics. **/

    public var bytes(get, null):BytesData;

    public var glTexture:GLTexture;

    public var height(get, null):Int;

    public var width(get, null):Int;

    /** Methods. **/

    public function create(width:Int, height:Int):Void;

    public function upload(data:StbImageData):Void;

    /** Getters and setters. **/

    private function get_bytes():BytesData;

    private function get_height():Int;

    private function get_width():Int;
}