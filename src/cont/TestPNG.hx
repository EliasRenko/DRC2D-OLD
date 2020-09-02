package cont;

import drc.data.Profile;
import drc.utils.Resources;
import drc.display.Image;
import drc.utils.Common;
import drc.objects.State;

class TestPNG extends State {

    private var __image:Image;

    public function new() {
        
        super();

        //var path = Resources.path();

        //var io = File.read(path + "res/graphics/grid_bw.png", true);

        //var _data:format.png.Data = new format.png.Reader(io).read();

        //var _header = format.png.Tools.getHeader(_data);

        //var _bytes = format.png.Tools.extract32(_data);

        var pro = Common.res.loadTexture("res/graphics/db32.png");

        pro.onComplete(function(result:drc.data.Texture, type:UInt) {

            var _prof = Resources.getProfile("res/profiles/texture.json");

            var _prom = Common.res.getProfile('res/profiles/default.json');

            __image = new Image(_prom, [result]);

            addGraphic(__image);

            trace('time: ' + pro.time);
        });
        
        //var t:drc.data.Texture = new drc.backend.native.data.Texture(UInt8Array.fromBytes(_bytes));

        //__image = new Image(_prof, [t]);

        //addGraphic(__image);
    }
}