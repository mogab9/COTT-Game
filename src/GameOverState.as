package  
{
	import org.flixel.*;
	
	public class GameOverState extends FlxState
	{
		[Embed(source = "../assets/csv/end/mapCSV_LevelEnd_Sky.csv", mimeType = "application/octet-stream")] public var skyCSV:Class;
		[Embed(source = "../assets/textures/tiles/background.png")] public var skyTilesPNG:Class;
		[Embed(source = "../assets/textures/elements/blop.png")] public var starPNG:Class;
		
		private var sky:FlxTilemap;
		private var won:FlxText;
		private var stars:FlxEmitter;

		public function GameOverState() 
		{
		}
		
		override public function create():void
		{
			//sky = new FlxTilemap;
			//sky.loadMap(new skyCSV, skyTilesPNG, 192, 336);
			
			won = new FlxText(0, 80, 320, "- GAME OVER! -");
			won.scale.x = 4;
			won.scale.y = 4;
			won.alignment = "center";
			won.shadow = 0xff000000;
			won.scrollFactor.x = 0;
			won.scrollFactor.y = 0;
			
			stars = new FlxEmitter;
			stars.x = 160;
			stars.y = 100;
			stars.setXSpeed( -100, 100);
			stars.setYSpeed( -200, 0);
			stars.setRotation( 0, 0);
			stars.gravity = 150;
			stars.makeParticles(starPNG, 100, 0, false, 0);
			
			FlxG.playMusic(titleMusicMP3, 1);
			
			stars.start(false, 4, 0.1);
			
			add(sky);
			add(stars);
			add(won);
		}
		
		override public function update():void
		{
			super.update();
			
			if (FlxG.keys.any())
			{
				FlxG.fade(0xff000000, 2, changeState);
				FlxG.music.fadeOut(2);
			}
		}
		
		private function changeState():void
		{
			FlxG.switchState(new MainMenuState);
		}
		
		override public function destroy():void
		{
			super.destroy();
		}
		
	}

}