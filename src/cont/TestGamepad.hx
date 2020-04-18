package cont;

import drc.objects.State;
import drc.utils.Common;
import drc.input.Control;

class TestGamepad extends State {

	private var __log:String = '';

	public function new() {

		super();
	}

	override public function update():Void {

		super.update();

		var show:Bool = false;

		if (Common.input.getGamepad(0).released(Control.A)) {

			__log = 'A  ';

			show = true;
		}

		if (Common.input.getGamepad(0).released(Control.B)) {

			__log = 'B  ';

			show = true;
		}

		if (Common.input.getGamepad(0).released(Control.X)) {

			__log = 'X  ';

			show = true;
		}

		if (Common.input.getGamepad(0).released(Control.Y)) {

			__log = 'Y  ';

			show = true;
		}

		if (Common.input.getGamepad(0).released(Control.BACK)) {

			__log = 'BACK  ';

			show = true;
		}

		if (Common.input.getGamepad(0).released(Control.START)) {

			__log = 'START  ';

			show = true;
		}

		if (Common.input.getGamepad(0).released(Control.LEFT_STICK)) {

			__log = 'LEFT_STICK  ';

			show = true;
		}

		if (Common.input.getGamepad(0).released(Control.RIGHT_STICK)) {

			__log = 'RIGHT_STICK  ';

			show = true;
		}

		if (Common.input.getGamepad(0).released(Control.LEFT_SHOULDER)) {

			__log = 'LEFT_SHOULDER  ';

			show = true;
		}

		if (Common.input.getGamepad(0).released(Control.RIGHT_SHOULDER)) {

			__log = 'RIGHT_SHOULDER  ';

			show = true;
		}

		if (Common.input.getGamepad(0).released(Control.DPAD_UP)) {

			__log = 'DPAD_UP  ';

			show = true;
		}

		if (Common.input.getGamepad(0).released(Control.DPAD_DOWN)) {

			__log = 'DPAD_DOWN  ';

			show = true;
		}

		if (Common.input.getGamepad(0).released(Control.DPAD_LEFT)) {

			__log = 'DPAD_LEFT  ';

			show = true;
		}

		if (Common.input.getGamepad(0).released(Control.DPAD_RIGHT)) {

			__log = 'DPAD_RIGHT  ';

			show = true;
		}

		if (show) trace(__log);
	}
}