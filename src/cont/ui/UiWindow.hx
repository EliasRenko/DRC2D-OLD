package cont.ui;

import cont.ui.UiControl;
import drc.display.Tile;
import drc.part.Group;
import cont.ui.UiEventType;

class UiWindow extends UiLayout
{
	// ** Publics.
	
	public var header(get, set):String;

	public var shouldClose:Bool = true;
	
	// ** Privates.
	
	/** @private **/ private var __label:UiLabel;

	/** @private **/ private var __stamp_close:UiStamp;

	/** @private **/ private var __windowPanel:UiWindowPanel;
	
	/** @private **/ private var __windowStrip:UiWindowStrip;
	
	public function new(text:String = "", width:Float = 128, height:Float = 128, x:Float = 0, y:Float = 0) 
	{
		// ** Super.

		super(width, height, x, y);
		
		__label = new UiLabel(text, 1, 6, 1);

		__stamp_close = new UiStamp(54, width - 20, 9);

		__windowStrip = new UiWindowStrip(width, 0, 0);
		
		__windowPanel = new UiWindowPanel(width, height - 16, 0, 30);

		__windowPanel.onEvent.add(__onWindowPanelEvent);

		type = 'window';
	}
	
	override public function init():Void 
	{
		// ** Super Init.

		super.init();

		super.addControl(__windowStrip);

		super.addControl(__windowPanel);

		__windowStrip.addControl(__label);

		__windowStrip.addControl(__stamp_close);
		
		// ** Set the hitbox.
		
		__setHitbox(0, 0, width, height);
	}
	
	override public function release():Void 
	{
		super.release();
	}
	
	override public function addControl(control:UiControl):UiControl 
	{
		return __windowPanel.addControl(control);
	}
	
	override public function removeControl(control:UiControl):Void 
	{
		__windowPanel.removeControl(control);
	}

	override public function updateCollision():Void 
	{
		super.updateCollision();

		if (collide) {
			
			if (__windowStrip.collide) {

				if (__label.collide) {

					if (__form.leftClick) {

						__form.startDrag(this);
					}
				}
			}
			
			if (__stamp_close.collide) {

				if (__form.leftClick)
				{
					if (shouldClose) {

						release();

						return;
					}

					visible = false;
				}
			}
		}
	}

	private function __onWindowPanelEvent(control:UiControl, type:UInt):Void {
		
		onEvent.dispatch(this, type);
	}
	
	//** Getters and setters.

	override function get_controls():Group<UiControl> {
		
		return __windowPanel.controls;
	}

	private function get_header():String
	{
		return __label.text;
	}
	
	private function set_header(value:String):String
	{
		return __label.text = value;
	}
}

private class UiWindowPanel extends UiPanel {

	public function new(width:Float = 128, height:Float = 128, x:Float = 0, y:Float = 0) {

		super(width, height, x, y);
	}

	override function __initGraphics() {
		
		__graphics.addAt(0, new Tile(null, 29));
		
		__graphics.addAt(1, new Tile(null, 30));
		
		__graphics.addAt(2, new Tile(null, 31));
		
		__graphics.addAt(3, new Tile(null, UiForm.GRAPHIC_PANEL_3_ID));
		
		__graphics.addAt(4, new Tile(null, UiForm.GRAPHIC_PANEL_4_ID));
		
		__graphics.addAt(5, new Tile(null, UiForm.GRAPHIC_PANEL_5_ID));
		
		__graphics.addAt(6, new Tile(null, UiForm.GRAPHIC_PANEL_6_ID));
		
		__graphics.addAt(7, new Tile(null, UiForm.GRAPHIC_PANEL_7_ID));
		
		__graphics.addAt(8, new Tile(null, UiForm.GRAPHIC_PANEL_8_ID));
	}

	override function set_height(value:Float):Float {

		value -= 28;

		return super.set_height(value);
	}
}

private class UiWindowStrip extends UiStrip {

	public function new(width:Float, x:Float, y:Float) {
		
		super(width, x, y);
	}

	override function __initGraphics() {
		
		__graphics.addAt(0, new Tile(null, 26));
		
		__graphics.addAt(1, new Tile(null, 27));
		
		__graphics.addAt(2, new Tile(null, 28));
	}
} 