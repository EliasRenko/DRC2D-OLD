package drc.display;

import drc.display.Graphic;
import drc.data.IndexData;
import drc.data.Profile;
import drc.data.Texture;
import drc.math.Matrix;
import drc.display.Shading;

class Drawable extends Graphic
{
	//** Publics.
	
	/**
	 * The indices of the graphic.
	 */
	public var indices:IndexData = new IndexData();
	
	/**
	 * The profile of the graphic.
	 */
	public var profile:Profile;

	/**
	 * The textures of the graphic.
	 */
	public var textures:Array<Texture> = new Array<Texture>();

	/**
	 * The matrix of the graphic.
	 */
	public var matrix:Matrix = new Matrix();

	/**
	 * The shadings ofthe graphic.
	 */
	public var shadings:Map<String, Shading> = new Map<String, Shading>();
	
	// ** Privates.
	
	// ** Methods.
	
	/** @private **/ public var __indicesToRender:UInt = 0;
	
	public function new(profile:Profile) {

		super(0, 0);
		
		this.profile = profile;
		
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
	}
}