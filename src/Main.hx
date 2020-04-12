package;

import cont.TestCanvas;
import drc.core.App;

class Main 
{
	public static function main() 
	{
		var app:App = new App();
		
		app.addState(new TestCanvas());
		
		app.init();
	}
}