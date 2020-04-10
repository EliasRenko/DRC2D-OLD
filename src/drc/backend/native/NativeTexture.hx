package drc.backend.native;

import drc.core.Context;
import haxe.io.Bytes;
import opengl.WebGL.GLTexture;
import haxe.io.BytesData;
import stb.Image;
import drc.utils.Common;
import drc.buffers.Uint8Array;
import opengl.WebGL;

class NativeTexture implements drc.data.BitmapData {

    /** Publics. **/

    public var bytes(get, null):BytesData;

    public var height(get, null):Int;

    public var width(get, null):Int;

    public var glTexture:GLTexture;

    /** Privates. **/

    /** @private **/ private var __height:Int;

    /** @private **/ private var __width:Int;

    public function new(?data:StbImageData) {
        
        if (data == null) {

            return;
        }

        upload(data);
    }

    public function create(width:Int, height:Int) {

        __width = width;

        __height = height;

        glTexture = Common.context.generateTexture();

        WebGL.bindTexture(WebGL.TEXTURE_2D, glTexture);

        WebGL.texImage2D(WebGL.TEXTURE_2D, 0, WebGL.RGBA, __width, __height, 0, WebGL.RGBA, WebGL.UNSIGNED_BYTE, null);

        WebGL.bindTexture(WebGL.TEXTURE_2D, null);

        //Common.context.loadTexture(__width, __height, null);
    }
    
    public function upload(data:StbImageData):Void {
        
        __width = data.w;

        __height = data.h;

        glTexture = Common.context.generateTexture();

        Common.context.loadTexture(__width, __height, Uint8Array.fromBytes(Bytes.ofData(data.bytes)));
    }

    /** Getters and setters. **/

    private function get_bytes():BytesData {
        
        return null;
    }

    private function get_height():Int {
        
        return __height;
    }

    private function get_width():Int {
        
        return __width;
    }
}