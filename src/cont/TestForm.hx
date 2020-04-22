package cont;

import cont.ui.UiLabel;
import cont.ui.UiTextField;
import drc.input.Control;
import cont.ui.UiPanel;
import cont.ui.UiMenustrip;
import drc.objects.State;
import cont.ui.UiForm;
import drc.utils.Common;

class TestForm extends State {

    public var form:UiForm;

    public function new() {
        
        super();

        form = new UiForm(640, 480);

        var c:UiMenustrip = new UiMenustrip(640, 0, 0);

        var panel:UiPanel = new UiPanel(128, 128, 128, 128);

        //var txt:UiLabel = new UiLabel('Hello!');

        addEntity(form);

        form.addControl(c);
        //form.addControl(txt);

        c.addLabel('File');
        //c.addLabel('Edit');
        //c.addLabel('View');
        //c.addLabel('Help');


    }

    override function render() {

        super.render();

        
    }

    override function update() {

        if (Common.input.getGamepad(0).check(Control.A)) {

            form.__tilemap.z += 1;
        }

        if (Common.input.getGamepad(0).check(Control.B)) {

            form.__tilemap.z -= 1;
        }

        if (Common.input.getGamepad(0).check(Control.Y)) {

            camera.z += 1;
        }
        
        if (Common.input.getGamepad(0).check(Control.X)) {

            camera.z -= 1;
		}

        if (Common.input.getGamepad(0).check(Control.LEFT_SHOULDER)) {

            camera.yaw -= 1;
        }
        
        if (Common.input.getGamepad(0).check(Control.RIGHT_SHOULDER)) {

            camera.yaw += 1;
		}

        if (Common.input.getGamepad(0).check(Control.DPAD_UP)) {

            camera.y += 1;
		}

		if (Common.input.getGamepad(0).check(Control.DPAD_DOWN)) {

            camera.y -= 1;
		}

		if (Common.input.getGamepad(0).check(Control.DPAD_LEFT)) {

            camera.x += 1;
		}

		if (Common.input.getGamepad(0).check(Control.DPAD_RIGHT)) {

            camera.x -= 1;
        }
        
        super.update();
    }
}