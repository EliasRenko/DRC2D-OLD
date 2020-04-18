package cont.ui;

import drc.display.Tile;

class UiListItem extends UiLayout
{
	//** Publics.
	
	public var onLeftClickHandler:UiControl->Void;
	
	public var onRightClickHandler:UiControl->Void;
	
	//** Privates.
	
	/** @private */ private var __control:UiControl;
	
	/** @private */ private var __graphic:Tile;
	
	public function new(control:UiControl, x:Float = 0, y:Float = 0, onLeftClick:UiControl->Void = null, onRightClick:UiControl->Void = null) 
	{
		super(0, 24, x, y);
		
		__control = control;
		
		//** Create a new graphic class.
		
		__graphic = new Tile(null, 11);
		
		//** Pass the left click function to it's variable counterpart.
		
		onLeftClickHandler = onLeftClick;
		
		//** Pass the right click function to it's variable counterpart.
		
		onRightClickHandler = onRightClick;
	}
	
	override public function init():Void 
	{
		super.init();
		
		@:privateAccess __control.__parent = this;
		
		__initMember(__control);
		
		__width = __parent.width - 8;
		
		if (__control.height > 16)
		{
			__height = __control.height + 8;
			
			__control.y = 4;
		}
		
		//** Set the graphics parent.
		
		__graphic.parentTilemap = @:privateAccess __form.__tilemap;
		
		//** Add the graphic to it's parent.
		
		@:privateAccess __form.__tilemap.addTile(__graphic);
		
		//** Pass the items width value to the graphic.
		
		__graphic.width = __width;
		
		//** Pass the items height value to the graphic.
		
		__graphic.height = __height;
		
		//** Pass the items visibility value to the graphic.
		
		__graphic.visible = false;
		
		__graphic.z = __parent.z - 1;
		
		//** Call setGraphicX method.
		
		__setGraphicX();
		
		//** Call setGraphicY method.
		
		__setGraphicY();
		
		//** Set the hitbox.
		
		__setHitbox(0, 0, width, height);
		
		if (__mask)
		{
			__graphic.setAttribute("maskX", __maskBox.x / 640);
			
			__graphic.setAttribute("maskY", __maskBox.y / 480);
			
			__graphic.setAttribute("maskW", __maskBox.width / 640);
			
			__graphic.setAttribute("maskH", __maskBox.height / 480);
		}
	}
	
	override function release():Void 
	{
		@:privateAccess __form.__tilemap.removeTile(__graphic);
		
		__control.release();
		
		super.release();
	}
	
	private function __setGraphicX():Void
	{
		__graphic.x = __x + __offsetX;
	}
	
	private function __setGraphicY():Void
	{
		__graphic.y = __y + __offsetY;
	}
	
	override public function update():Void 
	{
		super.update();
		
		__graphic.visible = false;
	}
	
	override public function updateCollision():Void 
	{
		super.updateCollision();
		
		//** If collide...
		
		if (collide)
		{
			__graphic.visible = true;
			
			//** Set the cursor.
			
			__form.cursorId = 4;
			
			__control.updateCollision();
			
			//** If left click...
			
			if (__form.leftClick)
			{
				__form.selectedControl = this;
				
				if (onLeftClickHandler == null)
				{
					return;
				}
				
				onLeftClickHandler(__control);
				
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
				
				onRightClickHandler(__control);
				
				return;
			}
		}
	}
	
	//** Getters and setters.
	
	override function set_visible(value:Bool):Bool 
	{
		__control.visible = value;
		
		return super.set_visible(value);
	}
	
	override function set_x(value:Float):Float 
	{
		super.set_x(value);
		
		@:privateAccess __control.__setOffsetX(value + __offsetX);
		
		//** Call setGraphicX method.
		
		__setGraphicX();
		
		return value;
	}
	
	override function set_y(value:Float):Float 
	{
		super.set_y(value);
		
		@:privateAccess __control.__setOffsetY(value + __offsetY);
		
		//** Call setGraphicY method.
		
		__setGraphicY();
		
		return value;
	}
	
	override function set_z(value:Float):Float 
	{
		return super.set_z(value);
	}
	
	override function __setOffsetX(value:Float):Void 
	{
		super.__setOffsetX(value);
		
		__setGraphicX();
		
		@:privateAccess __control.__setOffsetX(__x + value);
	}
	
	override function __setOffsetY(value:Float):Void 
	{
		super.__setOffsetY(value);
		
		__setGraphicY();
		
		@:privateAccess __control.__setOffsetY(__y + value);
	}
}