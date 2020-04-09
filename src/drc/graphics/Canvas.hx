package drc.graphics;

import drc.core.Context;
import drc.display.Graphic;
import drc.display.Profile;
import drc.data.Texture;
import drc.utils.Common;

class Canvas extends Graphic
{
	/** Publics. **/

	public var drawCalls:UInt = 0;

	/** Privates. **/

	private var __context:Context;

	public function new(profile:Profile) 
	{
		super(profile);
		
		__context = Common.context;

		textures = new Array<Texture>();

		vertices.upload(
		[
			64, 64, 0, 0, 0,
			64, 480, 0, 0, 1,
			640, 480, 0, 1, 1,
			640, 64, 0, 1, 0
		]);
		
		indices.upload([0, 1, 2, 0, 2, 3]);
		
		__verticesToRender = 4;
		
		__indicesToRender = 6;
	}

	public function setToDraw():Void {
		
		//__context.setRenderToTexture();
	}

	public function present():Void {

	}

	public function draw():Void {
		
	}

	private function drawTriangles():Void {
		
	}
}