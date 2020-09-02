package drc.utils;

#if cpp

import drc.backend.native.data.Texture;
import sys.FileSystem;
import stb.Image;
import sdl.SDL;

enum AssetType 
{
    TEXT;

    TEXTURE;

    SOUND;

    FONT;
}

class Assets {

    // ** Publics.

    //public var members:Array<__Asset>;

    public var members:Map<String, __Asset> = new Map<String, __Asset>();

    public function new() {

    }

    public function loadTexture(path:String) {

        var _asset:__Texture;

		var _data:StbImageData;

		if (FileSystem.exists(SDL.getBasePath() + path)) {

			_data = stb.Image.load(SDL.getBasePath() + path, 0);
		}
		else {

			_data = stb.Image.load(SDL.getBasePath() + 'res/graphics/grid_mt.png', 0);
		}

		//_texture = new Texture(_data);

		//return _texture;

        _asset = new __Texture(path, AssetType.TEXTURE, _data);

        members.set(path, _asset);
    }

    public function getTexture(name:String):Texture {

        //_data:StbImageData = members.

        var _texture = cast(members.get(name), __Texture);

        //return new Texture(_texture.data);

        return null;
    }

    public function add(name:String, type:AssetType):Void {
        
    }

    public function remove():Void {

    }
}

private class __Asset {

    // ** Publics.

    public var id:String;

    public var type:AssetType;

    // ** Privates.

    public function new(id:String, type:AssetType) {

        this.id = id;

        this.type = type;
    }
}

private class __Texture extends __Asset {

    public var data:StbImageData;

    public function new(id:String, type:AssetType, data:StbImageData) {

        super(id, type);

        this.data = data;
    }
}

#end