package cont.ui;

import drc.graphics.DrcTile;
import drc.part.Group;

class UiGroupBox extends UiContainer
{
	//** Publics.
	
	public var header:String;
	
	//** Privates.
	
	/** @private */ private var __graphics:Group<DrcTile>;
	
	/** @private */ private var __label:UiLabel;
	
	public function new(text:String, width:Float, height:Float, x:Float = 0, y:Float = 0) 
	{
		super(width, height, x, y);
		
		__graphics = new Group<DrcTile>(5);
		
		__graphics.addAt(0, new DrcTile(null, 13));
		
		__graphics.addAt(1, new DrcTile(null, 13));
		
		__graphics.addAt(2, new DrcTile(null, 13));
		
		__graphics.addAt(3, new DrcTile(null, 13));
		
		__graphics.addAt(4, new DrcTile(null, 13));
		
		__label = new UiLabel(text, 12, -12);
	}
	
	override public function init():Void 
	{
		super.init();
		
		__initMember(__label);
		
		for (i in 0...__graphics.count) 
		{
			__graphics.members[i].parentTilemap = @:privateAccess __form.__tilemap;
			
			@:privateAccess __form.__tilemap.addTile(__graphics.members[i]);
			
			__graphics.members[i].visible = visible;
			
			__graphics.members[i].z = __parent.z - 1;
		}
		
		__graphics.members[4].width = 8;
		
		__setWidth();
		
		__setHeight();
		
		__setGraphicX();
		
		__setGraphicY();
	}
	
	override public function release():Void 
	{
		for (j in 0...__graphics.count)
		{
			@:privateAccess __form.__tilemap.removeTile(__graphics.members[j]);
		}
		
		__label.release();
		
		super.release();
	}
	
	private function __setHeight():Void
	{
		__graphics.members[0].height = height;
		
		__graphics.members[1].offsetY = height - 2;
		
		__graphics.members[2].height = height;
	}
	
	private function __setWidth():Void
	{
		__graphics.members[1].width = width;
		
		__graphics.members[2].offsetX = width;
		
		__graphics.members[3].width = width - (__label.width + 16);
		
		__graphics.members[3].offsetX = __label.width + 16;
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
		
		return value;
	}
	
	override function set_y(value:Float):Float 
	{
		super.set_y(value);
		
		__setGraphicY();
		
		return value;
	}
	
	override function __setOffsetX(value:Float):Void 
	{
		super.__setOffsetX(value);
		
		__setGraphicX();
		
		__label.__setOffsetX(x + value);
	}
	
	override function __setOffsetY(value:Float):Void 
	{
		super.__setOffsetY(value);
		
		__setGraphicY();
		
		__label.__setOffsetY(y + value);
	}
}