package cont.ui;
import drc.utils.DrcColor;

class UiColorPicker extends UiLayout
{
	//** Publics.
	
	public var color:Int;
	
	//** Privates.
	
	/** @private */ private var __color:DrcColor;
	
	/** @private */ private var __stamp:UiStamp;
	
	/** @private */ private var __textfield:UiTextField;
	
	/** @private */ private var __value:String;
	
	public function new(value:String = "", x:Float = 0, y:Float = 0)
	{
		//** Super.
		
		super(48, 48, x, y);
		
		__color = new DrcColor(Std.parseInt("0x" + value));
		
		__value = value;
		
		//** Create a new stamp.
		
		__stamp = new UiStamp(8, 48, 0);
		
		//** Create a new label.
		
		__textfield = new UiTextField(value, 0, 0, __onTextChange);
	}
	
	override public function init():Void 
	{
		super.init();
		
		//** Set the layout of the control.
		
		__form = @:privateAccess __parent.__form;
		
		//** Set the parent of the label.
		
		@:privateAccess __textfield.__parent = this;
		
		//** Call the initMember method.
		
		__initMember(__textfield);
		
		//** Set the parent of the label.
		
		@:privateAccess __stamp.__parent = this;
		
		//** Call the initMember method.
		
		__initMember(__stamp);
		
		//** Set the hitbox.
		
		__setHitbox(0, 0, width, height);
		
		@:privateAccess __stamp.__graphic.setAttribute("r", __color.getRedFloat());
		
		@:privateAccess __stamp.__graphic.setAttribute("g", __color.getGreenFloat());
		
		@:privateAccess __stamp.__graphic.setAttribute("b", __color.getBlueFloat());
	}
	
	override function release():Void 
	{
		super.release();
	}
	
	override public function update():Void 
	{
		super.update();
		
		__textfield.update();
		
		__stamp.update();
	}
	
	override public function updateCollision():Void 
	{
		super.updateCollision();
		
		if (collide)
		{
			__textfield.updateCollision();
			
			__stamp.updateCollision();
		}
	}
	
	private function __onTextChange(text:String):Void
	{
		if (text.length > 0)
		{
			//trace(text);
			
			__color.value = Std.parseInt("0x" + text);
			
			@:privateAccess __stamp.__graphic.setAttribute("r", __color.getRedFloat());
			
			@:privateAccess __stamp.__graphic.setAttribute("g", __color.getGreenFloat());
			
			@:privateAccess __stamp.__graphic.setAttribute("b", __color.getBlueFloat());
		}
	}
}