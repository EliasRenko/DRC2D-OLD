package drc.display;

import drc.display.Shading;
import drc.data.Texture;
import drc.data.Profile;
import drc.display.Drawable;
import drc.display.Tile;
import drc.part.RecycleList;

class Tilemap extends Drawable {

	// ** Publics.

	public var tiles:RecycleList<Tile> = new RecycleList<Tile>();

	public var tileset:Tileset;

	// ** Privates.

	/** @private **/ private var __activeVertices:Int;

	// **

    public function new(profile:Profile, textures:Array<Texture>, ?tileset:Tileset) {

        super(profile);

		if (textures == null) {

		}
		else {

			if (textures.length == profile.textureCount) {

				this.textures = textures;
			}
			else {

				for (i in 0...textures.length) {

					this.textures[i] = textures[i];
				}
			}
		}

		if (tileset == null) {

			this.tileset = new Tileset();
		}
		else
		{
			this.tileset = tileset;
		}
	}
	
	public function addTile(tile:Tile):Tile {

		tiles.add(tile);
		
		__updateIndices();
		
		// ** Return.
		
		return tile;
	}

	public function getTile(index:Int):Tile
		{
			return tiles.getMember(index);
		}
		
		public function insert(tile:Tile):Tile
		{
			return tiles.insert(tile);
		}
		
		public function restore(tile:Tile):Bool
		{
			if (tiles.restore(tile))
			{
				__updateIndices();
				
				return true;
			}
			
			return false;
		}
		
		public function restoreAt(index:Int):Bool
		{
			if (tiles.restoreAt(index))
			{
				__updateIndices();
				
				return true;
			}
			
			return false;
		}
		
		public function recycle(tile:Tile):Bool
		{
			if (tiles.recycle(tile))
			{
				indices.pop(6);
				
				return true;
			}
			
			return false;
		}
		
		public function removeTile(tile:Tile):Void
		{
			//trace(tile.index);
			
			tiles.remove(tile);
			
			indices.pop(6);
		}
		
		public function removeTileAt(index:Int):Void
		{
			tiles.removeAt(index);
			
			indices.pop(6);
		}

	override public function render():Void {
		
		__activeVertices = -1;

		__indicesToRender = 0;

		tiles.forEachActive(__renderTile);
	}

	private function __renderTile(tile:Tile):Void {

		if (tile.visible) {

			tile.render();

			for (vertexData in 0...tile.vertices.innerData.length)
			{
				__activeVertices ++;
				
				// ** Push the vertex data in the tilemap.
				
				vertices.innerData[__activeVertices] = tile.vertices.innerData[vertexData];
			}
			
			__verticesToRender += 4;
			
			__indicesToRender += 6;
		}
	}

	private function __updateIndices():Void {

		var position:Int = 4 * (tiles.activeCount - 1);
		
		indices.add(position);
		
		indices.add(position + 1);
		
		indices.add(position + 2);
		
		indices.add(position);
		
		indices.add(position + 2);
		
		indices.add(position + 3);
	}
}