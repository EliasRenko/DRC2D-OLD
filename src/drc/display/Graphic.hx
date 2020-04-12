package drc.display;

import drc.display.Drawable;
import drc.display.Indices;
import drc.display.Profile;
import drc.data.BitmapData;
import drc.math.Matrix;
import drc.display.Shading;

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

	public var shadings:Map<String, Shading> = new Map<String, Shading>();
	
	//** Privates.
	
	//** Methods.
	
	/** @private **/ public var __indicesToRender:UInt = 0;
	
	public function new(profile:Profile) {

		super(0, 0);
		
		this.profile = profile;

		for (i in 0...profile.attributes.length) {

			for (j in 0...profile.attributes[i].__pointers.length) {

				trace(profile.attributes[i].__pointers[j].name + ' ' + profile.attributes[i].__pointers[j].position);
			}

			//trace(profile.attributes[i].name);
		}
	}
}