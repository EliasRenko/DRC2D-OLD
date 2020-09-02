package editor;

import drc.data.Profile;
import drc.data.Texture;
import drc.display.Tilemap;
import drc.display.Tileset;

class Layer extends Tilemap {

    public function new(profile:Profile, textures:Array<Texture>, ?tileset:Tileset) {

        super(profile, textures, tileset);
    }
}