package cont.ui;

import drc.math.Rectangle;
import drc.part.Group;
import drc.display.Tile;
import cont.ui.UiEventType;

class UiScrollBar extends UiLayout
{
	//** Publics.
	
	public var layout:UiLayout;
	
	//** Privates.
	
	/** @private */ private var __graphics:Group<Tile>;
	
	/** @private **/ private var __layout:UiLayout;

	/** @private **/ private var __slider:UiScrollBarSlider;

	public function new(layout:UiLayout, width:Float = 128, height:Float = 128, x:Float = 0, y:Float = 0) {

		super(width, height, x, y);
		
		__graphics = new Group<Tile>(4);

		__layout = layout;

		__layout.onEvent.add(__onLayout_resize, ON_RESIZE);

		__slider = new UiScrollBarSlider(width - 12, 0);
		
		__slider.onEvent.add(__onSliderDrag, ON_DRAG);

		//__mask = true;

		//__maskBox = new Rectangle(x + __offsetX, y + __offsetY, width, height);
	}
	
	override public function init():Void 
	{
		super.init();

		super.addControl(__slider);

		super.addControl(__layout);

		__configSliderY();
	}
	
	override public function release():Void 
	{
		super.release();
	}
	
	override function addControl(control:UiControl):UiControl {

		return __layout.addControl(control);
	}

	private function __onSliderDrag(control:UiControl, type:UInt):Void {

		if (control.y < 0) {
			
			control.y = 0;
		}

		if (control.y > height - __slider.height) {

			control.y = height - __slider.height;
		}

		var perc_available = (control.y / height) * 100;

		var value = (__layout.height * perc_available) / 100;

		__layout.y = 0 - value;

		//__layout.y = 0 - control.y;
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
		
		if (collide) {


		}
	}

	private function __configSliderY():Void {
		
		var _dif:Float = __layout.height - height;

		if (_dif > 0) {

			__slider.visible = true;

			var perc_available = (_dif / __layout.height) * 100;

			__slider.height = height - (height * perc_available) / 100;

			return;
		}
		
		__slider.visible = false;
	}

	private function __onLayout_resize(control:UiControl, type:UInt):Void {

		__configSliderY();

		__setMask(__x + __offsetX, __y + __offsetY, __width, __height);
	}

	//** Getters and setters.
	
	override function set_height(value:Float):Float {

		super.set_height(value);

		__configSliderY();

		return __height;
	}

	override function set_visible(value:Bool):Bool 
	{
		super.set_visible(value);

		__slider.visible = __slider.visible ? __visible : false;

		return __visible;
	}
	
	override function set_x(value:Float):Float {
		
		super.set_x(value);

		__setMask(__x + __offsetX, __y, __width, __height);

		return __x;
	}

	override function set_y(value:Float):Float {

		super.set_y(value);

		__setMask(__x, __y + __offsetY, __width, __height);

		return __y;
	}

	override function set_z(value:Float):Float 
	{
		return super.set_z(value);
	}
	
	override function __setOffsetX(value:Float):Void 
	{
		super.__setOffsetX(value);

		__setMask(__x + __offsetX, __y + __offsetY, __width, __height);
	}
	
	override function __setOffsetY(value:Float):Void 
	{
		super.__setOffsetY(value);

		__setMask(__x + __offsetX, __y + __offsetY, __width, __height);
	}
}

private class UiScrollBarLayout extends UiLayout {

	public function new(width:Float, height:Float, x:Float, y:Float) {
		
		super(width, height, x, y);
	}
}

private class UiScrollBarSlider extends UiLayout {

	// ** Privates.

	/** @private **/ private var __graphics:Group<Tile>;

	public function new(x:Float, y:Float) {
		
		super(12, 60, x, y);

		__graphics = new Group<Tile>(3);
		
		__graphics.addAt(0, new Tile(null, 64));
		
		__graphics.addAt(1, new Tile(null, 65));
		
        __graphics.addAt(2, new Tile(null, 66));

		__allowDragX = false;
	}

	override function init() {

		super.init();

		for (i in 0...__graphics.count) 
		{
			__graphics.members[i].parentTilemap = @:privateAccess __form.__tilemap;
			
			@:privateAccess __form.__tilemap.addTile(__graphics.members[i]);
			
			__graphics.members[i].visible = visible;

			__graphics.members[i].z = __parent.z - 1;
		}

		__graphics.members[1].offsetY = 4;
        
		__graphics.members[2].offsetY = 12;
		
		__setGraphicX();

		__setGraphicY();
	}

	private function __setHeight():Void {

		__graphics.members[1].height = height - 4;
		
		__graphics.members[2].offsetY = height;

		__graphics.members[2].y = __y + __offsetY;
	}
	
	private function __setGraphicX():Void {

		for (i in 0...__graphics.count) 
		{
			__graphics.members[i].x = __x + __offsetX;
		}
	}
	
	private function __setGraphicY():Void {

		__graphics.members[0].y = __y + __offsetY;

		__graphics.members[1].y = __y + __offsetY;

		__graphics.members[2].y = __y + __offsetY;
	}

	override function updateCollision() {

		super.updateCollision();

		if (collide) {

			if (__form.leftClick) {

				__form.startDrag(this);
			}
		}
	}

	override function set_height(value:Float):Float {

		super.set_height(value);

		__setHeight();

		return __height;
	}

	override function set_visible(value:Bool):Bool {

		super.set_visible(value);

		for (i in 0...__graphics.count) 
		{	
			__graphics.members[i].visible = __visible;
		}

		return __visible;
	}

	override function set_x(value:Float):Float {

		super.set_x(value);

		__setGraphicX();

		return __x;
	}

	override function set_y(value:Float):Float {

		super.set_y(value);

		__setGraphicY();

		return __y;
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