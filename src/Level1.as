package  
{
	import org.flixel.*;

	public class Level1 extends Level
	{
		//[Embed(source = "../assets/mapCSV_Level1_Sky.csv", mimeType = "application/octet-stream")] public var skyCSV:Class;
		[Embed(source = "../assets/mapCSV_Level1_Map.csv", mimeType = "application/octet-stream")] public var mapCSV:Class;
		//[Embed(source = "../assets/mapCSV_Level1_Stars.csv", mimeType = "application/octet-stream")] public var starsCSV:Class;
		//[Embed(source = "../assets/backdrop.png")] public var skyTilesPNG:Class;
		[Embed(source = "../assets/tiles.png")] public var mapTilesPNG:Class;
		//[Embed(source = "../assets/star.png")] public var starPNG:Class;
		
		//public var sky:FlxTilemap;
		public var map:FlxTilemap;
		//public var stars:FlxGroup;
		//public var cats:Cats;
		
		//private var elevator1:Elevator;
		//private var elevator2:Elevator;
		
		//public var width:int; // in Level Class
		//public var height:int; // in Level Class
		//public var totalStars:int;
		
		public function Level1(/*skipCats:Boolean = false*/) 
		{
			super();
			
			//sky = new FlxTilemap;
			//sky.loadMap(new skyCSV, skyTilesPNG, 192, 336);
			//sky.setTileProperties(1, FlxObject.NONE);
			//sky.scrollFactor.x = 0.9;
			
			map = new FlxTilemap;
			map.loadMap(new mapCSV, mapTilesPNG, 16, 16,FlxTilemap.OFF, 0, 1, 1);
			
			//	Makes these tiles as allowed to be jumped UP through (but collide at all other angles)
			map.setTileProperties(40, FlxObject.UP, null, null, 4);
						
			var exit:Exit = new Exit(256, 176-16);
			add(exit);
			Registry.levelExit = new FlxPoint(256, 176);
			
			width = map.width;
			height = map.height;
			
			//elevator1 = new Elevator(26, 6, 10, 0);
			//elevator2 = new Elevator(82, 6, 0, 7);
			
			//add(sky);
			add(map);
			//add(elevator1);
			//add(elevator2);
			
			//parseStars();
			
			/*if (skipCats == false)
			{
				addCats();
			}*/
		}
		
		/*private function addCats():void
		{
			cats = new Cats;
			
			//	The 5 enemy cats in this level. You could place them in the map editor, then parse the results (as we do with the stars) rather than fixed coordinates here
			cats.addCat(11, 16);
			cats.addCat(31, 16);
			cats.addCat(28, 16);
			cats.addCat(74, 16);
			cats.addCat(92, 16);
		}*/
		
		/*public function openExit():void
		{
			//	Removes the two blocking tiles on the right of the map and sets them to nothing, so the player can walk through
			map.setTile(98, 16, 0, true);
			map.setTile(99, 16, 0, true);
		}*/
		
		/*private function parseStars():void
		{
			var starMap:FlxTilemap = new FlxTilemap();
			
			starMap.loadMap(new starsCSV, starPNG, 16, 16);
			
			stars = new FlxGroup();
			
			for (var ty:int = 0; ty < starMap.heightInTiles; ty++)
			{
				for (var tx:int = 0; tx < starMap.widthInTiles; tx++)
				{
					if (starMap.getTile(tx, ty) == 1)
					{
						stars.add(new Star(tx, ty));
						totalStars++;
					}
				}
			}
		}*/
		
	}

}