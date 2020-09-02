package cont.ui;

import drc.display.Tile;
import cont.ui.UiEventType;

class UiStamp extends UiControl
{
	// ** Publics.
	
	public var id(get, set):Int;

	// ** Privates.
	
	/** @private **/ private var __graphic:Tile;
	
	/** @private **/ private var __id:Int;
	
	public function new(id:Int = 0, x:Float = 0, y:Float = 0) 
	{
		//** Super.
		
		super(x, y);
		
		//** Pass the x value to it's variable counterpart.
		
		__id = id;
		
		//** Create a new graphic class.
		
		__graphic = new Tile(null, id);

		__type = 'stamp';
	}
	
	override public function init():Void 
	{
		super.init();
		
		//** Set the graphics parent.
		
		__graphic.parentTilemap = @:privateAccess __form.__tilemap;
		
		//** Add the graphic to it's parent.
		
		@:privateAccess __form.__tilemap.addTile(__graphic);
		
		//** Pass the graphics width value to the control.
		
		__width = __graphic.width;
		
		//** Pass the graphics height value to the control.
		
		__height = __graphic.height;
		
		//** Call setGraphicX method.
		
		__setGraphicX();
		
		//** Call setGraphicY method.
		
		__setGraphicY();
		
		//** Set the hitbox.
		
		__setHitbox(0, 0, width, height);

		if (__mask)
		{
			__graphic.setAttribute("mX", __maskBox.x / 640);
			
			__graphic.setAttribute("mY", __maskBox.y / 480);
			
			__graphic.setAttribute("mW", __maskBox.width / 640);
			
			__graphic.setAttribute("mH", __maskBox.height / 480);
		}
	}
	
	override public function release():Void 
	{
		@:privateAccess __form.__tilemap.removeTile(__graphic);
		
		super.release();
	}
	
	private function __setGraphicX():Void
	{
		__graphic.x = __x + __offsetX;
	}
	
	private function __setGraphicY():Void
	{
		__graphic.y = __y + __offsetY;
	}
	
	override public function update():Void 
	{
		super.update();
	}
	
	override public function updateCollision():Void 
	{
		super.updateCollision();

		if (debug) {

			return;
		}

		//** If collide...
		
		if (collide)
		{
			// ** Set the cursor.
			
			if (!hover) {

				__form.hoverControl = this;
			}

			onMouseHover();

			__form.cursorId = 4;

			// ** If right click...
			
			if (__form.leftClick)
			{
				__form.selectedControl = this;

				onEvent.dispatch(this, ON_CLICK);
			}

			if (shouldDebug)
			{
				if (__form.rightClick)
				{
					__form.__setDebugControl(this);
				}
			}

			return;
		}
	}
	
	override function __debugOn() {

		super.__debugOn();

		__graphic.setAttribute('r', 1);

		__graphic.setAttribute('g', 0);

		__graphic.setAttribute('b', 0);
	}

	override function __debugOff() {

		__graphic.setAttribute('r', 1);

		__graphic.setAttribute('g', 1);

		__graphic.setAttribute('b', 1);

		debug = false;

		super.__debugOff();
	}

	override function __setMask(x:Float, y:Float, width:Float, height:Float) {

		super.__setMask(x, y, width, height);

		__graphic.setAttribute("mX", __maskBox.x / 640);
				
		__graphic.setAttribute("mY", __maskBox.y / 480);
		
		__graphic.setAttribute("mW", __maskBox.width / 640);
		
		__graphic.setAttribute("mH", __maskBox.height / 480);
	}

	//** Getters and setters.
	
	private function get_id():Int
	{
		return __id;
	}
	
	private function set_id(value:Int):Int
	{
		__graphic.id = value;
		
		return __id = value;
	}
	
	override function set_height(value:Float):Float {

		super.set_height(value);

		__graphic.height = value;

		return __height;
	}

	override function set_visible(value:Bool):Bool 
	{
		__graphic.visible = value;
		
		return super.set_visible(value);
	}

	override function set_width(value:Float):Float {

		super.set_width(value);

		__graphic.width = value;

		return __width;
	}
	
	override function set_x(value:Float):Float 
	{
		//** Super set_x.
		
		super.set_x(value);
		
		//** Call setGraphicX method.
		
		__setGraphicX();
		
		//** Return.
		
		return value;
	}
	
	override function set_y(value:Float):Float 
	{
		//** Super set_y.
		
		super.set_y(value);
		
		//** Call setGraphicY method.
		
		__setGraphicY();
		
		//** Return.
		
		return value;
	}
	
	override function set_z(value:Float):Float 
	{
		//** Super set_y.
		
		super.set_z(value);
		
		//** Set the z of the graphic.
		
		__graphic.z = __z;
		
		//** Return.
		
		return value;
	}
	
	override function __setOffsetX(value:Float):Void 
	{
		super.__setOffsetX(value);
		
		__setGraphicX();
	}
	
	override function __setOffsetY(value:Float):Void 
	{
		super.__setOffsetY(value);
		
		__setGraphicY();
	}
}