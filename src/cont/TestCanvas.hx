package cont;

import drc.display.Image;
import drc.objects.State;
import drc.data.Profile;
import drc.utils.Common;
import drc.utils.Resources;
import drc.input.Control;

class TestCanvas extends State {

    //** Publics. **/

    public var image:Image;

    public var profile:Profile;

    public function new() {
        
        super();

        profile = Resources.getProfile("res/profiles/texture.json");

        image = new Image(profile, Resources.loadTexture('res/graphics/grid.png'));
    }

    override function render():Void {

        Common.stage.draw(image);

        super.render();
    }

    override function update():Void {

        super.update();

		if (Common.input.getGamepad(0).check(Control.A)) {

            Common.stage.width -= 1;
			
            Common.stage.height -= 1;
		}

		if (Common.input.getGamepad(0).check(Control.X)) {

            Common.stage.width += 1;
			
            Common.stage.height += 1;
		}
		
        if (Common.input.getGamepad(0).check(Control.DPAD_UP)) {

            image.vertices.innerData[1] -= 1;
		}

		if (Common.input.getGamepad(0).check(Control.DPAD_DOWN)) {

            image.vertices.innerData[1] += 1;
		}

		if (Common.input.getGamepad(0).check(Control.DPAD_LEFT)) {

			image.vertices.innerData[0] -= 1;
		}

		if (Common.input.getGamepad(0).check(Control.DPAD_RIGHT)) {

            image.vertices.innerData[0] += 1;
		}
    }
}