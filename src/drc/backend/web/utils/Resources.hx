package drc.backend.web.utils;

//import js.lib.Uint8Array;
//import haxe.io.UInt8Array;
#if js

import drc.backend.web.utils.HTTPRequest;
import js.html.File;
import drc.core.Buffers;
import drc.core.Promise;
import js.html.XMLHttpRequestResponseType;
import haxe.io.Bytes;
import haxe.io.BytesInput;
import drc.format.PNG;
import haxe.io.Input;
import drc.data.Texture;

class Resources {

    public static function getDirectory():String {
        
        return '';
    }

    public static function loadBytes(path:String, func:(Int, Dynamic)->Void):Void {
        
    }

    public static function loadText(path:String, func:(Int, Dynamic)->Void):Void {

        var __request:HTTPRequest = new HTTPRequest(path, '');

        __request.load(func, XMLHttpRequestResponseType.TEXT);
    }

    public static function loadTexture(path:String, func:(Int, Dynamic)->Void):Void {

        var __request:HTTPRequest = new HTTPRequest(path, '');

        //__request.load(func, XMLHttpRequestResponseType.ARRAYBUFFER);

        __request.load(function(status, response) {

            //var d:haxe.io.Bytes = Bytes.ofData(response);

            var a:haxe.io.UInt8Array = new haxe.io.UInt8Array(response);

            

            //var b:Bytes = response;

            var i:Input = new BytesInput(a.view.buffer);

            var png:PNG = new PNG(i);

            var _bytes:Bytes = png.extract();

            var header = PNG.getHeader(png.data);
        
            var _texture:Texture = new drc.backend.native.data.Texture(UInt8Array.fromBytes(_bytes), 4, header.width, header.height);

            func(status, _texture);

        }, XMLHttpRequestResponseType.ARRAYBUFFER);
    }

    public static function loadProfile(path:String, func:(Int, Dynamic)->Void):Void {

        var __request:HTTPRequest = new HTTPRequest(path, '');

        __request.load(func, XMLHttpRequestResponseType.TEXT);
    }
}

#end