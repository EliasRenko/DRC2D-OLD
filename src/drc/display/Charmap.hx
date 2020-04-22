package drc.display;

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
	
	// ** Privates.
	
	public function new(profile:Profile, font:Dynamic) 
	{
		var fontData:Dynamic = Json.parse(font);
		
		//var rects:Vector<Rectangle> = new Vector<Rectangle>(255, true);
		
		var regions = new Array<Region>();
		
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
}