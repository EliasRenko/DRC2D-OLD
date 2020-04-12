package cont;

import drc.graphics.Image;
import drc.objects.State;
import drc.display.Profile;
import drc.utils.Common;
import drc.utils.Resources;
import drc.input.Controls;

class TestCanvas extends State {

    //** Publics. **/

    public var image:Image;

    public var profile:Profile;

    public function new() {
        
        super();

        profile = Resources.getProfile("res/profiles/texture.json");

        image = new Image(profile);

        image.textures[0] = Resources.loadTexture('res/graphics/grid.png');
    }

    override function render():Void {

        Common.stage.draw(image);

        super.render();
    }

    override function update():Void {

        super.update();

        if (Common.input.getGamepad(0).check(Controls.DPAD_UP)) {

            image.vertices.innerData[1] -= 1;
		}

		if (Common.input.getGamepad(0).check(Controls.DPAD_DOWN)) {

            image.vertices.innerData[1] += 1;
		}

		if (Common.input.getGamepad(0).check(Controls.DPAD_LEFT)) {

			image.vertices.innerData[0] -= 1;
		}

		if (Common.input.getGamepad(0).check(Controls.DPAD_RIGHT)) {

            image.vertices.innerData[0] += 1;
		}

		
    }
}