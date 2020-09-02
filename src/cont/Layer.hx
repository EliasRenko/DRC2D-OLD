package cont;

import drc.display.Region;
import drc.utils.Resources;
import drc.data.Profile;
import drc.display.Tilemap;
import drc.display.Tile;

class Layer {

    // ** Publics.

    public var tilemap:Tilemap;

    public var tiles:Array<Tile> = new Array<Tile>();

    public var profile:Profile;

    public var tileWidth:Int = 32;

    public var tileHeight:Int = 32;

    public var widthInTiles:UInt = 20;

    public var heightInTiles:UInt = 15;

    public function new() {

        profile = Resources.getProfile("res/profiles/texture.json");

        tilemap = new Tilemap(profile, [Resources.loadTexture("res/graphics/dev_tiles.png")]);

        tilemap.tileset.addRegion({values: [0, 0, 32, 32]});
        tilemap.tileset.addRegion({values: [32, 0, 32, 32]});
    }

    public function addTile(mouseX:Int, mouseY:Int):Void {

        var xPos:Int = Std.int(((mouseX - (mouseX % tileWidth))));
				
        var yPos:Int = Std.int(((mouseY - (mouseY % tileHeight))));
        
        var tileX:Int = Std.int(((mouseX - (mouseX % tileWidth)) / tileWidth));
        
        var tileY:Int = Std.int(((mouseY - (mouseY % tileHeight))  / tileHeight));

        var tile:Tile = new Tile(tilemap, 0, xPos, yPos);

        var position:Int = (tileY * widthInTiles) + tileX;

        if (tiles[position] == null) {

            tiles[position] = tile;

            tilemap.addTile(tile);
        }
        else {


        }
    }

    public function removeTile(x:Int, y:Int):Void {
        
    }
}