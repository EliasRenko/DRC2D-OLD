package drc.display;

import drc.display.Drawable;
import drc.display.Indices;
import drc.display.Profile;
import drc.data.BitmapData;
import drc.math.Matrix;

class Graphic extends Drawable
{
	//** Publics.
	
	/**
	 * The indices of the graphic.
	 */
	public var indices:Indices = new Indices();
	
	/**
	 * The profile of the graphic.
	 */
	public var profile:Profile;

	public var textures:Array<BitmapData>;

	public var matrix:Matrix = new Matrix();
	
	//** Privates.
	
	//** Methods.
	
	/** @private **/ public var __indicesToRender:UInt = 0;
	
	public function new(profile:Profile) 
	{
		super(0, 0);
		
		this.profile = profile;
	}
}