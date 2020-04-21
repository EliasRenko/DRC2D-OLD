package cont.ui;

import drc.graphics.DrcTile;
import drc.part.Group;

class UiButton extends UiLayout
{
	//** Publics.
	
	public var onClickHandler:UiControl->Void;
	
	//** Privates.
	
	/** @private */ private var __graphics:Group<DrcTile>;
	
	/** @private */ private var __label:UiLabel;
	
	public function new(text:String, width:Float, x:Float = 0, y:Float = 0, handler:UiControl->Void = null) 
	{
		//** Super.
		
		super(width, 28, x, y);
		
		__graphics = new Group<DrcTile>(3);
		
		__graphics.addAt(0, new DrcTile(null, UiForm.GRAPHIC_BUTTON_0_ID));
		
		__graphics.addAt(1, new DrcTile(null, UiForm.GRAPHIC_BUTTON_1_ID));
		
		__graphics.addAt(2, new DrcTile(null, UiForm.GRAPHIC_BUTTON_2_ID));
		
		//** Create a new label class.
		
		__label = new UiLabel(text, 0, 3);
		
		onClickHandler = handler;
	}
	
	override public function init():Void 
	{
		super.init();
		
		__initMember(__label);
		
		//__graphic.parentTilemap = @:privateAccess __form.__tilemap;
		//
		////** Add the graphic to it's parent.
		//
		//@:privateAccess __form.__tilemap.addTile(__graphic);
		//
		////** Pass the items width value to the graphic.
		//
		//__graphic.width = __width;
		//
		////** Pass the items height value to the graphic.
		//
		//__graphic.height = __height;
		//
		////** Pass the items visibility value to the graphic.
		//
		//__graphic.visible = visible;
		//
		//__graphic.z = __parent.z - 1;
		
		for (i in 0...__graphics.count) 
		{
			__graphics.members[i].parentTilemap = @:privateAccess __form.__tilemap;
			
			@:privateAccess __form.__tilemap.addTile(__graphics.members[i]);
			
			__graphics.members[i].visible = visible;
			
			__graphics.members[i].z = __parent.z - 1;
		}
		
		__graphics.members[1].offsetX = 6;
		
		__graphics.members[2].offsetX = 22;
		
		__setWidth();
		
		//** Call setGraphicX method.
		
		__setGraphicX();
		
		//** Call setGraphicY method.
		
		__setGraphicY();
		
		__label.z = z - 3;
		
		__setHitbox(0, 0, width, height);
	}
	
	override public function release():Void 
	{
		for (i in 0...__graphics.count) 
		{
			@:privateAccess __form.__tilemap.removeTile(__graphics.members[i]);
		}
		
		__label.release();
		
		super.release();
	}
	
	private function __setWidth():Void
	{
		__graphics.members[1].width = __width - 12;
		
		__graphics.members[2].offsetX = __width - 6;
		
		__label.x = (width / 2) - (__label.width / 2);
	}
	
	private function __setGraphicX():Void
	{
		for (i in 0...__graphics.count) 
		{
			__graphics.members[i].x = __x + __offsetX;
		}
	}
	
	private function __setGraphicY():Void
	{
		for (i in 0...__graphics.count) 
		{
			__graphics.members[i].y = __y + __offsetY;
		}
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
			
			//** If right click...
			
			if (__form.leftClick)
			{
				__form.selectedControl = this;
				
				if (onClickHandler == null)
				{
					return;
				}
				
				onClickHandler(this);
			}
		}
	}
	
	//** Getters and setters.
	
	override function set_visible(value:Bool):Bool 
	{
		for (i in 0...__graphics.count) 
		{
			__graphics.members[i].visible = value;
		}
		
		__label.visible = value;
		
		return super.set_visible(value);
	}
	
	override function set_x(value:Float):Float 
	{
		super.set_x(value);
		
		__setGraphicX();
		
		@:privateAccess __label.__setOffsetX(x + value);
		
		return value;
	}
	
	override function set_y(value:Float):Float 
	{
		super.set_y(value);
		
		__setGraphicY();
		
		@:privateAccess __label.__setOffsetY(y + value);
		
		return value;
	}
	
	override function set_z(value:Float):Float 
	{
		@:privateAccess __label.z = value - 3;
		
		return value;
	}
	
	override function __setOffsetX(value:Float):Void 
	{
		super.__setOffsetX(value);
		
		__setGraphicX();
		
		@:privateAccess __label.__setOffsetX(x + value);
	}
	
	override function __setOffsetY(value:Float):Void 
	{
		super.__setOffsetY(value);
		
		__setGraphicY();
		
		@:privateAccess __label.__setOffsetY(y + value);
	}
}