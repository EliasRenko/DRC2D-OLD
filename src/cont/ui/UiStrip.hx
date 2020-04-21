package cont.ui;

import cont.ui.UiContainer;
import cont.ui.UiForm;
import drc.display.Tile;
import drc.part.Group;

class UiStrip extends UiContainer
{
	//** Privates.
	
	/** @private */ private var __graphics:Group<Tile>;
	
	public function new(width:Float, x:Float, y:Float) 
	{
		super(width, 30, x, y);
		
		__graphics = new Group<Tile>(3);
		
		//__graphics.addMemberAt(0, new DrcTile(null, UiForm.GRAPHIC_STRIP_0_ID));
		//
		//__graphics.addMemberAt(1, new DrcTile(null, UiForm.GRAPHIC_STRIP_1_ID));
		//
		//__graphics.addMemberAt(2, new DrcTile(null, UiForm.GRAPHIC_STRIP_2_ID));
		
		__graphics.addAt(0, new Tile(null, 39));
		
		__graphics.addAt(1, new Tile(null, 40));
		
		__graphics.addAt(2, new Tile(null, 41));
	}
	
	override public function init():Void 
	{
		super.init();
		
		for (i in 0...__graphics.count) 
		{
			__graphics.members[i].parentTilemap = @:privateAccess __form.__tilemap;
			
			__graphics.members[i].visible = visible;
			
			@:privateAccess __form.__tilemap.addTile(__graphics.members[i]);
		}
		
		__graphics.members[1].offsetX = 30;
		
		__setWidth(__width);
		
		__setGraphicX();
		
		__setGraphicY();
	}
	
	override public function release():Void 
	{
		for (i in 0...__children.count) 
		{
			__children.members[i].release();
		}
		
		for (j in 0...__graphics.count) 
		{
			@:privateAccess __form.__tilemap.removeTile(__graphics.members[j]);
		}
		
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
	
	//** Getters and setters.
	
	override function set_height(value:Float):Float
	{
		return __height;
	}
	
	override function __setOffsetX(value:Float):Void 
	{
		super.__setOffsetX(value);
		
		__setGraphicX();
	}
	
	override function __setOffsetY(value:Float):Void 
	{
		super.__setOffsetY(value);
		
		__setGraphicY();
	}
	
	override function set_visible(value:Bool):Bool 
	{
		for (i in 0...__graphics.count)
		{
			__graphics.members[i].visible = value;
		}
		
		return super.set_visible(value);
	}
	
	override function set_x(value:Float):Float 
	{
		super.set_x(value);
		
		__setGraphicX();
		
		return value;
	}
	
	override function set_y(value:Float):Float 
	{
		super.set_y(value);
		
		__setGraphicY();
		
		return value;
	}
	
	override function set_z(value:Float):Float 
	{
		for (i in 0...__graphics.count)
		{
			__graphics.members[i].z = value;
		}
		
		return super.set_z(value);
	}
	
	override function set_width(value:Float):Float 
	{
		if (value < 48)
		{
			value = 48;
		}
		
		__setWidth(value);
		
		return super.set_width(value);
	}
	
	private function __setWidth(value:Float):Void
	{
		__graphics.members[1].width = value - 60;
		
		__graphics.members[2].offsetX = value - 30;
	}
}