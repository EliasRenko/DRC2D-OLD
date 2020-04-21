package drc.display;

import drc.data.VertexData;
import drc.part.Object;

class Graphic extends Object {

	/**
	 * The rotation of the graphic.
	 */
	public var angle(get, set):Float; //** Define metadata isVar.

	/**
	 * The x scale of the graphic.
	 */
	public var scaleX(get, set):Float; //** Define metadata isVar.

	/**
	 * The y scale of the graphic.
	 */
	public var scaleY(get, set):Float; //** Define metadata isVar.

	/**
	 * The x offset of the graphic.
	 */
	public var offsetX:Float = 0;

	/**
	 * The y offset of the graphic.
	 */
	public var offsetY:Float = 0;

	/**
	 * The x origin of the graphic.
	 */
	public var originX(get, set):Float;

	/**
	 * The y origin of the graphic.
	 */
	public var originY(get, set):Float;

	/**
	 * The width of the graphic.
	 */
	public var width(get, set):Float;

	/**
	 * The height of the graphic.
	 */
	public var height(get, set):Float;

	/**
	 * The vertices of the graphic.
	 */
	public var vertices:VertexData = new VertexData();

	/**
	 * If the graphic should render.
	 */
	public var visible(get, set):Bool;

	/**
	 * The x position of the graphic in space.
	 */
	public var x(get, set):Float;

	/**
	 * The y position of the graphic in space.
	 */
	public var y(get, set):Float;

	/**
	 * The z position of the graphic in space.
	 */
	public var z(get, set):Float;

	// ** Privates.

	/** @private **/ private var __angle:Float = 0;

	/** @private **/ private var __height:Float = 0;

	/** @private **/ private var __offsetX:Float = 0;

	/** @private **/ private var __offsetY:Float = 0;

	/** @private **/ private var __originX:Float = 0;

	/** @private **/ private var __originY:Float = 0;

	/** @private **/ private var __scaleX:Float = 1;

	/** @private **/ private var __scaleY:Float = 1;

	/** @private **/ public var __verticesToRender:Int = 0;

	/** @private **/ private var __width:Float = 0;

	/** @private **/ private var __visible:Bool = true;

	/** @private **/ private var __x:Float = 0;

	/** @private **/ private var __y:Float = 0;

	/** @private **/ private var __z:Float = 0;

	/** @private **/ public var __isTile:Bool = false;

	public function new(x:Float = 0, y:Float = 0) {

		//** Set x position of the display object.

		__x = x;

		//** Set y position of the display object.

		__y = y;
	}

	public function setAttribute(name:String, value:Float):Void {}

	public function render():Void {}

	private function __add():Void {}

	private function __remove():Void {}

	//** Getters and setters.

	public function get_angle():Float {

		return __angle;
	}

	private function set_angle(value:Float):Float {

		__angle = (value %= 360) >= 0 ? value : (value + 360);
		
		return __angle;
	}

	private function get_height():Float {

		return __height;
	}

	private function set_height(value:Float):Float {

		return __height = value;
	}

	private function get_scaleX():Float {

		return __scaleX;
	}

	private function set_scaleX(value:Float):Float {

		return __scaleX = value > 0 ? value : 0; 
	}

	private function get_scaleY():Float {

		return __scaleY;
	}

	private function set_scaleY(value:Float):Float {

		return __scaleY = value > 0 ? value : 0; 
	}

	private function get_offsetX():Float {

		return __offsetX;
	}

	private function set_offsetX(value:Float):Float {

		return __offsetX = value;
	}

	private function get_offsetY():Float {

		return __offsetY;
	}

	private function set_offsetY(value:Float):Float {

		return __offsetY = value;
	}

	private function get_originX():Float {

		return __originX;
	}

	private function set_originX(value:Float):Float {

		return __originX = value;
	}

	private function get_originY():Float {

		return __originY;
	}

	private function set_originY(value:Float):Float {

		return __originY = value;
	}

	public function get_width():Float {

		return __width;
	}

	private function set_width(value:Float):Float {

		return __width = value;
	}

	private function get_visible():Bool {

		return __visible;
	}

	private function set_visible(value:Bool):Bool {

		__visible = value;

		return __visible;
	}

	private function get_x():Float {

		return __x;
	}

	private function set_x(value:Float):Float {

		__x = value;

		return __x;
	}

	private function get_y():Float {

		return __y;
	}

	private function set_y(value:Float):Float {

		__y = value;

		return __y;
	}

	private function get_z():Float {

		return __z;
	}

	private function set_z(value:Float):Float {
		
		__z = value;

		return __z;
	}
}
