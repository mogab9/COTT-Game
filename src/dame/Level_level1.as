//Code generated with DAME. http://www.dambots.com

package 
{
	import org.flixel.*;
	public class Level_level1 extends BaseLevelDAME
	{
		//Embedded media...
		[Embed(source="../../assets/csv/dame/mapCSV_Level1_Background.csv", mimeType="application/octet-stream")] public var CSV_Level1Background:Class;
		[Embed(source="../../assets/textures/tiles/background.png")] public var Img_Level1Background:Class;
		[Embed(source="../../assets/csv/dame/mapCSV_Level1_Map.csv", mimeType="application/octet-stream")] public var CSV_Level1Map:Class;
		[Embed(source="../../assets/textures/tiles/maintiles.png")] public var Img_Level1Map:Class;
		[Embed(source="../../assets/csv/dame/mapCSV_Level1_Carrots.csv", mimeType="application/octet-stream")] public var CSV_Level1Carrots:Class;
		[Embed(source="../../assets/textures/tiles/carrot.png")] public var Img_Level1Carrots:Class;
		[Embed(source="../../assets/csv/dame/mapCSV_Level1_Switches.csv", mimeType="application/octet-stream")] public var CSV_Level1Switches:Class;
		[Embed(source="../../assets/textures/tiles/switch.png")] public var Img_Level1Switches:Class;

		//Tilemaps
		public var layerLevel1Background:FlxTilemap;
		public var layerLevel1Map:FlxTilemap;
		public var layerLevel1Carrots:FlxTilemap;
		public var layerLevel1Switches:FlxTilemap;

		//Sprites
		public var ObjectsRabbitsGroup:FlxGroup = new FlxGroup;
		public var ObjectsExitGroup:FlxGroup = new FlxGroup;
		public var ObjectsEnnemiesGroup:FlxGroup = new FlxGroup;


		public function Level_level1(addToStage:Boolean = true, onAddSpritesCallback:Function = null)
		{
			// Generate maps.
			layerLevel1Background = new FlxTilemap;
			layerLevel1Background.loadMap( new CSV_Level1Background, Img_Level1Background, 192,336, FlxTilemap.OFF, 0, 1, 1 );
			layerLevel1Background.x = 0.000000;
			layerLevel1Background.y = 0.000000;
			layerLevel1Background.scrollFactor.x = 1.000000;
			layerLevel1Background.scrollFactor.y = 1.000000;
			layerLevel1Map = new FlxTilemap;
			layerLevel1Map.loadMap( new CSV_Level1Map, Img_Level1Map, 16,16, FlxTilemap.OFF, 0, 1, 1 );
			layerLevel1Map.x = 0.000000;
			layerLevel1Map.y = 0.000000;
			layerLevel1Map.scrollFactor.x = 1.000000;
			layerLevel1Map.scrollFactor.y = 1.000000;
			layerLevel1Carrots = new FlxTilemap;
			layerLevel1Carrots.loadMap( new CSV_Level1Carrots, Img_Level1Carrots, 16,16, FlxTilemap.OFF, 0, 1, 1 );
			layerLevel1Carrots.x = 0.000000;
			layerLevel1Carrots.y = 0.000000;
			layerLevel1Carrots.scrollFactor.x = 1.000000;
			layerLevel1Carrots.scrollFactor.y = 1.000000;
			layerLevel1Switches = new FlxTilemap;
			layerLevel1Switches.loadMap( new CSV_Level1Switches, Img_Level1Switches, 16,16, FlxTilemap.OFF, 0, 1, 1 );
			layerLevel1Switches.x = 0.000000;
			layerLevel1Switches.y = 0.000000;
			layerLevel1Switches.scrollFactor.x = 1.000000;
			layerLevel1Switches.scrollFactor.y = 1.000000;

			//Add layers to the master group in correct order.
			masterLayer.add(layerLevel1Background);
			masterLayer.add(layerLevel1Map);
			masterLayer.add(layerLevel1Carrots);
			masterLayer.add(layerLevel1Switches);
			masterLayer.add(ObjectsRabbitsGroup);
			masterLayer.add(ObjectsExitGroup);
			masterLayer.add(ObjectsEnnemiesGroup);


			if ( addToStage )
			{
				addSpritesForLayerObjectsRabbits(onAddSpritesCallback);
				addSpritesForLayerObjectsExit(onAddSpritesCallback);
				addSpritesForLayerObjectsEnnemies(onAddSpritesCallback);
				FlxG.state.add(masterLayer);
			}

			mainLayer = layerMainLayer;

			boundsMinX = 0;
			boundsMinY = 0;
			boundsMaxX = 576;
			boundsMaxY = 336;

		}

		override public function addSpritesForLayerObjectsRabbits(onAddCallback:Function = null):void
		{
			addSpriteToLayer(Player, ObjectsRabbitsGroup , 80.000, 48.000, 0.000, false, 1, 1, onAddCallback );//"Rabbit"
			addSpriteToLayer(FireRabbit, ObjectsRabbitsGroup , 208.000, 112.000, 0.000, false, 1, 1, onAddCallback );//"FireRabbit"
		}

		override public function addSpritesForLayerObjectsExit(onAddCallback:Function = null):void
		{
			addSpriteToLayer(Exit, ObjectsExitGroup , 544.000, 32.000, 0.000, false, 1, 1, onAddCallback );//"ExitDoor"
		}

		override public function addSpritesForLayerObjectsEnnemies(onAddCallback:Function = null):void
		{
			addSpriteToLayer(Blop, ObjectsEnnemiesGroup , 128.000, 96.000, 0.000, false, 1, 1, onAddCallback );//"Blop"
		}


	}
}
