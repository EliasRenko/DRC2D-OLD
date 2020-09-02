package cont.ui;

import cont.ui.UiPanel;
import cont.ui.UiControl;
import cont.ui.UiListItem;

class UiStripPanel extends UiPanel
{
	// ** Privates.
	
	/** @private **/ private var __lastItem:Float = 4;
	
	public function new(width:Float = 128, x:Float = 0, y:Float = 0) 
	{
		super(width, 32, x, y);
	}
	
	override public function init():Void 
	{
		super.init();
		
		height = __lastItem + 4;
	}
	
	override public function release():Void 
	{
		super.release();
	}

	override public function addControl(control:UiControl):UiControl 
	{
		var item:UiControl = super.addControl(new UiListItem(control, 4, __lastItem));
		
		control.x = 8;
		
		__lastItem += item.height;
		
		if (__form != null)
		{
			height = __lastItem + 4;
		}
		
		return item;
	}
	
	override public function dispose():Void
	{
		super.dispose();
		
		__lastItem = 4;
	}
	
	override public function update():Void 
	{
		super.update();
	}
	
	override public function updateCollision():Void 
	{
		super.updateCollision();
		
		if (collide)
		{
			//** Call updateCollision method of the panel.
			
			//__panel.updateCollision();
			
			if (__form.leftClick)
			{
				//visible = false;
			}
		}
	}
	
	override public function onFocusGain():Void 
	{
		super.onFocusGain();

		visible = true;
	}
	
	override public function onFocusLost():Void 
	{
		super.onFocusLost();
		
		visible = false;
	}
}