package cont;

import cont.ui.UiButton;
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

        var button:UiButton = new UiButton('Press', 128, 64, 64);

        var txt1:UiLabel = new UiLabel('123', 32, 32);
        var txt2:UiLabel = new UiLabel('456', 32, 64);
        var txt3:UiLabel = new UiLabel('789', 32, 90);

        //c.addLabel('F');
        //c.addLabel('A');

        form.addControl(c);
        //form.addControl(button);

        addEntity(form);

        //form.addControl(txt1);
        //form.addControl(txt2);
        //form.addControl(txt3);

        //txt1.text += 'ABC';

        c.addLabel('File');
        c.addLabel('Edit');
        c.addLabel('View');
        c.addLabel('Help');

        c.addOption('New', 0);
        c.addOption('Open', 0);
        c.addOption('Save', 0);
        c.addOption('Load', 0);
        c.addOption('Exit', 0);
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