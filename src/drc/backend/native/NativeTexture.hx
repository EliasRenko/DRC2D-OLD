package drc.backend.native;

import haxe.io.BytesData;
import stb.Image;

class NativeTexture implements drc.data.Texture {

    /** Publics. **/

    public var bytes(get, null):BytesData;

    public var height(get, null):Int;

    public var width(get, null):Int;

    /** Privates. **/

    /** @private **/ private var innerData:StbImageData;

    public function new(data:StbImageData) {
        
        innerData = data;
    }

    /** Getters and setters. **/

    private function get_bytes():BytesData {
        
        return innerData.bytes;
    }

    private function get_height():Int {
        
        return innerData.h;
    }

    private function get_width():Int {
        
        return innerData.w;
    }
}