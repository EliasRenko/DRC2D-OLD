package cont;

import drc.objects.State;
import drc.utils.Common;
import drc.input.Controls;

class TestGamepad extends State {

	private var __log:String = '';

	public function new() {

		super();
	}

	override public function update():Void {

		super.update();

		var show:Bool = false;

		if (Common.input.getGamepad(0).released(Controls.A)) {

			__log = 'A  ';

			show = true;
		}

		if (Common.input.getGamepad(0).released(Controls.B)) {

			__log = 'B  ';

			show = true;
		}

		if (Common.input.getGamepad(0).released(Controls.X)) {

			__log = 'X  ';

			show = true;
		}

		if (Common.input.getGamepad(0).released(Controls.Y)) {

			__log = 'Y  ';

			show = true;
		}

		if (Common.input.getGamepad(0).released(Controls.BACK)) {

			__log = 'BACK  ';

			show = true;
		}

		if (Common.input.getGamepad(0).released(Controls.START)) {

			__log = 'START  ';

			show = true;
		}

		if (Common.input.getGamepad(0).released(Controls.LEFT_STICK)) {

			__log = 'LEFT_STICK  ';

			show = true;
		}

		if (Common.input.getGamepad(0).released(Controls.RIGHT_STICK)) {

			__log = 'RIGHT_STICK  ';

			show = true;
		}

		if (Common.input.getGamepad(0).released(Controls.LEFT_SHOULDER)) {

			__log = 'LEFT_SHOULDER  ';

			show = true;
		}

		if (Common.input.getGamepad(0).released(Controls.RIGHT_SHOULDER)) {

			__log = 'RIGHT_SHOULDER  ';

			show = true;
		}

		if (Common.input.getGamepad(0).released(Controls.DPAD_UP)) {

			__log = 'DPAD_UP  ';

			show = true;
		}

		if (Common.input.getGamepad(0).released(Controls.DPAD_DOWN)) {

			__log = 'DPAD_DOWN  ';

			show = true;
		}

		if (Common.input.getGamepad(0).released(Controls.DPAD_LEFT)) {

			__log = 'DPAD_LEFT  ';

			show = true;
		}

		if (Common.input.getGamepad(0).released(Controls.DPAD_RIGHT)) {

			__log = 'DPAD_RIGHT  ';

			show = true;
		}

		if (show) trace(__log);
	}
}