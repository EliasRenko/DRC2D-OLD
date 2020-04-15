package cont;

import drc.graphics.Tileset;
import drc.graphics.Image;
import drc.objects.State;
import drc.display.Profile;
import drc.utils.Common;
import drc.utils.Resources;
import drc.input.Controls;
import drc.graphics.Tilemap;
import drc.graphics.Tile;
import drc.utils.Resources;

class TestTilemap extends State {

    // ** Publics.

    public var tiles:Array<Tile> = new Array<Tile>();

    public var tilemap:Tilemap;

    public var profile:Profile;

    public var tile:Tile;

    public var tileset:Tileset;

    // ** Privates.

    private var __activeVertices:Int;

    public function new() {
        
        super();

        profile = Resources.getProfile("res/profiles/font.json");

        tileset = new Tileset();

        tileset.addRegion({ values: [0, 0, 18, 18] });
        tileset.addRegion({ values: [18, 0, 18, 18] });
        tileset.addRegion({ values: [36, 0, 18, 18] });
        tileset.addRegion({ values: [54, 0, 18, 18] });

        tilemap = new Tilemap(profile, Resources.loadFont('res/fonts/nokiafc22.png'), tileset);

        tile = new Tile(tilemap, 0, 0, 0);

        tilemap.addTile(tile);
    }

    override function render():Void {

        tilemap.render();

        Common.stage.draw(tilemap);
    }

    override function update():Void {

        super.update();

        //return;

        if (Common.input.getGamepad(0).check(Controls.A)) {

            for (tile in tilemap.tiles) {

                tile.angle += 1;
            }
        }
        
        if (Common.input.getGamepad(0).pressed(Controls.B)) {

            for (tile in tilemap.tiles) {

                tile.id += 1;
            }
		}

        if (Common.input.getGamepad(0).check(Controls.DPAD_UP)) {

            tile.y -= 2;
		}

		if (Common.input.getGamepad(0).check(Controls.DPAD_DOWN)) {

            tile.y += 2;
		}

		if (Common.input.getGamepad(0).check(Controls.DPAD_LEFT)) {

			tile.x -= 2;
		}

		if (Common.input.getGamepad(0).check(Controls.DPAD_RIGHT)) {

            tile.x += 2;
		}
    }
}