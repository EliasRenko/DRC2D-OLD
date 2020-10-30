package drc.utils;

import drc.core.App;

class EntryPoint {

    public static function main() {

		var _appRef = Type.resolveClass("Game");

		var _app:App = Type.createInstance(_appRef, []);

		if (_app == null) throw 'Main instance is null.';

		// ** Run the app.

		_app.run();
	}
}