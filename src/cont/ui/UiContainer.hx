package cont.ui;

import drc.part.Group;

class UiContainer extends UiLayout
{
	//** Publics.
	
	public var childrenCount(get, null):Int = 0;
	
	//** Privates.
	
	/** @private */ private var __children:Group<UiControl> = new Group<UiControl>();
	
	/** @private */ private var __collisionIndex:Int = 0;
	
	/** @private */ private var __scrollable:Bool = false;
	
	/** @private */ private var __scrollBar:UiScrollBar;
	
	/** @private */ private var __scrollValue:Float = 0;
	
	public function new(width:Float, height:Float, x:Float = 0, y:Float = 0, scrollable:Bool = false) 
	{
		//** Super.
		
		super(width, height, x, y);
		
		if (scrollable)
		{
			__scrollable = true;
			
			__scrollBar = new UiScrollBar(0, width - 28, 0);
		}
	}
	
	override public function init():Void 
	{
		super.init();
		
		if (__scrollable)
		{
			__scrollBar.z = -1;
			
			__initMember(__scrollBar);
		}
		
		//** For each child...
		
		for (i in 0...__children.count)
		{
			//** Call the initChild method.
			
			__initMember(__children.members[i]);
		}
	}
	
	public function addControl(control:UiControl):UiControl
	{
		//** Assign this as a parent to the control.
		
		@:privateAccess control.__parent = this; //** Define metadata privateAccess.
		
		//** If this is active...
		
		if (__form != null)
		{
			//** Call init method.
			
			__initMember(control);
		}
		
		//** Return.
		
		return __children.add(control);
	}
	
	public function removeControl(control:UiControl):Void
	{
		__children.remove(control);
	}
	
	override public function release():Void 
	{
		for (i in 0...__children.count) 
		{
			__children.members[i].release();
		}
		
		if (__scrollable)
		{
			__scrollBar.release();
		}
		
		super.release();
	}
	
	override public function update():Void 
	{
		super.update();
		
		//** Set collision index to null.
		
		//__collisionIndex = null;
		
		//** For every control...
		
		if (__scrollable)
		{
			__scrollBar.update();
		}
		
		for (i in 0...__children.count)
		{
			if (__children.members[i] == null)
			{
				continue;
			}
			
			__children.members[i].update();
		}
	}
	
	override public function updateCollision():Void 
	{
		super.updateCollision();
		
		//** If collide...
		
		if (collide)
		{
			if (__scrollable)
			{
				__scrollBar.updateCollision();
				
				if (__scrollBar.collide)
				{
					if (__scrollBar.scrollUp)
					{
						__scrollValue -= 24;
						
						for (i in 0...__children.count)
						{
							//@:privateAccess __children.members[i].y -= 12;
							
							@:privateAccess __children.members[i].__setOffsetY(y + __offsetY + __scrollValue);
						}
						
						return;
					}
					
					if (__scrollBar.scrollDown)
					{
						__scrollValue += 24;
						
						for (i in 0...__children.count)
						{
							//@:privateAccess __children.members[i].__setOffsetX(x + __offsetX + __scrollValue);
							
							@:privateAccess __children.members[i].__setOffsetY(y + __offsetY + __scrollValue);
							
							//__children.members[i].y += 10;
						}
						
						return;
					}
					
					return;
				}
			}
			
			//** For every control...
			
			for (i in 0...__children.count)
			{
				__children.members[i].updateCollision();
				
				if (__children.members[i] == null)
				{
					continue;
				}
				
				if (__children.members[i].collide)
				{
					__collisionIndex = i;
					
					//__form.selectedControl = __children.members[i];
					
					return;
				}
			}
			
			//** If right click...
			
			if (__allow)
			{
				if (__form.leftClick)
				{
					__form.selectedControl = this;
				}
			}
		}
	}
	
	public function setSelection(control:UiControl):Void 
	{
		
	}
	
	override function __setMask(x:Float, y:Float, width:Float, height:Float):Void 
	{
		super.__setMask(x, y, width, height);
	}
	
	//** Getters and setters.
	
	private function get_childrenCount():Int
	{
		return __children.count;
	}
	
	override function set_visible(value:Bool):Bool 
	{
		if (__scrollable)
		{
			__scrollBar.visible = value;
		}
		
		for (i in 0...__children.count)
		{
			//** Set the offsetX of the member.
			
			@:privateAccess __children.members[i].visible = value;
		}
		
		return super.set_visible(value);
	}
	
	override function set_x(value:Float):Float 
	{
		//** For each child...
		
		for (i in 0...__children.count)
		{
			//** Set the offsetX of the member.
			
			@:privateAccess __children.members[i].__setOffsetX(value + __offsetX);
		}
		
		if (__scrollable)
		{
			@:privateAccess __scrollBar.__setOffsetY(value + __offsetX);
		}
		
		//** Return.
		
		return super.set_x(value);
	}
	
	override function set_y(value:Float):Float 
	{
		//** For each child...
		
		for (i in 0...__children.count)
		{
			//** Set the offsetY of the member.
			
			@:privateAccess __children.members[i].__setOffsetY(value + __offsetY + __scrollValue);
		}
		
		if (__scrollable)
		{
			@:privateAccess __scrollBar.__setOffsetY(value + __offsetY);
		}
		
		//** Return.
		
		return super.set_y(value);
	}
	
	override function set_z(value:Float):Float 
	{
		//** For each child...
		
		for (i in 0...__children.count)
		{
			//** Set the offsetX of the member.
			
			__children.members[i].z = value;
		}
		
		//** Return.
		
		return super.set_z(value);
	}
	
	override function __setOffsetX(value:Float):Void 
	{
		super.__setOffsetX(value);
		
		for (i in 0...__children.count)
		{
			@:privateAccess __children.members[i].__setOffsetX(x + value);
		}
		
		if (__scrollable)
		{
			@:privateAccess __scrollBar.__setOffsetX(x + value);
		}
	}
	
	override function __setOffsetY(value:Float):Void 
	{
		super.__setOffsetY(value);
		
		for (i in 0...__children.count)
		{
			@:privateAccess __children.members[i].__setOffsetY(y + value);
		}
		
		if (__scrollable)
		{
			@:privateAccess __scrollBar.__setOffsetY(y + value);
		}
	}
}