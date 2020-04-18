package cont.ui;

import cont.ui.UiContainer;
import cont.ui.UiForm;
import drc.display.Tile;
import drc.part.DrcGroup;

class UiPanel extends UiContainer
{
	//** Privates.
	
	/** @private */ private var __graphics:DrcGroup<Tile>;
	
	public function new(width:Float = 128, height:Float = 128, x:Float = 0, y:Float = 0, scrollable:Bool = false) 
	{
		if (width < 34)
		{
			width = 34;
		}
		
		if (height < 34)
		{
			height = 34;
		}
		
		super(width, height, x, y, scrollable);
		
		__graphics = new DrcGroup<Tile>(9);
		
		__graphics.addAt(0, new Tile(null, UiForm.GRAPHIC_PANEL_0_ID));
		
		__graphics.addAt(1, new Tile(null, UiForm.GRAPHIC_PANEL_1_ID));
		
		__graphics.addAt(2, new Tile(null, UiForm.GRAPHIC_PANEL_2_ID));
		
		__graphics.addAt(3, new Tile(null, UiForm.GRAPHIC_PANEL_3_ID));
		
		__graphics.addAt(4, new Tile(null, UiForm.GRAPHIC_PANEL_4_ID));
		
		__graphics.addAt(5, new Tile(null, UiForm.GRAPHIC_PANEL_5_ID));
		
		__graphics.addAt(6, new Tile(null, UiForm.GRAPHIC_PANEL_6_ID));
		
		__graphics.addAt(7, new Tile(null, UiForm.GRAPHIC_PANEL_7_ID));
		
		__graphics.addAt(8, new Tile(null, UiForm.GRAPHIC_PANEL_8_ID));
	}
	
	override public function init():Void 
	{
		super.init();
		
		for (i in 0...__graphics.count) 
		{
			__graphics.members[i].parentTilemap = @:privateAccess __form.__tilemap;
			
			@:privateAccess __form.__tilemap.addTile(__graphics.members[i]);
			
			__graphics.members[i].visible = visible;
		}
		
		__graphics.members[1].offsetX = 30;
		
		__graphics.members[3].offsetY = 30;
		
		__graphics.members[4].offsetX = 30;
		
		__graphics.members[4].offsetY = 30;
		
		__graphics.members[5].offsetY = 30;
		
		__graphics.members[7].offsetX = 30;
		
		__setWidth();
		
		__setHeight();
		
		__setGraphicX();
		
		__setGraphicY();
		
		__setMask(__x + __offsetX, __y + __offsetY, width, height);
	}
	
	override public function release():Void 
	{
		//for (i in 0...__children.count) 
		//{
			//__children.members[i].release();
		//}
		
		for (j in 0...__graphics.count) 
		{
			@:privateAccess __form.__tilemap.removeTile(__graphics.members[j]);
		}
		
		super.release();
	}
	
	public function dispose():Void
	{
		for (i in 0...__children.count)
		{
			__children.members[i].release();
		}
	}
	
	override public function update():Void 
	{
		super.update();
	}
	
	override public function updateCollision():Void 
	{
		super.updateCollision();
	}
	
	private function __setHeight():Void
	{
		//if (__form == null)
		//{
			//return;
		//}
		
		__graphics.members[3].height = __height - 60;
		
		__graphics.members[4].height = __height - 60;
		
		__graphics.members[5].height = __height - 60;
		
		__graphics.members[6].offsetY = __height - 30;
		
		__graphics.members[7].offsetY = __height - 30;
		
		__graphics.members[8].offsetY = __height - 30;
	}
	
	private function __setWidth():Void
	{
		//if (__form == null)
		//{
			//return;
		//}
		
		__graphics.members[1].width = __width - 60;
		
		__graphics.members[2].offsetX = __width - 30;
		
		__graphics.members[4].width = __width - 60;
		
		__graphics.members[5].offsetX = __width - 30;
		
		__graphics.members[7].width = __width - 60;
		
		__graphics.members[8].offsetX = __width - 30;
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
		if (value < 34)
		{
			value = 34;
		}
		
		super.set_height(value);
		
		__setHeight();
		
		return value;
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
		if (value < 34)
		{
			value = 34;
		}
		
		super.set_width(value);
		
		__setWidth();
		
		return value;
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
}