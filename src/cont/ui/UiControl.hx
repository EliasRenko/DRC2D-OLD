package cont.ui;

import cont.ui.UiEvent;
import cont.ui.UiEventType;
import drc.math.Rectangle;
import drc.part.Object;

class UiControl extends Object
{
	// ** Publics.
	
	/**
	 * 
	 */
	public var collide(get, null):Bool;

	public var debug:Bool = false;

	public var shouldDebug:Bool = true;

	public var focused(get, null):Bool;

	/**
	 * The height of the control. Cannot be set.
	 */
	public var height(get, set):Float;
	
	public var hover:Bool;

	/**
	 * The type of the control. Cannot be set.
	 */
	public var type(get, null):String;

	/**
	 * If the control is selected.
	 */
	public var selected:Bool = false;
	
	/**
	 * The name of the control.
	 */
	public var name:String;

	/**
	 * The parent class of the control. Cannot be set.
	 */
	public var parent(get, null):UiControl;
	
	public var onEvent:UiEvent;

	/**
	 * If the control should be visible.
	 */
	public var visible(get, set):Bool;
	
	/**
	 * The width of the control.
	 */
	public var width(get, set):Float;
	
	/**
	 * The x position of the control.
	 */
	public var x(get, set):Float;
	
	/**
	 * The y position of the control.
	 */
	public var y(get, set):Float;
	
	/**
	 * The z position of the control.
	 */
	public var z(get, set):Float;
	
	//** Privates. 
	
	/** @private **/ private var __allow:Bool = true;

	/** @private **/ private var __allowDragX:Bool = true;

	/** @private **/ private var __allowDragY:Bool = true;
	
	/** @private **/ private var __collide:Bool;
	
	/** @private **/ private var __focused:Bool = false;

	/** @private **/ private var __height:Float;
	
	/** @private **/ private var __hitbox:Rectangle;

	/** @private **/ private var __hover:Bool = false;
	
	/** @private **/ private var __form:UiForm;
	
	/** @private **/ private var __offsetX:Float = 0;
	
	/** @private **/ private var __offsetY:Float = 0;
	
	/** @private **/ private var __mask:Bool = false;
	
	/** @private **/ private var __maskBox:Rectangle;
	
	/** @private **/ private var __parent:UiLayout;
	
	/** @private **/ private var __type:String;

	/** @private **/ private var __visible:Bool = true;
	
	/** @private **/ private var __x:Float = 0;
	
	/** @private **/ private var __y:Float = 0;
	
	/** @private **/ private var __z:Float = 0;
	
	/** @private **/ private var __width:Float;
	
	public function new(x:Float = 0, y:Float = 0) 
	{		
		//** Pass the x value to it's variable counterpart.
		
		__x = x;
		
		//** Pass the y value to it's variable counterpart.
		
		__y = y;

		// ** Create an event dispacher.

		onEvent = new UiEvent();
	}
	
	override public function init():Void 
	{
		super.init();
		
		// ** Set the parent layout of the control.

		__form = @:privateAccess __parent.__form;
	}
	
	override public function release():Void 
	{
		super.release();
		
		// ** Remove this control from it's parent.

		__parent.removeControl(this);
	}
	
	private function __hitTest():Bool
	{
		if (__visible)
		{
			if (__form.mouseX > __hitbox.x + __x + __offsetX && __form.mouseY > __hitbox.y + __y + __offsetY)
			{
				if (__form.mouseX <= __hitbox.width + __x + __offsetX && __form.mouseY <= __hitbox.height + __y + __offsetY)
				{
					return true;
				}
			}
		}
		
		return false;
	} 

	private function __debugOn():Void {
		
	}

	private function __debugOff():Void {

	}

	private function __setHitbox(x:Float, y:Float, width:Float, height:Float):Void
	{
		__hitbox = new Rectangle(x, y, width, height);
	}
	
	private function __setOffsetX(value:Float):Void
	{
		__offsetX = value;
	}
	
	private function __setOffsetY(value:Float):Void
	{
		__offsetY = value;
	}
	
	private function __setMask(x:Float, y:Float, width:Float, height:Float):Void
	{
		__mask = true;
		
		__maskBox = new Rectangle(x, y, width, height);
	}
	
	public function update():Void
	{
		__collide = false;
		
		__allow = true;
	}
	
	public function updateCollision():Void
	{
		__collide = __hitTest();

		#if debug

		if (shouldDebug) {

			if (debug) {

				if (__form.leftCheck) {

					//x = __form.mouseX;
		
					//y = __form.mouseY;
				}
			}
		}

		#end
	}
	
	public function onFocusGain():Void
	{
		__focused = true;

		onEvent.dispatch(this, ON_FOCUS_GAIN);
	}
	
	public function onFocusLost():Void
	{
		__focused = false;

		onEvent.dispatch(this, ON_FOCUS_LOST);
	}

	public function onMouseHover():Void {

		onEvent.dispatch(this, MOUSE_HOVER);
	}

	public function onMouseEnter():Void {

		onEvent.dispatch(this, MOUSE_ENTER);
	}

	public function onMouseLeave():Void {

		onEvent.dispatch(this, MOUSE_LEAVE);
	}

	public function onResize():Void {
		
		onEvent.dispatch(this, ON_RESIZE);
	}
	
	public function onFormResize():Void {
		
	}

	//** Getters and setters.
	
	private function get_collide():Bool
	{
		return __collide;
	}
	
	private function get_focused():Bool {

		return __focused;
	}

	private function get_height():Float
	{
		return __height;
	}
	
	private function set_height(value:Float):Float
	{
		__hitbox.height = value;
		
		__height = value;

		onResize();

		return __height;
	}

	private function get_hover():Bool
	{
		return __hover;
	}

	private function get_type():String {

		return __type;
	}
	
	private function get_parent():UiControl
	{
		return __parent;
	}
	
	private function get_visible():Bool
	{
		return __visible;
	}
	
	private function set_visible(value:Bool):Bool
	{	
		value ? onEvent.dispatch(this, VISIBLE) : onEvent.dispatch(this, INVISIBLE);

		return __visible = value;
	}
	
	private function get_width():Float
	{
		return __width;
	}
	
	private function set_width(value:Float):Float
	{
		__hitbox.width = value;
		
		__width = value;

		onResize();

		return __width;
	}
	
	private function get_x():Float
	{
		return __x;
	}
	
	private function set_x(value:Float):Float
	{
		return __x = value;
	}
	
	private function get_y():Float
	{
		return __y;
	}
	
	private function set_y(value:Float):Float
	{
		return __y = value;
	}
	
	private function get_z():Float
	{
		return __z;
	}
	
	private function set_z(value:Float):Float
	{
		return __z = value;
	}
}