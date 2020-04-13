package drc.graphics;

import drc.display.Shading;
import drc.data.BitmapData;
import drc.display.Profile;
import drc.display.Graphic;

class Tilemap extends Graphic {

	/** Publics. **/

	public var tiles:Array<Tile> = new Array<Tile>();

	/** Privates. **/

	private var __activeVertices:Int;

    public function new(profile:Profile, bitmapData:BitmapData) {

        super(profile);

        textures = new Array<BitmapData>();

        textures[0] = bitmapData;

		for (i in 0...profile.attributes.length) {

			for (j in 0...profile.attributes[i].__pointers.length) {

				var _name:String = profile.attributes[i].__pointers[j].name;

				var _pos:Int = profile.attributes[i].__pointers[j].position;

				var _positions:Array<Int> = new Array<Int>();

				var sum:Int = _pos;

				for (i in 0...4) {

					_positions.push(sum);

					sum += profile.dataPerVertex;
				}

				var shading:Shading =
				{
					positions: _positions
				}

				shadings.set(_name, shading);
			}
		}
	}
	
	public function addTile(tile:Tile):Tile {

		tiles.push(tile);
		
		__updateIndices();
		
		//** Return.
		
		return tile;
	}

	override public function render():Void {
		
		__activeVertices = -1;

		__indicesToRender = 0;

		for (i in 0...tiles.length) {
			
			if (tiles[i].visible) {

				tiles[i].render();

				for (vertexData in 0...tiles[i].vertices.innerData.length)
				{
					__activeVertices ++;
					
					//** Push the vertex data in the tilemap.
					
					vertices.innerData[__activeVertices] = tiles[i].vertices.innerData[vertexData];
				}
				
				__verticesToRender += 4;
				
				__indicesToRender += 6;
			}
		}
	}

	private function __updateIndices():Void {

		var position:Int = 4 * (tiles.length - 1);
		
		indices.add(position);
		
		indices.add(position + 1);
		
		indices.add(position + 2);
		
		indices.add(position);
		
		indices.add(position + 2);
		
		indices.add(position + 3);
	}
}