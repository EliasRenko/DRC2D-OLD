package;

import cont.TestCharmap;
import cont.TestForm;
import drc.core.App;

class Main 
{
	public static function main() 
	{
		var app:App = new App();
		
		app.addState(new TestForm());
		
		app.run();
	}
}