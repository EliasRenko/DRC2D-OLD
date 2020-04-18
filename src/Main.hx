package;

import cont.TestTilemap;
import cont.TestCharmap;
import drc.core.App;

class Main 
{
	public static function main() 
	{
		var app:App = new App();
		
		app.addState(new TestCharmap());
		
		app.run();
	}
}