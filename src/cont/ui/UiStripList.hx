package cont.ui;

class UiStripList extends UiContainer
{
	//** Publics.
	
	public var onClickHandler:UiControl->Void;
	
	//** Privates.
	
	/** @private */ private var __lastItem:Float = 4;
	
	/** @private */ private var __panel:UiPanel;
	
	public function new(width:Float = 128, height:Float = 128, x:Float = 0, y:Float = 0, handler:UiControl->Void = null) 
	{
		super(width, height, x, y);
		
		__panel = new UiPanel(width, height, 0, 0);
		
		onClickHandler = handler;
	}
	
	override public function init():Void 
	{
		super.init();
		
		@:privateAccess __panel.__parent = this;
		
		__panel.z = 1;
		
		__initMember(__panel);
		
		//addControl(__panel);
		
		//** Set the hitbox.
		
		__setHitbox(0, 0, width, height);
	}
	
	override public function release():Void 
	{
		super.release();
	}
	
	public function addListItem(control:UiControl, handler:UiControl->Void = null):UiControl
	{
		var item:UiControl = __panel.addControl(new UiListItem(control, 4, __lastItem, handler));
		
		control.x += 2;
		
		__lastItem += item.height;
		
		height = __lastItem + 4;
		
		return control;
	}
	
	override public function removeControl(control:UiControl):Void 
	{
		__panel.removeControl(control);
	}
	
	public function dispose():Void
	{
		__panel.dispose();
		
		__lastItem = 4;
	}
	
	override public function update():Void 
	{
		super.update();
		
		__panel.update();
	}
	
	override public function updateCollision():Void 
	{
		super.updateCollision();
		
		//trace(__collisionIndex);
		
		if (collide)
		{
			//** Call updateCollision method of the panel.
			
			__panel.updateCollision();
			
			//if (__form.rightClick)
			//{
				//if (onClickHandler == null)
				//{
					//return;
				//}
				//
				//onClickHandler(this);
			//}
		}
	}
	
	override public function onFocusGain():Void 
	{
		super.onFocusGain();
		
		trace("GAIN");
	}
	
	override public function onFocusLost():Void 
	{
		super.onFocusLost();
		
		trace("LOST!");
	}
	
	//** Getters and setters.
	
	override function set_height(value:Float):Float 
	{
		__panel.height = value;
		
		return super.set_height(value);
	}
	
	override function set_visible(value:Bool):Bool 
	{
		__panel.visible = value;
		
		return super.set_visible(value);
	}
	
	override function set_width(value:Float):Float 
	{
		__panel.width = value;
		
		return super.set_width(value);
	}
	
	override function set_x(value:Float):Float 
	{
		@:privateAccess __panel.__setOffsetX(value);
		
		return super.set_x(value);
	}
	
	override function set_y(value:Float):Float 
	{
		@:privateAccess __panel.__setOffsetY(value);
		
		return super.set_y(value);
	}
	
	override function set_z(value:Float):Float 
	{
		__panel.z = value;
		
		return super.set_z(value);
	}
}