package drc.graphics;

import drc.display.Shading;
import drc.display.Graphic;
import drc.display.Profile;
import drc.data.BitmapData;

class Image extends Graphic {
	
	/** Publics. **/

	public function new(profile:Profile, bitmapData:BitmapData) {

		super(profile);
		
		textures = new Array<BitmapData>();

		textures[0] = bitmapData;

		for (i in 0...profile.attributes.length) {

			for (j in 0...profile.attributes[i].__pointers.length) {

				var _name:String = profile.attributes[i].__pointers[j].name;

				var _pos:Int = profile.attributes[i].__pointers[j].position;

				var _positions:Array<Int> = new Array<Int>();

				var sum:Int = _pos;

				for (i in 0...4) {

					_positions.push(sum);

					sum += profile.dataPerVertex;
				}

				var shading:Shading =
				{
					positions: _positions
				}

				shadings.set(_name, shading);
			}
		}

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