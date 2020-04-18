package cont;

import drc.display.Tileset;
import drc.display.Image;
import drc.objects.State;
import drc.data.Profile;
import drc.utils.Common;
import drc.utils.Resources;
import drc.input.Control;
import drc.display.Tilemap;
import drc.display.Tile;
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

        addGraphic(tilemap);
    }

    override function render():Void {

        super.render();

        //tilemap.render();

        //Common.stage.draw(tilemap);
    }

    override function update():Void
	{
        super.update();
		
		if (Common.input.mouse.pressed(1))
		{
			if (Common.input.mouse.doubleClick)
			{
				tile.id += 1;
			}
		}
		
        //return;

        //if (Common.input.getGamepad(0).check(Control.A)) {
//
            //for (tile in tilemap.tiles) {
//
                //tile.angle += 1;
            //}
        //}
        //
        //if (Common.input.getGamepad(0).pressed(Control.B)) {
//
            //for (tile in tilemap.tiles) {
//
                //tile.id += 1;
            //}
		//}
		
		if (Common.input.getGamepad(0).check(Control.A)) {

            Common.stage.width -= 1;
			
            Common.stage.height -= 1;
		}

		if (Common.input.getGamepad(0).check(Control.X)) {

            Common.stage.width += 1;
			
            Common.stage.height += 1;
		}

        if (Common.input.getGamepad(0).check(Control.DPAD_UP)) {

            tile.y -= 2;
		}

		if (Common.input.getGamepad(0).check(Control.DPAD_DOWN)) {

            tile.y += 2;
		}

		if (Common.input.getGamepad(0).check(Control.DPAD_LEFT)) {

			tile.x -= 2;
		}

		if (Common.input.getGamepad(0).check(Control.DPAD_RIGHT)) {

            tile.x += 2;
		}
    }
}