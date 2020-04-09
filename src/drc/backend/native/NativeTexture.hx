package drc.backend.native;

import drc.core.Context;
import haxe.io.Bytes;
import opengl.WebGL.GLTexture;
import haxe.io.BytesData;
import stb.Image;
import drc.utils.Common;
import drc.buffers.Uint8Array;

class NativeTexture implements drc.data.Texture {

    /** Publics. **/

    public var bytes(get, null):BytesData;

    public var height(get, null):Int;

    public var width(get, null):Int;

    public var glTexture:GLTexture;

    /** Privates. **/

    /** @private **/ private var __height:Int;

    /** @private **/ private var __width:Int;

    public function new(data:StbImageData) {
        
        upload(data);
    }
    
    public function upload(data:StbImageData):Void {
        
        __width = data.w;

        __height = data.h;

        glTexture = Common.context.generateTexture();

        Common.context.loadTexture(__width, height, Uint8Array.fromBytes(Bytes.ofData(data.bytes)));
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