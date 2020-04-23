package drc.backend.native.data;

import haxe.io.Bytes;
import haxe.io.BytesData;
import stb.Image;
import drc.utils.Common;
import drc.buffers.Uint8Array;
import opengl.WebGL;

class Texture implements drc.data.Texture {

    // ** Publics.

    public var bytes(get, null):BytesData;

    public var bytesPerPixel(get, null):Int;

    public var dirty(get, null):Bool;

    public var height(get, null):Int;

    public var powerOfTwo(get, null):Bool;

    public var transparent(get, null):Bool;

    public var width(get, null):Int;

    public var glTexture:GLTexture;

    // ** Privates.

    /** @private **/ private var __bytesPerPixel:Int;

    /** @private **/ private var __dirty:Bool = false;

    /** @private **/ private var __height:Int;

    /** @private **/ private var __transparent:Bool;

    /** @private **/ private var __width:Int;

    public function new(?data:StbImageData) {
        
        if (data == null) {

            return;
        }

        upload(data);

        //WebGL.pixelStorei(WebGL.UNPACK_ALIGNMENT, 1);
    }

    public function create(width:Int, height:Int) {

        __bytesPerPixel = 4;

        __width = width;

        __height = height;

        if (__bytesPerPixel == 4) {

            __transparent = true;
        }

        glTexture = Common.context.generateTexture();

        Common.context.loadTexture(__width, __height, __bytesPerPixel, null);
    }

    public function upload(data:StbImageData):Void {
        
        __bytesPerPixel = data.comp;

        __width = data.w;

        __height = data.h;

        if (__bytesPerPixel == 4) {

            __transparent = true;
        }

        glTexture = Common.context.generateTexture();

        Common.context.loadTexture(__width, __height, __bytesPerPixel, Uint8Array.fromBytes(Bytes.ofData(data.bytes)));
    }

    /** Getters and setters. **/

    private function get_bytes():BytesData {
        
        return null;
    }

    private function get_bytesPerPixel():Int {

        return __bytesPerPixel;
    }

    private function get_dirty():Bool {
        
        return __dirty;
    }

    private function get_height():Int {
        
        return __height;
    }

    private function get_powerOfTwo():Bool {

        return ((__width != 0)
			&& ((__width & (~__width + 1)) == __width))
			&& ((__height != 0) && ((__height & (~__height + 1)) == __height));
    }

    private function get_transparent():Bool {

        return __transparent;
    }
    
    private function get_width():Int {
        
        return __width;
    }
}