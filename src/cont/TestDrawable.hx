package cont;

import drc.utils.Common;
import drc.input.Control;
import drc.utils.Resources;
import drc.data.Profile;
import drc.display.Image;
import drc.objects.State;

class TestDrawable extends State {

    private var _image:Image;

    private var _profile:Profile;

    public function new() {

        super();

        _profile = Resources.getProfile('res/profiles/texture.json');

        _image = new Image(_profile, [Resources.loadTexture('res/graphics/grid_bw.png')]);

        _image.centerOrigin();

        addGraphic(_image);
    }

    override function update() {

        super.update();

        if (Common.input.getGamepad(0).check(Control.A)) {

            trace(_image.angle);
        }

        if (Common.input.getGamepad(0).check(Control.Y)) {

            _image.scaleX += 0.01;

            _image.scaleY += 0.01;
        }
        
        if (Common.input.getGamepad(0).check(Control.X)) {

            _image.scaleX -= 0.01;
            
            _image.scaleY -= 0.01;
		}

        if (Common.input.getGamepad(0).check(Control.LEFT_SHOULDER)) {

            _image.angle += 0.1;
        }
        
        if (Common.input.getGamepad(0).check(Control.RIGHT_SHOULDER)) {

            _image.angle -= 0.1;
		}

		if (Common.input.getGamepad(0).check(Control.DPAD_DOWN)) {

            _image.y += 1;
		}

        if (Common.input.getGamepad(0).check(Control.DPAD_UP)) {

            _image.y -= 1;
		}

		if (Common.input.getGamepad(0).check(Control.DPAD_DOWN)) {

            _image.y += 1;
		}

		if (Common.input.getGamepad(0).check(Control.DPAD_LEFT)) {

            _image.x -= 1;
		}

		if (Common.input.getGamepad(0).check(Control.DPAD_RIGHT)) {

            _image.x += 1;
		}
    }
}