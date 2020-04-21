package derivation.states;

import drc.data.Profile;
import drc.utils.Resources;
import drc.display.Image;
import drc.objects.State;

class Playstate extends State {

    // ** Publics.

    public var background:Image;

    public function new() {

        super();

        var _profile:Profile = Resources.getProfile('res/profiles/texture.json');

        background = new Image(_profile, [Resources.loadTexture('res/graphics/collider.png')]);

        addGraphic(background);
    }

    override function update() {

        super.update();
    }
}