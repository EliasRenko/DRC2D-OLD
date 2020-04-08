package drc.graphics;

import drc.display.Graphic;
import drc.display.Profile;
import drc.data.Texture;

class Image extends Graphic
{
	/** Publics. **/

	public var textures:Array<Texture>;

	public function new(profile:Profile) 
	{
		super(profile);
		
		textures = new Array<Texture>();

		vertices.upload(
		[
			64, 64, 0, 1, 1,
			64, 128, 0, 1, 1,
			128, 128, 0, 1, 1,
			128, 64, 0, 1, 1
		]);
		
		indices.upload([0, 1, 2, 0, 2, 3]);
		
		__verticesToRender = 4;
		
		__indicesToRender = 6;
	}
}