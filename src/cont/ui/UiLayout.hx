package cont.ui;

class UiLayout extends UiControl
{
	public function new(width:Float, height:Float, x:Float = 0, y:Float = 0) 
	{
		//** Super.
		
		super(x, y);
		
		//** Pass the width value to it's variable counterpart.
		
		__width = width;
		
		//** Pass the height value to it's variable counterpart.
		
		__height = height;
	}
	
	override public function init():Void 
	{
		//** Super init.
		
		super.init();
		
		//** Set the hitbox.
		
		__setHitbox(0, 0, width, height);
	}
	
	override public function release():Void 
	{
		//** Super release.
		
		super.release();
	}
	
	override public function update():Void 
	{
		super.update();
	}
	
	private function __initMember(control:UiControl):Void
	{
		@:privateAccess control.__parent = this;
		
		//** Set the offsetX of the control.
		
		@:privateAccess control.__offsetX = __x + __offsetX; //** Define metadata privateAccess.
		
		//** Set the offsetY of the control.
		
		@:privateAccess control.__offsetY = __y + __offsetY; //** Define metadata privateAccess.
		
		//** Assign the default visiblity value to the control.
		
		@:privateAccess control.visible = __visible; //** Define metadata privateAccess.
		
		//** Assign the default z value to the control.
		
		@:privateAccess control.z += __z - 1; //** Define metadata privateAccess.
		
		if (__mask)
		{
			@:privateAccess control.__mask = true;
			
			@:privateAccess control.__maskBox = __maskBox;
		}
		
		//** Call init method.
		
		control.init();
	}
}