package  
{
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{
		private var player:Player;
		private var player2:Player;
		private var player3:Player;
		private var player4:Player;
		
		private var floor:FlxTileblock;
		private var platform:FlxTileblock;
		
		public function PlayState() 
		{
		}
		
		override public function create():void
		{
			FlxG.bgColor = 0xff144954;
			
			player = new Player(32, 100);
			player2 = new Player(64, 100);
			player3 = new Player(96, 100);
			player4 = new Player(128, 100);
			FlxG.camera.follow(player);
			
			
			floor = new FlxTileblock(0, 208, 320, 32);
			floor.makeGraphic(320, 32, 0xff689c16);
			
			platform = new FlxTileblock(100, 160, 128, 16);
			platform.makeGraphic(128, 16, 0xff689c16);
			
			add(player);
			add(player2);
			add(player3);
			add(player4);
			add(floor);
			add(platform);
            
			//	These are debugger watches. Bring up the debug console (the ' key by default) and you'll see their values in real-time as you play
			FlxG.watch(player.acceleration, "x", "ax");
			FlxG.watch(player.velocity, "x", "vx");
			FlxG.watch(player.velocity, "y", "vy");
			
		}
		
		override public function update():void
		{
			super.update();
			
			FlxG.collide(player, floor);
			FlxG.collide(player, platform);
			
			FlxG.collide(player2, floor);
			FlxG.collide(player2, platform);
			
			FlxG.collide(player3, floor);
			FlxG.collide(player3, platform);
			
			FlxG.collide(player4, floor);
			FlxG.collide(player4, platform);
			
		}
		
	}

}