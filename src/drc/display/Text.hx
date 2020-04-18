package drc.display;

import drc.display.Tile;

class Text extends Graphic
{
	//** Publics.
	
	public var align(get, set):UInt;
	
	public var parent(get, set):Charmap;
	
	/**
	 * The 
	 */
	public var fieldWidth(get, set):Float; //** Define metadata isVar.
	
	/**
	 * The space between lines.
	 */
	public var leading:Int = 20;
	
	/**
	 * The number of lines the text has.
	 */
	@:isVar
	public var lines(get, null):Int; //** Define metadata isVar.
	
	/**
	 * The space between words.
	 */
	public var spacing:Int = 6;
	
	/**
	 * The string value of the text.
	 */
	@:isVar
	public var text(get, set):String; //** Define metadata isVar.
	
	/**
	 * The space between letters.
	 */
	public var tracking:Int = 1;
	
	/**
	 * The y position of the text in space.
	 */
	@:isVar
	public var wordwrap:Bool = false; //** Define metadata isVar.
	
	//** Privates.
	
	/** @private */ private var __align:UInt = 1;
	
	/** @private */ private var __fieldWidth:Float = 300;
	
	/** @private */ private var __lines:Int = 0;
	
	/** @private */ public var __characters:Array<Tile> = new Array<Tile>();
	
	/** @private */ private var __text:String = "";
	
	/** @private */ private var __parent:Charmap;
	
	/** @private */ private var __lineBreak:Array<UInt> = new Array<UInt>();
	
	/** @private */ private var __lineStart:Array<Float> = new Array<Float>();
	
	/** @private */ private var __transition:UInt = 4;
	
	public function new(parent:Charmap, value:String, x:Float = 0, y:Float = 0) 
	{
		super(x, y);

		__parent = parent;
		
		text = value;
		
		if (parent != null)
		{
			tracking = parent.defaultKerning;
			
			return;
		}
		
		tracking = 1;
	}
	
	public function clear():Void
	{
		for (i in 0...__characters.length)
		{
			parent.tiles.pop();
			
			__characters.pop();
		}
	}
	
	// ** Getters and setters.
	
	private function get_align():UInt
	{
		return __align;
	}
	
	private function set_align(value:UInt):UInt
	{
		return __align = value;
	}
	
	private function get_fieldWidth():Float
	{
		return __fieldWidth;
	}
	
	private function set_fieldWidth(value:Float):Float
	{
		__fieldWidth = value;
		
		set_text(__text);
		
		return value;
	}
	
	private function get_lines():Int
	{
		return __lines;
	}
	
	private function get_text():String
	{
		return __text;
	}
	
	override function setAttribute(name:String, value:Float):Void
	{
		for (i in 0...__characters.length)
		{
			__characters[i].setAttribute(name, value);
			
			//trace("AT");
		}
	}

	public function addToParent():Void 
	{
		__active = true;
		
		for (i in 0...__characters.length)
		{
			__parent.addTile(__characters[i]);
		}
	}

	public function dispose():Void {
		
		for (i in 0...__characters.length)
		{
			parent.removeTile(__characters[__characters.length - 1]);
			
			__characters.pop();
		}
	}
	
	@:access(drc.graphics.DrcCharMap) //** Define metadata access.
	private function setPosition():Void
	{
		#if debug // ------
		
		if (__align > 2)
		{
			//** Get the name of the class.
			
			var className = Type.getClassName(Type.getClass(this));
			
			//** Throw error!
			
			//DrcConsole.showTrace("Class: " + className + " with string " + __text + ", cannot be aligned properly.");
		}
		
		#end // ------
		
		__lines = 0;
		
		var lineX:Float = __lineStart[__lines];
		
		
		//var lineX:Float = 0;
		
		var lineY:Float = 0;
		
		var lineWidth:Int = 0;
		
		var track:Int = 0;
		
		//trace(__lineStart);
		
		for (i in 0...__characters.length)
		{
			var track:Int = 0;
			
			if (wordwrap)
			{
				if (i == __lineBreak[__lines])
				{
					__lines ++;
					
					switch (__align) 
					{
						case 1:	
						
							lineX = __lineStart[__lines];
							
							//trace(lineX);
							
						default:
							
					}
					
					//lineX = 0;
					
					lineY += leading;
				}
			}
			
			var tile:Tile = __characters[i];
			
			tile.x = __x;
			
			tile.y = __y;
			
			tile.z = __z;
			
			tile.offsetX = lineX;
			
			trace(tile.id);

			tile.offsetY = lineY + parent.tileset.regions[tile.id].values[5];
			//tile.offsetY = __y + lineY;
			
			var next:UInt = text.charCodeAt(i + 1);
				
				if (next == 32)
				{
					track = 0;
				}
				else
				{
					if (parent.useKerningPairs)
					{
						//if (parent.kernings[tile.id] != null)
						//{
							//track = parent.kernings[tile.id].getValue(next); //TO-DO:KERNINGS
						//}
						
						//if (track == null)
						//{
							//track = 0;
						//}
						
						track = 0; //** PLACEHOLDER
					}
					
					track += tracking;
					
					//track += tracking;
					
					//track = tracking;
				}
				
			if (tile.id == 32)
			{
				tile.width = spacing;
				
				tile.offsetY += 12;
				
				track = 0;
			}
			
			lineX += tile.width + track;
		}
		
		if (!wordwrap)
		{
			__fieldWidth = lineX;
		}
	}
	
	@:access(drc.graphics.DrcCharMap) //** Define metadata access.
	private function set_text(text:String):String
	{
		if (__characters.length > text.length)
		{
			for (g in 0...__characters.length - text.length)
			{
				parent.tiles.pop();
				
				__characters.pop();
			}
		}
		
		for (k in 0...__lineBreak.length)
		{
			__lineBreak.pop();
		}
		
		for (o in 0...__lineStart.length)
		{
			__lineStart.pop();
		}
		
		__text = text;
		
		var lineWidth:Float = 0;
		
		var track:Int;
		
		var trueWidth:Float = 0;
		
		var word:Int = -1;
		
		for (i in 0...__text.length)
		{
			var id:UInt = __text.charCodeAt(i);
			
			var tile:Tile;
			
			if (i > __characters.length - 1)
			{
				tile = new Tile(parent, 0, 0, id);
				
				parent.addTile(tile);
				
				__characters.push(tile);
			}
			else 
			{
				tile = __characters[i];
				
				tile.id = id;
			}
			
			//tile.x = __x;
			
			//tile.y = __y;
			
			tile.visible = __visible;
			
			//tile = new DrcTile(__parent, id);
				//
				////__parent.addTile(tile);
				//
				//__characters[i] = __parent.addTile(tile);
			
			track = 0;
			
			word ++;
			
			//track = tracking;
			
			var next:UInt = __text.charCodeAt(i + 1);
			
			if (next != 32)
			{
				if (parent.useKerningPairs)
				{
					//if (parent.kernings[id] != null)
					//{
						//track = parent.kernings[id].getValue(next);
					//}
					//
					//if (track == null)
					//{
						//track = 0;
					//}
					//
					//trace("Kerning Pairs"); //TO-DO:KERNINGS
				}
				
				track += tracking;
				
				//track += tracking;
			}
			else
			{
				//track += tracking;
			}
			
			if (id == 32)
			{
				word = -1;
				
				tile.width = spacing;
				
				tile.height = 4;
				
				//tile.setAttribute("r", 0.2);
				//tile.setAttribute("g", 0.2); // DEBUG!!
				
				trueWidth = lineWidth + spacing;
				//trueWidth = lineWidth;
				
				track = 0;
			}
			
			lineWidth += tile.width + track;
			
			if (lineWidth > __fieldWidth)
			{
				__lineBreak.push((i - word));
				
				__lineStart.push(0);
				//__lineStart.push((fieldWidth - trueWidth) + spacing);
				//__lineStart.push(Math.round(((fieldWidth - trueWidth) + spacing) / 2));
				
				lineWidth = lineWidth - trueWidth;
				
				var start:Int = 0;
				
				var tileBreak:Tile = __characters[i - word];
				
				//tileBreak.setAttribute("r", 0.2);
				//tileBreak.setAttribute("b", 0.2); // DEBUG!!
				
				//tile.setAttribute("r", 0.2);
				//tile.setAttribute("b", 0.2); // DEBUG!!
				
				//
				//if (text.charCodeAt((i - word)) == 32)
				//{
					//trace(text.charAt((i - word)));
					//
					//start -= spacing;
					//
					//lineWidth = start;
				//}
				
				//__lineStart.push(start);
			}
			
			
			
			
			//** Add the tile to it's parent.
		}
		
		__lineStart.push(0);
		//__lineStart.push((fieldWidth - lineWidth));
		//__lineStart.push(Math.round(((fieldWidth - lineWidth)) / 2));
		
		setPosition();
		
		//trace(__lineStart);
		//trace(__lineStart);
		//trace(__characters.length);
		for (w in 0...__characters.length)
		{
			//trace(__characters[w].id);
		}
		
		return __text;
	}
	
	private function get_parent():Charmap
	{
		return __parent;
	}
	
	private function set_parent(parent:Charmap):Charmap
	{
		if (__parent != null)
		{
			clear();
			
			tracking = parent.defaultKerning;
		}
		
		text = __text;
		
		__parent = parent;
		
		//** Return.
		
		return __parent;
	}
	
	override private function set_visible(value:Bool):Bool
	{
		for (i in 0...__characters.length)
		{
			__characters[i].visible = value;
		}
		
		return __visible = value;
	}
	
	override private function set_x(value:Float):Float
	{
		for (i in 0...__characters.length) 
		{
			__characters[i].x = value;
		}
		
		return __x = value;
	}
	
	override private function set_y(value:Float):Float
	{
		for (i in 0...__characters.length) 
		{
			__characters[i].y = value;
		}
		
		return __y = value;
	}
	
	override private function set_z(value:Float):Float
	{
		for (i in 0...__characters.length) 
		{
			__characters[i].z = value;
		}
		
		return __z = value;
	}
}