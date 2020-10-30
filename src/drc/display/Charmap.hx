package drc.display;

import haxe.io.UInt8Array;
import haxe.io.Bytes;
import drc.backend.native.data.Texture;
import stb.TrueType;
import haxe.io.Path;
import drc.data.Profile;
import drc.display.Region;
import drc.utils.Resources;
import drc.display.Region;
import haxe.Json;
import Std;

class Charmap extends Tilemap
{
	// ** Publics.

	public var defaultKerning:Int = 1;
	
	public var useKerningPairs:Bool = false;
	
	public var variants:Array<UInt>;

	public var size(get, null):Float;

	// ** Privates.

	private var __ascender:Float;

	private var __descender:Float;

	private var __size:Float = 32;

	public function new(profile:Profile, font:String, ?sizes:Array<UInt>) {

		// ** ---

		var _tileset:Tileset = new Tileset();

		var _extension:String = Path.extension(font);

		var regions = new Array<Region>();

		//var _tileset:Tileset = new Tileset();

		if (sizes == null) {

			sizes = [20];
		}

		variants = sizes;

		if (_extension == 'ttf') {

			var charData:Array<StbPackedChar>;

			var offset:UInt = 0;

			if (stb.TrueType.pack_begin(512, 512, 0, 1) == 0) {

			} 

			for (i in 0...sizes.length) {

				charData = stb.TrueType.pack_font_range(Resources.path() + font, 0, sizes[i], 32, 95);

				offset = (i * 100) + 32;

				for (count in 0...charData.length) {

					var data:Array<Int> = new Array<Int>();
					
					data[0] = charData[count].x0;
					
					data[1] = charData[count].y0;
					
					data[2] = charData[count].x1 - charData[count].x0;
					
					data[3] = (charData[count].y1 - charData[count].y0);
					
					data[4] = Std.int(charData[count].xoff);
					
					data[5] = Std.int(charData[count].yoff) + sizes[i];
					
					data[6] = Std.int(charData[count].xadvance);
				
					var region:Region = {
						
						values: data
					}

					_tileset.regions[offset] = region;

					offset ++;
				}
			}

			var bytes = stb.TrueType.pack_end();

			//regions[32].values[5] -= 10;

			stb.ImageWrite.write_png('test3.png', 512, 512, 1, bytes, 0, bytes.length, 512);

			//var tileset = new Tileset(regions);

			super(profile, [new Texture(UInt8Array.fromBytes(Bytes.ofData(bytes)), 1, 512, 512)], _tileset);

			return;
		}

		// ** ---

		if (_extension == 'json') {

		}

		var data:Dynamic = Resources.loadText(font);

		var fontData:Dynamic = Json.parse(data);
		
		//var rects:Vector<Rectangle> = new Vector<Rectangle>(255, true);
		
		
		
		//kernings = new Array<Region>();
		
		var chars:Dynamic;
		
		if (Reflect.hasField(fontData, "chars"))
		{
			chars = Reflect.field(fontData, "chars");
			
			//var rects:Vector<Rectangle> = new Vector<Rectangle>(255, true);
			
			if (Reflect.hasField(chars, "char"))
			{
				var charData:Dynamic = Reflect.field(chars, "char");

				for (count in 0...charData.length)
				{
					var data:Array<Int> = new Array<Int>();
					
					data[0] = Std.parseInt(charData[count].x);
					
					data[1] = Std.parseInt(charData[count].y);
					
					data[2] = Std.parseInt(charData[count].width);
					
					data[3] = Std.parseInt(charData[count].height);
					
					data[4] = Std.parseInt(charData[count].offsetX);
					
					data[5] = Std.parseInt(charData[count].offsetY);
					
					data[6] = Std.parseInt(charData[count].xadvance);
					
					var region:Region =
					{
						values: data
					}
					
					regions[Std.parseInt(charData[count].id)] = region;
				}
			}
		}
		
		var kerns:Dynamic;
		
		var last:Int = 0;
		
		if (Reflect.hasField(fontData, "kerning"))
		{
			defaultKerning = fontData.kerning;
		}
		
		if (Reflect.hasField(fontData, "kernings"))
		{
			kerns = Reflect.field(fontData, "kernings");
			
			for (count in 0...kerns.length)
			{
				if (kerns[count].EOL == true)
				{
					trace("EOL == TRUE");
					
					continue;
				}
				
				//if (last != kerns[count].kerningA)
				//{
					//kernings[kerns[count].kerningA] = new DrcKerning();
					//
					//last = kerns[count].kerningA;
				//}
				//else 
				//{
					//
				//}
				//
				////trace(last);
				//
				//kernings[kerns[count].kerningA].letters.push(kerns[count].kerningB);
				//
				//kernings[kerns[count].kerningA].values.push(kerns[count].kerningAmount);
			}
		}
		else 
		{
			useKerningPairs = false;
		}
		
		var source:String = "nokiafc22.png";
		
		//if (Reflect.hasField(fontData, "font"))
		//{
			//font = Reflect.field(fontData, "font");
			//
			//source = font.source;
		//}
		
		var tileset = new Tileset(regions);
		
		super(profile, [Resources.loadFont('res/fonts/' + source)], tileset);
	}

	public function importMSDF():Void {
		
		var _tileset:Tileset = new Tileset();

		var __data:Dynamic = Resources.loadText('cache/font.json');

		var __fontData:Dynamic = Json.parse(__data);

		__ascender = __fontData.ascender;

		__descender = __fontData.descender;

		__size = __fontData.size;

		var __charData:Dynamic = __fontData.regions;

		var __offset:Int = 32;

		for (count in 0...__charData.length) {

			var data:Array<Int> = new Array<Int>();
			
			data[0] = 0;
			
			data[1] = 0;
			
			data[2] = 0;
			
			data[3] = 0;
			
			data[4] = 0;
			
			data[5] = 0;
			
			data[6] = 0;

			if (Reflect.hasField(__charData[count], "dimensions")) { // ** atlasBounds

				var atlasBounds:Dynamic = __charData[count].dimensions;

				data[0] = atlasBounds[0];
			
				data[1] = atlasBounds[1];

				data[2] = atlasBounds[2];
			
				data[3] = atlasBounds[3];

				//data[0] = atlasBounds.left;
			
				//data[1] = Std.int(__atlasData.height - atlasBounds.top);

				//data[2] = Std.int(atlasBounds.right - atlasBounds.left);
			
				//data[3] = Std.int(__atlasData.height - atlasBounds.bottom) - data[1];
			}
		
			var region:Region =
			{
				values: data
			}

			_tileset.regions[__offset] = region;

			__offset ++;
		}

		//super(profile, [Resources.loadTexture('cache/font.png')], _tileset);

		textureParams = {

			magnification: 0x2601,

			minification: 0x2601,

			wrapX: 0x812F,

			wrapY: 0x812F
		}

		return;
	}

	// ** Getters and setters.

	private function get_size():Float {

		return __size;
	}
}

private class Font {
	
	// ** Publics.

	public var heading(get, set):Int;

    public var name:String;

    // ** Privates.

	/** @private **/ private var __heading:Int = 0;

    /** @private **/ private var __headings:Array<Int>;

	/** @private **/ private var __tileset:Tileset;

    public function new(name:String) {
		
	}
	
	public function addTileset(size:Int):Void {

	}

	// ** Getters and setters.

	private function get_heading():Int {
		
		return __heading;
	}

	private function set_heading(value:Int):Int {
		
		return __heading = value;
	}
}