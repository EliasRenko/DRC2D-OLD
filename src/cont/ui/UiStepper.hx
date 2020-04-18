package cont.ui;

import cont.ui.UiStamp;
import drc.utils.DrcCommon;

class UiStepper extends UiLayout
{
	//** Publics.
	
	public var maxValue:Float = 100;
	
	public var minValue:Float = 0;
	
	public var onChangeHandler:Float->Void;
	
	public var precision:UInt = 1;
	
	public var step:Float = 1;
	
	public var value(get, set):Float;
	
	//** Privates.
	
	/** @private */ private var __label:UiLabel;
	
	/** @private */ private var __stamp_0:UiStamp;
	
	/** @private */ private var __stamp_1:UiStamp;
	
	/** @private */ private var __value:Float;
	
	public function new(value:Float, x:Float = 0, y:Float = 0, handler:Float->Void = null) 
	{
		super(64, 32, x, y);
		
		__value = value;
		
		__label = new UiLabel("0", 64, 0);
		
		__stamp_0 = new UiStamp(8, 0, 0);
		
		__stamp_1 = new UiStamp(8, 32, 0);
	}
	
	override public function init():Void 
	{
		super.init();
		
		//** Set the layout of the control.
		
		__form = @:privateAccess __parent.__form;
		
		@:privateAccess __label.__parent = this;
		
		__initMember(__label);
		
		@:privateAccess __stamp_0.__parent = this;
		
		__initMember(__stamp_0);
		
		@:privateAccess __stamp_1.__parent = this;
		
		__initMember(__stamp_1);
		
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
			__stamp_0.updateCollision();
			
			if (__stamp_0.collide)
			{
				if (__form.leftClick)
				{
					value += step;
				}
			}
			
			__stamp_1.updateCollision();
			
			if (__stamp_1.collide)
			{
				if (__form.leftClick)
				{
					value += -step;
				}
			}
		}
	}
	
	//** Getters and setters.
	
	private function get_value():Float
	{
		return __value;
	}
	
	private function set_value(value:Float):Float
	{
		__value = DrcCommon.clamp(value, minValue, maxValue);
		
		__label.text = Std.string(__value);
		
		if (onChangeHandler != null)
		{
			onChangeHandler(__value);
		}
		
		return __value;
	}
	
	override function set_visible(value:Bool):Bool 
	{
		__label.visible = value;
		
		__stamp_0.visible = value;
		
		__stamp_1.visible = value;
		
		return super.set_visible(value);
	}
	
	override function set_x(value:Float):Float 
	{
		@:privateAccess __label.__setOffsetX(value + 64);
		
		@:privateAccess __stamp_0.__setOffsetX(value);
		
		@:privateAccess __stamp_1.__setOffsetX(value + 16);
		
		return super.set_x(value);
	}
	
	override function set_y(value:Float):Float 
	{
		@:privateAccess __label.__setOffsetY(value);
		
		@:privateAccess __stamp_0.__setOffsetY(value);
		
		@:privateAccess __stamp_1.__setOffsetY(value);
		
		return super.set_y(value);
	}
	
	override function set_z(value:Float):Float 
	{
		__label.z = value;
		
		__stamp_0.__z = value;
		
		__stamp_1.__z = value;
		
		return super.set_z(value);
	}
}