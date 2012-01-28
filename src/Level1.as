package  
{
	import org.flixel.*;

	public class Level1 extends Level
	{
		[Embed(source = "../assets/csv/lvl1/mapCSV_Level1_Background.csv", mimeType = "application/octet-stream")] public var backgroundCSV:Class;
		[Embed(source = "../assets/csv/lvl1/mapCSV_Level1_Map.csv", mimeType = "application/octet-stream")] public var mapCSV:Class;
		[Embed(source = "../assets/csv/lvl1/mapCSV_Level1_Carrots.csv", mimeType = "application/octet-stream")] public var carrotsCSV:Class;
		[Embed(source = "../assets/textures/tiles/background.png")] public var backgroundTilesPNG:Class;
		[Embed(source = "../assets/textures/tiles/maintiles.png")] public var mapTilesPNG:Class;
		[Embed(source = "../assets/textures/tiles/carrot.png")] public var carrotPNG:Class;
		
		public var background:FlxTilemap;
		public var map:FlxTilemap;
		
		public var carrots:FlxGroup;
		public var totalCarrots:int;
		
		public var blops:Blops;
		
		//private var elevator1:Elevator;
		//private var elevator2:Elevator;
		
		//public var width:int; // now in Level Class
		//public var height:int; // now in Level Class
		
		public function Level1(skipBlops:Boolean = false) 
		{
			super();
			
			background = new FlxTilemap;
			background.loadMap(new backgroundCSV, backgroundTilesPNG, 192, 336);
			background.setTileProperties(1, FlxObject.NONE);
			background.scrollFactor.x = 0.9;
			
			map = new FlxTilemap;
			map.loadMap(new mapCSV, mapTilesPNG, 16, 16, FlxTilemap.OFF, 0, 1, 1);
			
			Registry.map = map;
			
			//	Makes these tiles as allowed to be jumped UP through (but collide at all other angles)
			map.setTileProperties(40, FlxObject.UP, null, null, 4);
				
			width = map.width;
			height = map.height;
			
			//elevator1 = new Elevator(26, 6, 10, 0);
			//elevator2 = new Elevator(82, 6, 0, 7);
			
			add(background);
			
			var exit:Exit = new Exit(544+2, 48-14);
			Registry.levelExit = new FlxPoint(544, 48);
			add(exit);
			
			
			add(map);
			if (!skipBlops) {			
				addBlops();
				Registry.blops = blops;
			}
			//add(elevator1);
			//add(elevator2);
			
			parseCarrots();
			Registry.carrots = carrots;
			Registry.totalCarrots = totalCarrots;
		}
		
		private function addBlops():void
		{
			blops = new Blops;

			blops.addBlop(128, 96);
		}
		
		/*public function openExit():void
		{
			//	Removes the two blocking tiles on the right of the map and sets them to nothing, so the player can walk through
			map.setTile(98, 16, 0, true);
			map.setTile(99, 16, 0, true);
		}*/
		
		private function parseCarrots():void
		{
			var carrotsMap:FlxTilemap = new FlxTilemap();
			
			carrotsMap.loadMap(new carrotsCSV, carrotPNG, 16, 16);
			
			carrots = new FlxGroup();
			
			for (var ty:int = 0; ty < carrotsMap.heightInTiles; ty++)
			{
				for (var tx:int = 0; tx < carrotsMap.widthInTiles; tx++)
				{
					if (carrotsMap.getTile(tx, ty) == 1)
					{
						carrots.add(new Carrot(tx, ty));
						totalCarrots++;
					}
				}
			}
		}		
	}

}