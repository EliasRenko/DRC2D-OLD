package cont;

import drc.display.Tile;
import drc.display.Tilemap;
import drc.utils.Common;
import drc.input.Control;
import drc.utils.Resources;
import drc.data.Profile;
import drc.display.Image;
import drc.objects.State;
import drc.utils.Assets;
import drc.core.Future;

class TestDrawable extends State {

    private var __image:Image;

    private var __tilemap:Tilemap;

    private var __tile:Tile;

    private var _profile:Profile;

    public function new() {

        super();

        _profile = Resources.getProfile('res/profiles/texture.json');

        Common.assets.loadTexture('res/graphics/grid_mt.png');

        __image = new Image(_profile, [Resources.loadTexture('res/graphics/grid_bw.png')]);

        __image.centerOrigin();

        // ** ---

        __tilemap = new Tilemap(_profile, [Common.assets.getTexture('res/graphics/grid_mt.png')], null);

        __tilemap.tileset.addRegion({values: [0, 0, 128, 128]});

        __tile = new Tile(__tilemap, 0);

        __tile.centerOrigin();

        __tile.add();

        //addGraphic(__image);

        addGraphic(__tilemap);
    }

    override function update() {

        //__tile.x = Common.input.mouse.windowX;
		
		//__tile.y = Common.input.mouse.windowY;

        if (Common.input.getGamepad(0).check(Control.A)) {

            //trace(__image.angle);
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

		if (Common.input.getGamepad(0).check(Control.DPAD_DOWN)) {

            __tile.y += 1;
		}

        if (Common.input.getGamepad(0).check(Control.DPAD_UP)) {

            camera.y -= 1;
		}

		if (Common.input.getGamepad(0).check(Control.DPAD_DOWN)) {

            camera.y += 1;
		}

		if (Common.input.getGamepad(0).check(Control.DPAD_LEFT)) {

            camera.x -= 1;
		}

		if (Common.input.getGamepad(0).check(Control.DPAD_RIGHT)) {

            camera.x += 1;
        }
        
        super.update();
    }
}