package cont.ui;

import drc.display.Text;

class UiLabel extends UiControl
{
	//** Publics.
	
	public var text(get, set):String;
	
	public var onClickHandler:UiControl->Void;
	
	public var onRightClickHandler:UiControl->Void;
	
	//** Privates.
	
	/** @private */ private var __bitmapText:Text;
	
	public function new(text:String, x:Float = 0, y:Float = 0, onLeftClick:UiControl->Void = null, onRightClick:UiControl->Void = null) 
	{
		//** Super.
		
		super(x, y);
		
		//** Create a new bitmap text.
		
		__bitmapText = new Text(null, text);
		
		//** Pass the left click function to it's variable counterpart.
		
		onClickHandler = onLeftClick;
		
		//** Pass the right click function to it's variable counterpart.
		
		onRightClickHandler = onRightClick;
	}
	
	override public function init():Void 
	{
		super.init();
		
		//** Set the layout of the control.
		
		__form = @:privateAccess __parent.__form;
		
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
		
		if (__mask)
		{
			//__bitmapText.setAttribute("maskX", __maskBox.x / 640);
			
			//__bitmapText.setAttribute("maskY", __maskBox.y / 480);
			
			//__bitmapText.setAttribute("maskW", __maskBox.width / 640);
			
			//__bitmapText.setAttribute("maskH", __maskBox.height / 480);
		}
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
		
		//** If collide...
		
		if (collide)
		{
			//** Set the cursor.
			
			__form.cursorId = 4;
			
			//** If left click...
			
			if (__form.leftClick)
			{
				__form.selectedControl = this;
				
				if (onClickHandler == null)
				{
					return;
				}

				onClickHandler(this);
				
				return;
			}
			
			//** If right click...
			
			if (__form.rightClick)
			{
				__form.selectedControl = this;
				
				if (onRightClickHandler == null)
				{
					return;
				}
				
				onRightClickHandler(this);
				
				return;
			}
		}
	}
	
	private function __setBitmapTextX():Void
	{
		__bitmapText.x = __x + __offsetX;
	}
	
	private function __setBitmapTextY():Void
	{
		__bitmapText.y = __y + __offsetY;
	}
	
	//** Getters and setters.
	
	override function get_height():Float 
	{
		return __bitmapText.height;
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

	override function get_width():Float 
	{
		return __bitmapText.width;
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