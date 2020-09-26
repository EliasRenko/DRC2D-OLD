package drc.utils;

import drc.core.App;
import drc.core.Context;
import drc.system.Input;
import drc.system.Window;
import drc.display.Stage;
import drc.utils.Assets;
import drc.utils.Res;

class Common {

	public static var app:App;

	#if cpp

	public static var assets:Assets;

	#end

	public static var stage:Stage;

	public static var context:Context;
	
	public static var input:Input;

	public static var window:Window;

	public static var res:Res;
}