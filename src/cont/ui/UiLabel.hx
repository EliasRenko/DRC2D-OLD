package cont.ui;

import drc.display.Text;
import cont.ui.UiEventType;

class UiLabel extends UiControl
{
	// ** Publics.
	
	public var fieldWidth(get, set):Float;

	public var heading(get, set):UInt;

	public var text(get, set):String;
	
	public var scale:Int;

	public var size(get, null):UInt;

	public var wordwrap(get, set):Bool;

	// ** Privates.
	
	/** @private **/ private var __bitmapText:Text;

	/** @private **/ private var __scale:Int = 1;
	
	public function new(text:String, heading:UInt = 0, x:Float = 0, y:Float = 0) 
	{
		//** Super.
		
		super(x, y);
		
		//** Create a new bitmap text.
		
		__bitmapText = new Text(null, text, heading);
		
		__type = 'label';
	}
	
	override public function init():Void 
	{
		super.init();
		
		//** Set the parent of the text.
		
		__bitmapText.parent = @:privateAccess __form.__charmap;
		
		//** Set the z of the bitmap text.
		
		__bitmapText.z = __z;
		
		//** Add the graphic to it's parent.
		
		__bitmapText.addToParent();
		
		//** Call setBitmapTextX method.
		
		__setBitmapTextX();
		
		//** Call setBitmapTextY method.
		
		__setBitmapTextY();
		
		//** Set the hitbox.
		
		__setHitbox(0, 0, width, height);
	}
	
	override function release():Void 
	{
		__bitmapText.dispose();
		
		super.release();
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
			//** Set the cursor.
			
			__form.cursorId = 4;
			
			//** If left click...
			
			if (__form.leftClick)
			{
				__form.selectedControl = this;
				
				onEvent.dispatch(this, ON_CLICK);
				
				return;
			}
			
			//** If right click...
			
			if (shouldDebug) {

				if (__form.rightClick)
				{
					//__form.selectedControl = this;
					
					//onEvent.dispatch(this, ON_RIGHT_CLICK);
					
					__form.__setDebugControl(this);

					return;
				}
			}
		}
	}

	override function __debugOn() {

		super.__debugOn();

		__bitmapText.setAttribute('r', 1);

		__bitmapText.setAttribute('g', 0);

		__bitmapText.setAttribute('b', 0);
	}

	override function __debugOff() {

		__bitmapText.setAttribute('r', 1);

		__bitmapText.setAttribute('g', 1);

		__bitmapText.setAttribute('b', 1);

		super.__debugOff();
	}

	private function __setBitmapTextX():Void
	{
		__bitmapText.x = __x + __offsetX;
	}
	
	private function __setBitmapTextY():Void
	{
		__bitmapText.y = __y + __offsetY;
	}

	override function __setMask(x:Float, y:Float, width:Float, height:Float) {

		if (__mask) {

			super.__setMask(x, y, width, height);
 
			__bitmapText.setAttribute("mX", __maskBox.x / 640);
					
			__bitmapText.setAttribute("mY", __maskBox.y / 480);
			
			__bitmapText.setAttribute("mW", __maskBox.width / 640);
			
			__bitmapText.setAttribute("mH", __maskBox.height / 480);

		}
	}

	//** Getters and setters.
	
	public function get_heading():UInt {

		return __bitmapText.heading;
	}

	public function set_heading(value:UInt):UInt {
	
		return __bitmapText.heading = value;
	}

	override function get_height():Float 
	{
		return __bitmapText.height;
	}
	
	public function get_size():UInt {

		return __bitmapText.size;
	}

	public function get_text():String
	{
		return __bitmapText.text;
	}
	
	public function set_text(text:String):String
	{
		//** Set the text value of the bitmap text.
		
		__bitmapText.text = text;
		
		//** Set the hitbox.
		
		__setHitbox(0, 0, width, height);
		
		//** Return.
		
		return text;
	}
	
	override function set_visible(value:Bool):Bool 
	{
		__bitmapText.visible = value;
		
		return super.set_visible(value);
	}
	
	override function set_x(value:Float):Float 
	{
		//** Super set_x.
		
		super.set_x(value);
		
		//** Call setBitmapTextX method.
		
		__setBitmapTextX();
		
		//** Return.
		
		return value;
	}
	
	override function set_y(value:Float):Float 
	{
		//** Super set_y.
		
		super.set_y(value);
		
		//** Call setBitmapTextY method.
		
		__setBitmapTextY();
		
		//** Return.
		
		return value;
	}
	
	override function set_z(value:Float):Float 
	{
		//** Super set_z.
		
		super.set_z(value);
		
		//** Set the z of the bitmap text.
		
		__bitmapText.z = __z;
		
		//** Return.
		
		return value;
	}

	private function get_fieldWidth():Float {
		
		return __bitmapText.fieldWidth;
	}

	private function set_fieldWidth(value:Float):Float {
		
		return __bitmapText.fieldWidth = value;
	}

	override function get_width():Float 
	{
		return __bitmapText.width;
	}

	private function get_wordwrap():Bool {
		
		return __bitmapText.wordwrap;
	}

	private function set_wordwrap(value):Bool {
		
		return __bitmapText.wordwrap = value;
	}
	
	override function __setOffsetX(value:Float):Void 
	{
		super.__setOffsetX(value);
		
		__setBitmapTextX();
	}
	
	override function __setOffsetY(value:Float):Void 
	{
		super.__setOffsetY(value);
		
		__setBitmapTextY();
	}
}