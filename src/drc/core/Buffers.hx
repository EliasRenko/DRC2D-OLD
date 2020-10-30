package drc.core;

#if js

    //typedef ArrayBuffer = js.lib.ArrayBuffer;
    //typedef ArrayBufferView = js.lib.ArrayBufferView;
    //typedef Float32Array  = js.lib.Float32Array;
    //typedef Int32Array  = js.lib.Int32Array;
    //typedef UInt8Array = js.lib.Uint8Array;

    typedef ArrayBuffer = haxe.io.BytesData;
    typedef ArrayBufferView = haxe.io.ArrayBufferView;
    typedef Float32Array = haxe.io.Float32Array;
    typedef Int32Array = haxe.io.Int32Array;
    typedef UInt8Array = haxe.io.UInt8Array;

#else

    typedef ArrayBuffer = haxe.io.BytesData;
    typedef ArrayBufferView = haxe.io.ArrayBufferView;
    typedef Float32Array = haxe.io.Float32Array;
    typedef Int32Array = haxe.io.Int32Array;
    typedef UInt8Array = haxe.io.UInt8Array;

#end