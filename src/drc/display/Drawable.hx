package drc.display;

import drc.objects.State;
import drc.display.Graphic;
import drc.data.IndexData;
import drc.data.Profile;
import drc.data.Texture;
import drc.math.Matrix;
import drc.display.Shading;

typedef BlendFactors = 
{
	source:Int,

	destination:Int
}

typedef TextureParameters = 
{
	magnification:Int,

	minification:Int,

	wrapX:Int,

	wrapY:Int
}

class Drawable extends Graphic
{
	//** Publics.
	
	public var blendFactors:BlendFactors;

	/**
	 * The indices of the graphic.
	 */
	public var indices:IndexData = new IndexData();
	
	/**
	 * The profile of the graphic.
	 */
	public var profile:Profile;

	public var textureParams:TextureParameters;

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
	
	/** @private **/ private var __state:State;

	public function new(profile:Profile) {

		super(0, 0);
		
		this.profile = profile;
		
		blendFactors = {

			source: BlendFactor.NONE,

			destination: BlendFactor.NONE
		}

		textureParams = {

			magnification: 0x2600,

			minification: 0x2600,

			wrapX: 0x812F,

			wrapY: 0x812F
		}

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

	public function remove():Void {

		__state.removeGraphic(this);

		super.release();
	}

	public function setUV(x:Float, y:Float, width:Float, height:Float):Void {	

		vertices.innerData[shadings["u"].positions[0]] = x;
		
		vertices.innerData[shadings["u"].positions[1]] = x;
		
		vertices.innerData[shadings["u"].positions[2]] = width;
		
		vertices.innerData[shadings["u"].positions[3]] = width;
		
		vertices.innerData[shadings["v"].positions[0]] = y;
		
		vertices.innerData[shadings["v"].positions[1]] = height;
		
		vertices.innerData[shadings["v"].positions[2]] = height;
		
		vertices.innerData[shadings["v"].positions[3]] = y;
	}

	override function set_x(value:Float):Float {

		return super.set_x(value);
	}

	override function set_y(value:Float):Float {

		return super.set_y(value);
	}
}