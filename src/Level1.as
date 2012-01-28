package  
{
	import org.flixel.*;

	public class Level1 extends Level
	{
		[Embed(source = "../assets/csv/lvl1/mapCSV_Level1_Background.csv", mimeType = "application/octet-stream")] public var backgroundCSV:Class;
		[Embed(source = "../assets/csv/lvl1/mapCSV_Level1_Map.csv", mimeType = "application/octet-stream")] public var mapCSV:Class;
		[Embed(source = "../assets/csv/lvl1/mapCSV_Level1_Carrots.csv", mimeType = "application/octet-stream")] public var carrotsCSV:Class;
		[Embed(source = "../assets/csv/lvl1/mapCSV_Level1_Switches.csv", mimeType = "application/octet-stream")] public var switchesCSV:Class;
		
		[Embed(source = "../assets/textures/tiles/background.png")] public var backgroundTilesPNG:Class;
		[Embed(source = "../assets/textures/tiles/maintiles.png")] public var mapTilesPNG:Class;
		[Embed(source = "../assets/textures/tiles/carrot.png")] public var carrotPNG:Class;
		[Embed(source = "../assets/textures/tiles/switch.png")] public var switchPNG:Class;
		
		public var background:FlxTilemap;
		public var map:FlxTilemap;
		
		public var carrots:FlxGroup;
		public var totalCarrots:int;
		
		public var switches:FlxGroup;
		public var totalSwitches:int;
		
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
			
			totalCarrots = 0;
			parseCarrots();
			Registry.carrots = carrots;
			Registry.totalCarrots = totalCarrots;
			
			totalSwitches = 0;
			parseSwitches();
			Registry.switches = switches;
			Registry.totalSwitches = totalSwitches;
		}
		
		override public function update():void {
			if (Registry.openExit) {
				openExit();
			}
			super.update();
		}
		
		private function addBlops():void
		{
			blops = new Blops;

			blops.addBlop(128, 96);
		}
		
		public function openExit():void
		{
			//Remove the blocking tiles on the right of the map and sets them to nothing, so the players can walk through
			map.setTile(31, 1, 0, true);
			map.setTile(31, 2, 0, true);
			map.setTile(31, 3, 0, true);
			map.setTile(31, 4, 0, true);
			map.setTile(31, 5, 0, true);
			map.setTile(31, 6, 0, true);
		}
		
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
		
		private function parseSwitches():void
		{
			var switchesMap:FlxTilemap = new FlxTilemap();
			
			switchesMap.loadMap(new switchesCSV, switchPNG, 16, 16);
			
			switches = new FlxGroup();
			
			for (var ty:int = 0; ty < switchesMap.heightInTiles; ty++)
			{
				for (var tx:int = 0; tx < switchesMap.widthInTiles; tx++)
				{
					if (switchesMap.getTile(tx, ty) == 1)
					{
						switches.add(new Switch(tx, ty));
						totalSwitches++;
					}
				}
			}
		}
		
	}
}