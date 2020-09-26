package drc.backend.web.utils;

#if js

import drc.backend.web.utils.HTTPRequest;
import js.html.File;

class Resources {

    public static function loadText(path:String, func:(Int, Dynamic)->Void):Void {

        var __request:HTTPRequest = new HTTPRequest(path, '');

        __request.load(func);
    }

    public static function loadTexture(path:String, func:(Int, Dynamic)->Void):Void {

        var __request:HTTPRequest = new HTTPRequest(path, '');

        __request.load(func);
    }

    public static function loadProfile(path:String, func:(Int, Dynamic)->Void):Void {

        var __request:HTTPRequest = new HTTPRequest(path, '');

        __request.load(func);
    }
}

#end