package cont.ui;

import drc.display.Tile;
import cont.ui.UiEventType;
import cont.ui.UiStripPanel;
import drc.part.Group;

class UiMenustrip extends UiStrip
{
	// ** Privates.
	
	/** @private **/ private var __lastLabel:Float = 6;
	
	/** @private **/ private var __panels:Group<UiStripPanel> = new Group<UiStripPanel>();
	
	/** @private **/ private var __stamp_close:UiStamp;

	public function new(width:Float, x:Float = 0, y:Float = 0) {

		// ** Super.

		super(width, x, y);

		// ** Set the 'type' of the control.

		__type = 'menustrip';

		__stamp_close = new UiStamp(54, width - 20, 9);
	}

	override public function init():Void 
	{
		super.init();
		
		for (i in 0...__panels.count)
		{
			__controls.members[i].x = __lastLabel;
			
			//** Call initMember method.
			
			__initMember(__panels.members[i]);
			
			__panels.members[i].x = __lastLabel;
			
			__panels.members[i].visible = false;
			
			__lastLabel += __controls.members[i].width + 12;
		}

		//addControl(__stamps.members[0]);

		//addControl(__stamps.members[1]);

		addControl(__stamp_close);
	}
	
	override public function release():Void 
	{
		super.release();
	}
	
	public function addLabel(text:String):Void
	{
		var _label:UiMenustripLabel = new UiMenustripLabel(text, __lastLabel, 1);

		addControl(_label);

		_label.onEvent.add(__onLabel_click, ON_CLICK);

		var _stripPanel:UiStripPanel = new UiStripPanel(128, _label.x, 24);

		_label.stripPanel = _stripPanel;

		//@:privateAccess _stripPanel.__parent = this;
		
		if (__form != null)
		{
			//** Call initMember method.
			
			__initMember(_stripPanel);
			
			_stripPanel.visible = false;
			
			__lastLabel += _label.width + 12;
		}
		
		__panels.add(_stripPanel);
	}
	
	public function addOption(text:String, index:UInt, handler:UiControl->UiEventType->Void = null)
	{
		#if debug

		if (__panels.members[index] == null) throw 'Invalid option index.';

		#end

		var _label:UiControl = new UiLabel(text, 0, 0);

		if (handler != null) {

			_label.onEvent.add(handler, ON_CLICK);
		}

		__panels.members[index].addControl(_label);
	}
	
	private function __hideList(control:UiControl):Void
	{
		control.visible = false;
	}
	
	override public function update():Void {

		super.update();
		
		for (i in 0...__panels.count)
		{
			__panels.members[i].update();
		}
	}
	
	override public function updateCollision():Void {

		super.updateCollision();

		for (i in 0...__panels.count)
		{
			__panels.members[i].updateCollision();
		}
	}
	
	public function removeLabel(label:UiLabel):Void {
		
	}
	
	override private function __initGraphics():Void {
		
		__graphics.addAt(0, new Tile(null, 0));
		
		__graphics.addAt(1, new Tile(null, 1));
		
		__graphics.addAt(2, new Tile(null, 2));
	}

	private function __onLabel_click(control:UiControl, type:UiEventType):Void {

		var _menustripLabel:UiMenustripLabel = cast(control, UiMenustripLabel);

		__form.selectedControl = _menustripLabel.stripPanel;
	}
	
	override function onFormResize() {

		super.onFormResize();

		width = __form.width;
	}
	
	//** Getters and setters.
	
	override function set_width(value:Float):Float {

		super.set_width(value);

		__stamp_close.x = __width - 20;

		return __width;
	}

	override function set_z(value:Float):Float 
	{
		super.set_z(value);

		for (i in 0...__panels.count)
		{
			__panels.members[i].z = value - 1;
		}
		
		return __z;
	}
}

private class UiMenustripLabel extends UiLabel {

	// ** Publics.

	public var stripPanel:UiStripPanel;

	public function new(text:String, x:Float = 0, y:Float = 0) {

		super(text, 1, x, y);
	}
}