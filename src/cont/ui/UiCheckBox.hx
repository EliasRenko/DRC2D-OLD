package cont.ui;

import cont.ui.UiLabel;
import cont.ui.UiStamp;

class UiCheckBox extends UiLayout
{
	//** Publics.
	
	public var checked(get, set):Bool;
	
	//** Privates.
	
	/** @private */ private var __checked:Bool = true;
	
	/** @private */ private var __label:UiLabel;
	
	/** @private */ private var __stamp:UiStamp;
	
	public function new(text:String = "", x:Float = 0, y:Float = 0) 
	{
		super(32, 32, x, y);
		
		//__label = new UiLabel(text, 38, 4);
		
		__label = new UiLabel(text, 0, 38, 4);

		__stamp = new UiStamp(9, 0, 0);
	}
	
	override public function init():Void 
	{
		super.init();
		
		super.addControl(__label);

		super.addControl(__stamp);
		
		__setHitbox(0, 0, width, height);
	}
	
	override public function update():Void 
	{
		super.update();
	}
	
	override public function updateCollision():Void 
	{
		super.updateCollision();
		
		if (collide)
		{
			__stamp.updateCollision();
			
			if (__stamp.collide)
			{
				if (__form.leftClick)
				{
					checked = __checked == true ? false : true;
				}
			}
		}
	}
	
	//** Getters and setters.
	
	private function get_checked():Bool
	{
		return __checked;
	}
	
	private function set_checked(value:Bool):Bool
	{
		__stamp.id = value == true ? 9 : 10;
		
		return __checked = value;
	}
	
	override function set_visible(value:Bool):Bool 
	{
		__label.visible = value;
		
		__stamp.visible = value;
		
		return super.set_visible(value);
	}
	
	override function set_x(value:Float):Float 
	{
		@:privateAccess __label.__setOffsetX(value + parent.__offsetX + 38);
		
		@:privateAccess __stamp.__setOffsetX(value);
		
		return super.set_x(value);
	}
	
	override function set_y(value:Float):Float 
	{
		@:privateAccess __label.__setOffsetY(value + parent.__offsetY + 4);
		
		@:privateAccess __stamp.__setOffsetY(value);
		
		return super.set_y(value);
	}
	
	override function set_z(value:Float):Float 
	{
		__label.__z = value;
		
		__stamp.__z = value;
		
		return super.set_z(value);
	}
}