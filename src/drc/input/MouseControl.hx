package drc.input;

@:enum abstract MouseControl(Int) from Int to Int {
	
	var leftClick = 0;
	
	var middleClick = 1;
	
	var rightClick = 2;
}