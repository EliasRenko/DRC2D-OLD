package cont.ui;

import cont.ui.UiControl;

class UiWindow extends UiContainer
{
	//** Publics.
	
	public var header(get, set):String;
	
	//** Privates.
	
	/** @private */ private var __label:UiLabel;
	
	/** @private */ private var __panel:UiPanel;
	
	/** @private */ private var __strip:UiStrip;
	
	public function new(text:String = "", width:Float = 128, height:Float = 128, x:Float = 0, y:Float = 0, scrollable:Bool = false) 
	{
		super(width, height, x, y, false);
		
		__label = new UiLabel(text, 8, 3);
		
		__strip = new UiStrip(width, 0, 0);
		
		__panel = new UiPanel(width, height - 28, 0, 28, scrollable);
	}
	
	override public function init():Void 
	{
		super.init();
		
		@:privateAccess __strip.__parent = this;
		
		__strip.z = 1;
		
		__initMember(__strip);
		
		@:privateAccess __panel.__parent = this;
		
		__panel.z = 1;
		
		__initMember(__panel);
		
		@:privateAccess __label.__parent = this;
		
		__initMember(__label);
		
		//** Set the hitbox.
		
		__setHitbox(0, 0, width, height);
	}
	
	override public function release():Void 
	{
		__label.release();
		
		__strip.release();
		
		__panel.release();
		
		super.release();
	}
	
	override public function addControl(control:UiControl):UiControl 
	{
		return __panel.addControl(control);
	}
	
	override public function removeControl(control:UiControl):Void 
	{
		__panel.removeControl(control);
	}
	
	override public function update():Void 
	{
		super.update();
		
		__strip.update();
		
		__panel.update();
		
		__label.update();
	}
	
	override public function updateCollision():Void 
	{
		super.updateCollision();
		
		if (collide)
		{
			//** Call updateCollision method of the strip.
			
			__strip.updateCollision();
			
			if (__strip.collide)
			{
				//** Call updateCollision method of the label.
				
				__label.updateCollision();
				
				if (__label.collide)
				{
					if (__form.leftClick)
					{
						__panel.visible = __panel.visible == true ? false : true;
					}
				}
			}
			
			//** Call updateCollision method of the strip.
			
			__panel.updateCollision();
		}
	}
	
	//** Getters and setters.
	
	private function get_header():String
	{
		return __label.text;
	}
	
	private function set_header(value:String):String
	{
		return __label.text = value;
	}
	
	override function set_height(value:Float):Float 
	{
		__panel.height = value - 28;
		
		return super.set_height(value);
	}
	
	override function set_visible(value:Bool):Bool 
	{
		__strip.visible = value;
		
		__panel.visible = value;
		
		__label.visible = value;
		
		return super.set_visible(value);
	}
	
	override function set_x(value:Float):Float 
	{
		@:privateAccess __strip.__setOffsetX(value);
		
		@:privateAccess __panel.__setOffsetX(value);
		
		@:privateAccess __label.__setOffsetX(value);
		
		return super.set_x(value);
	}
	
	override function set_y(value:Float):Float 
	{
		@:privateAccess __strip.__setOffsetY(value);
		
		@:privateAccess __panel.__setOffsetY(value);
		
		@:privateAccess __label.__setOffsetY(value);
		
		return super.set_y(value);
	}
	
	override function set_z(value:Float):Float 
	{
		return super.set_z(value);
	}
}