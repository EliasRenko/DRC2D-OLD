package cont.ui;

class UiDialog extends UiWindow
{
	private var __previousDialog:UiDialog;
	
	public function new(text:String = "", width:Float = 128, height:Float = 128, x:Float = 0, y:Float = 0, scrollable:Bool = false) 
	{
		super(text, width, height, x, y, false);
	}
	
	override function init():Void 
	{
		super.init();
	}
	
	override function release():Void 
	{
		@:privateAccess __form.__dialog = null;
		
		super.release();
	}
}