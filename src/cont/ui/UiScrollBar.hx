package cont.ui;

import drc.part.Group;
import drc.display.Tile;

class UiScrollBar extends UiLayout
{
	//** Publics.
	
	public var onClickHandler:UiControl->Void;
	
	public var scrollDown:Bool;
	
	public var scrollUp:Bool;
	
	//** Privates.
	
	/** @private */ private var __graphics:Group<Tile>;
	
	/** @private */ private var __buttonDown:UiStamp;
	
	/** @private */ private var __buttonUp:UiStamp;
	
	public function new(size:Float = 128, x:Float = 0, y:Float = 0) 
	{
		super(28, 128, x, y);
		
		__graphics = new Group<Tile>(2);
		
		__graphics.addAt(0, new Tile(null, 42));
		
		__graphics.addAt(1, new Tile(null, 43));
		
		__buttonDown = new UiStamp(43, 0, 30);
		
		__buttonUp = new UiStamp(42);
	}
	
	override public function init():Void 
	{
		super.init();
		
		__initMember(__buttonDown);
		
		__initMember(__buttonUp);
		
		//for (i in 0...__graphics.count) 
		//{
			//__graphics.members[i].parentTilemap = @:privateAccess __form.__tilemap;
			//
			//@:privateAccess __form.__tilemap.addTile(__graphics.members[i]);
			//
			//__graphics.members[i].visible = visible;
			//
			//__graphics.members[i].z = __parent.z - 1;
		//}
		//
		//__graphics.members[1].offsetY = 30;
		//
		////** Call setGraphicX method.
		//
		//__setGraphicX();
		//
		////** Call setGraphicY method.
		//
		//__setGraphicY();
	}
	
	override public function release():Void 
	{
		__buttonDown.release();
		
		__buttonUp.release();
		
		super.release();
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
		
		scrollDown = false;
		
		scrollUp = false;
	}
	
	override public function updateCollision():Void 
	{
		super.updateCollision();
		
		//** If collide...
		
		if (collide)
		{
			__buttonUp.updateCollision();
			
			if (__buttonUp.collide)
			{
				__form.cursorId = 4;
				
				if (__form.leftClick)
				{
					scrollUp = true;
					
					__form.selectedControl = this;
				}
				
				return;
			}
			
			__buttonDown.updateCollision();
			
			if (__buttonDown.collide)
			{
				__form.cursorId = 4;
				
				if (__form.leftClick)
				{
					scrollDown = true;
					
					__form.selectedControl = this;
				}
				
				return;
			}
		}
	}
	
	//** Getters and setters.
	
	override function set_visible(value:Bool):Bool 
	{
		__buttonDown.visible = value;
		
		__buttonUp.visible = value;
		
		return super.set_visible(value);
	}
	
	override function set_z(value:Float):Float 
	{
		__buttonDown.z = value;
		
		__buttonUp.z = value;
		
		return super.set_z(value);
	}
	
	override function __setOffsetX(value:Float):Void 
	{
		super.__setOffsetX(value);
		
		@:privateAccess __buttonDown.__setOffsetX(x + __offsetX);
		
		@:privateAccess __buttonUp.__setOffsetX(x + __offsetX);
	}
	
	override function __setOffsetY(value:Float):Void 
	{
		super.__setOffsetY(value);
		
		@:privateAccess __buttonDown.__setOffsetY(y + __offsetY);
		
		@:privateAccess __buttonUp.__setOffsetY(y + __offsetY);
	}
}