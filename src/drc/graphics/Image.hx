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
			64, 64, 0, 0, 0,
			64, 256, 0, 0, 1,
			256, 256, 0, 1, 1,
			256, 64, 0, 1, 0
		]);
		
		indices.upload([0, 1, 2, 0, 2, 3]);
		
		__verticesToRender = 4;
		
		__indicesToRender = 6;
	}
}