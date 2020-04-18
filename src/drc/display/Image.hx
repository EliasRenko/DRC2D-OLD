package drc.display;

import drc.display.Shading;
import drc.display.Drawable;
import drc.data.Profile;
import drc.data.Texture;

class Image extends Drawable {
	
	/** Publics. **/

	public function new(profile:Profile, bitmapData:Texture) {

		super(profile);
		
		bitmaps = new Array<Texture>();

		bitmaps[0] = bitmapData;

		

		vertices.upload(
		[
			64, 64, 0, 0, 0,
			64, 256, 0, 0, 1,
			256, 256, 0, 1, 1,
			256, 64, 0, 1, 0
		]);
		
		indices.upload([0, 1, 2, 0, 2, 3]);
		
		__verticesToRender = 4;
		
		__indicesToRender = 6;
	}

	override function setAttribute(name:String, value:Float) {

		#if debug // ------
		
		if (!shadings.exists(name))
		{
			throw "Attribute: " + name + " does not exist.";
		}
		
		#end // ------
		
		for (i in 0...4) 
		{
			vertices.innerData[shadings[name].positions[i]] = value;
		}
	}
}