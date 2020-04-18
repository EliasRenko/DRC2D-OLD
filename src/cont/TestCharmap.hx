package cont;

import drc.types.TextEvent;
import drc.input.Control;
import drc.utils.Common;
import drc.display.Charmap;
import drc.display.Text;
import drc.objects.State;
import drc.utils.Resources;

class TestCharmap extends State
{
	public var charmap:Charmap;
	
	public var text:Text;

	public function new() 
	{
		super();
		
		var profile = Resources.getProfile("res/profiles/font.json");
		
		charmap = new Charmap(profile, Resources.loadText("res/fonts/nokiafc22.json"));
		
		var _s:String = "";
		//"Welcome to the H.E.V. mark IV protective system, for use in hazardous environment conditions. High impact reactive armour activated. Atmospheric contaminant sensors activated. Have a very safe day!";

		text = new Text(charmap, '', 64, 64);

		text.wordwrap = true;

		text.fieldWidth = 200;

		text.text = _s;
		
		addGraphic(charmap);

		Common.input.beginTextInput();

		//Common.input.endTextInput();
		
		Common.input.textEvent.add(onTextAdd);
	}
	
	public function onTextAdd(event:TextEvent):Void
	{
		text.text += event.data;
	}

	override public function update():Void 
	{
		super.update();

		if (Common.input.getGamepad(0).check(Control.DPAD_UP)) {

            text.y -= 2;
		}

		if (Common.input.getGamepad(0).check(Control.DPAD_DOWN)) {

            text.y += 2;
		}

		if (Common.input.getGamepad(0).check(Control.DPAD_LEFT)) {

			text.x -= 2;
		}

		if (Common.input.getGamepad(0).check(Control.DPAD_RIGHT)) {

            text.x += 2;
		}
	}
}