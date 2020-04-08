package drc.data;

import haxe.io.BytesData;

interface Texture {

    /** Publics. **/

    public var bytes(get, null):BytesData;

    public var height(get, null):Int;

    public var width(get, null):Int;

    /** Getters and setters. **/

    private function get_bytes():BytesData;

    private function get_height():Int;

    private function get_width():Int;
}