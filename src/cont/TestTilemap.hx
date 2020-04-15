package cont;

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

    //** Publics. **/

    public var tiles:Array<Tile> = new Array<Tile>();

    public var tilemap:Tilemap;

    public var profile:Profile;

    public var tile:Tile;

    //** Privates. **/

    private var __activeVertices:Int;

    public function new() {
        
        super();

        profile = Resources.getProfile("res/profiles/font.json");

        tilemap = new Tilemap(profile, Resources.loadFont('res/fonts/nokiafc22.png'));

        tile = new Tile(tilemap);

        tilemap.addTile(tile);
    }

    override function render():Void {

        tilemap.render();

        Common.stage.draw(tilemap);
    }

    override function update():Void {

        super.update();

        return;

        if (Common.input.getGamepad(0).check(Controls.A)) {

            for (tile in tilemap.tiles) {

                tile.angle += 1;
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