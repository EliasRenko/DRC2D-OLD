package cont.ui;

class UiContainer extends UiLayout
{
	//** Publics.
	
	public var childrenCount(get, null):Int = 0;
	
	//** Privates.
	
	/** @private */ private var __scrollValue:Float = 0;
	
	public function new(width:Float, height:Float, x:Float = 0, y:Float = 0, scrollable:Bool = false) 
	{
		//** Super.
		
		super(width, height, x, y);
	}
	
	override public function init():Void 
	{
		super.init();
	}
	
	override public function addControl(control:UiControl):UiControl
	{
		return super.addControl(control);
	}
	
	override public function removeControl(control:UiControl):Void
	{
		super.removeControl(control);
	}
	
	override public function release():Void 
	{
		// for (i in 0...__children.count) 
		// {
		// 	__children.__controls[i].release();
		// }
		
		super.release();
	}
	
	override public function update():Void 
	{
		super.update();
		
		//** Set collision index to null.
		
		__collisionIndex = -1;
		
		//** For every control...
	}
	
	override public function updateCollision():Void 
	{
		super.updateCollision();
		
		//** If collide...
		
		if (collide)
		{
			// if (__scrollable)
			// {
			// 	__scrollBar.updateCollision();
				
			// 	if (__scrollBar.collide)
			// 	{
			// 		if (__scrollBar.scrollUp)
			// 		{
			// 			__scrollValue -= 24;
						
			// 			for (i in 0...__controls.count)
			// 			{
			// 				//@:privateAccess __children.__controls[i].y -= 12;
							
			// 				@:privateAccess __controls.members[i].__setOffsetY(y + __offsetY + __scrollValue);
			// 			}
						
			// 			return;
			// 		}
					
			// 		if (__scrollBar.scrollDown)
			// 		{
			// 			__scrollValue += 24;
						
			// 			for (i in 0...__controls.count)
			// 			{
			// 				//@:privateAccess __children.__controls[i].__setOffsetX(x + __offsetX + __scrollValue);
							
			// 				@:privateAccess __controls.members[i].__setOffsetY(y + __offsetY + __scrollValue);
							
			// 				//__children.__controls[i].y += 10;
			// 			}
						
			// 			return;
			// 		}
					
			// 		return;
			// 	}
			// }
		}
	}
	
	public function setSelection(control:UiControl):Void 
	{
		
	}
	
	override function __setMask(x:Float, y:Float, width:Float, height:Float):Void 
	{
		super.__setMask(x, y, width, height);
	}
	
	// ** Getters and setters.
	
	private function get_childrenCount():Int
	{
		return __controls.count;
	}
	
	override function set_visible(value:Bool):Bool 
	{	
		return super.set_visible(value);
	}
	
	override function set_x(value:Float):Float 
	{
		//** Return.
		
		return super.set_x(value);
	}
	
	override function set_y(value:Float):Float 
	{
		//** Return.
		
		return super.set_y(value);
	}
	
	override function set_z(value:Float):Float 
	{
		//** For each child...
		
		for (i in 0...__controls.count)
		{
			//** Set the offsetX of the member.
			
			__controls.members[i].z = value;
		}
		
		//** Return.
		
		return super.set_z(value);
	}
	
	override function __setOffsetX(value:Float):Void 
	{
		super.__setOffsetX(value);
	}
	
	override function __setOffsetY(value:Float):Void 
	{
		super.__setOffsetY(value);
	}
}