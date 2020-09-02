package cont;

import haxe.io.BytesOutput;
import stb.ImageWrite;
import drc.buffers.Uint8Array;
import haxe.io.BytesData;
import haxe.io.Bytes;
import sys.io.File;
import sys.FileSystem;
import drc.utils.Color;
import drc.utils.Resources;
import drc.data.Profile;
import drc.display.Image;
import drc.display.Text;
import drc.display.Charmap;
import drc.objects.State;
import drc.data.Texture;
import drc.utils.BinPacker;
import StringTools;
import format.png.Reader;
import format.png.Writer;
import format.png.Data;
import format.png.Tools;
import haxe.io.Input;

class TestText extends State {

    private var __charmap:Charmap;

    private var __text:Text;

    private var __image:Image;

    public function new() {

        super();

        var path = Resources.path();

        //var args = ['msdf' + '-font', path + 'dep/msdfgen/nokiafc22.ttf', '65', '-o', 'msdf.png', '-size', '32', '32', '-pxrange', '4', '-autoframe', '-testrender', 'render.png', '1024', '1024'];

        var chars:String = '!\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\\\\\\\]^_`abcdefghijklmnopqrstuvwxyz{|}~';

        for (i in 0...chars.length) {

            //var _char:String = chars.charAt(i);

            var code = Std.string(StringTools.fastCodeAt(chars, i));
            
            var args = ['-font', path + 'dep/msdfgen/nokiafc22.ttf', code, '-o', path + 'cache/' + code + '.png', '-size', '32', '32', '-pxrange', '4', '-autoframe'];

            //Sys.command(path + 'dep/msdfgen/msdfgen.exe', args);
        }

        //var args = ['-font', path + 'dep/msdfgen/nokiafc22.ttf', '65', '-o', path + 'cache/msdf.png', '-size', '32', '32', '-pxrange', '4', '-autoframe'];

        //var res = Sys.command(path + 'dep/msdfgen/msdfgen.exe', args);

        var _files:Array<String> = FileSystem.readDirectory(path + 'cache/');

        //var _letter = Resources.loadTexture(path + 'cache/' + _files[0]);

        //var header = format.png.Tools.getHeader(_data);

        //var d:Array<cpp.UInt8> = _bytes;

        var packer:BinPacker = new BinPacker(256, 256);

        //packer.insert(64, 64, true, BestAreaFit, ShorterLeftoverAxis);

        var _prof = Resources.getProfile("res/profiles/texture.json");

        var _texture:Texture = Resources.loadTexture("res/graphics/grid_bw.png");

        var colors = [0xFFFF00FF, 0xFF0000FF, 0xFF8B4513, 0xFF00FFFF, 0xFF008000, 0xFF00FF00, 0xFFFF00FF, 0xFFFFA500];

        for (i in 0...packer.usedRectangles.length) {

            //var rect:Rect = packer.usedRectangles[i];

            //var color:drc.utils.Color = new drc.utils.Color(colors[i]);

            //color.b += i;

            //_texture.draw(Std.int(rect.x), Std.int(rect.y), Std.int(rect.width), Std.int(rect.height), color);
        }

        for (i in 0...1) {

            var io = File.read(path + 'cache/' + _files[i], true);

            var _data:Data = new Reader(io).read();

            var _header = format.png.Tools.getHeader(_data);

            //var _bytes = rgbaToBgra(format.png.Tools.extract32(_data));

            //var _letter:Texture = new drc.backend.native.data.Texture(Uint8Array.fromBytes(_bytes));

            var rect:Rect = packer.insert(_header.width, _header.width, true, BestAreaFit, ShorterLeftoverAxis);

            //var v = Std.int(rect.x); // ** CANT MOD / DIVIDE BY 0.

            //_texture.copyPixels(_letter, 0, 0, 32, 32, 0, 0);
        }

        //var _texture_dirty:Texture = Resources.loadTexture("res/graphics/collider.png");
        
        //_texture.copyPixels(_texture_dirty, 0, 0, 128, 128);

        //_texture.draw(32, 64, 64, 128, new Color(0x2acc1e));


        __image = new Image(_prof, [_texture]);

        addGraphic(__image);

        var outputBytes = _texture.bytes.getData().bytes;

        //Tools.reverseBytes(outputBytes);

        var outputData = Tools.build32BGRA(256, 256, rgbaToBgra(outputBytes));

        var out = sys.io.File.write(path + "test32.png", true);

        new format.png.Writer(out).write(outputData);
        
        //var bytes = new haxe.io.BytesOutput();

        //bytes.write(_texture.bytes.toBytes());

        //ImageWrite.write_png("testSTB.png", 256, 256, 4, bytes.getBytes().getData(), 0, _texture.bytes.length, 256 * 4);
    }

    private function brgaToRgba(bytes:Bytes):Bytes {
		//Sure.sure(bytes != null);
		//Sure.sure(bytes.length % 4 == 0);

		var length:Int = bytes.length;
		var i:Int = 0;
		while (i < length) {
			var b = bytes.get(i);
			var r = bytes.get(i + 1);
			var g = bytes.get(i + 2);
			var a = bytes.get(i + 3);
			bytes.set(i, r);
			bytes.set(i + 1, g);
			bytes.set(i + 2, b);
			bytes.set(i + 3, a);
			i += 4;
		}
		return bytes;
    }
    
    private inline function rgbaToBgra(bytes:Bytes):Bytes {
		//Sure.sure(bytes != null);
		//Sure.sure(bytes.length % 4 == 0);

		var length:Int = bytes.length;
		var i:Int = 0;
		while (i < length) {
			var r = bytes.get(i);
			var g = bytes.get(i + 1);
			var b = bytes.get(i + 2);
			var a = bytes.get(i + 3);
			bytes.set(i, b);
			bytes.set(i + 1, g);
			bytes.set(i + 2, r);
			bytes.set(i + 3, a);
			i += 4;
		}
		return bytes;
	}
}

private class __Charmap {

    public function new(profile:Profile, font:String) {

    }
}