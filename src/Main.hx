package;

import cont.TestCanvas;
import cont.TestTilemap;
import drc.core.App;

class Main 
{
	public static function main() 
	{
		var app:App = new App();
		
		app.addState(new TestTilemap());
		
		app.init();
	}
}