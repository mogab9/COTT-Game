package  
{
	import flash.display.Graphics;
	import flash.ui.Mouse;
	
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{
		private var player:Player;
		private var player2:Player;
		private var player3:Player;
		private var player4:Player;
		
		private var floor:FlxTileblock;
		private var platform:FlxTileblock;
		
		protected var levelOne:BaseLevel;
		
		//Pause
		private var title:FlxText;
		private var playButton:FlxButton;
		
		public function PlayState() 
		{
		}
		
		protected function onSpriteAddedCallback(sprite:FlxSprite, group:FlxGroup):void {
			if (sprite is Player) {
				//player = sprite as Player;
			}
		}
		
		override public function create():void
		{

			
			levelOne = new Level_levelOne(true, onSpriteAddedCallback);
			//FlxG.bgColor = 0xff144954;
			
			//player = new Player(32, 100);
			//player2 = new Player(64, 100);
			//player3 = new Player(96, 100);
			//player4 = new Player(128, 100);
			//FlxG.camera.follow(player);
			
			
			//floor = new FlxTileblock(0, 208, 320, 32);
			//floor.makeGraphic(320, 32, 0xff689c16);
			
			//platform = new FlxTileblock(100, 160, 128, 16);
			//platform.makeGraphic(128, 16, 0xff689c16);
			
			//add(player);
			//add(player2);
			//add(player3);
			//add(player4);
			//add(floor);
			//add(platform);
            
			//	These are debugger watches. Bring up the debug console (the ' key by default) and you'll see their values in real-time as you play
			//FlxG.watch(player.acceleration, "x", "ax");
			//FlxG.watch(player.velocity, "x", "vx");
			//FlxG.watch(player.velocity, "y", "vy");
			
//-----------------------Creation of the Pause Menu-----------------------
			//title
			title = new FlxText(0, 16, FlxG.width, "Pause");
			title.setFormat (null, 16, 0xFFFFFFFF, "center");
			
			//Back
			//playButton = new FlxButton(FlxG.width/2-40, FlxG.height/2, "Play", pressBackGame);
			playButton = new FlxButton(0, -2, "Play", pressBackGame);
			
//-------------------------------------------------------------------------
			
		}
		
		override public function update():void
		{
			//We check the Escape key to display (or not) the Pause menu
			if (FlxG.keys.justPressed("ESCAPE")){
				FlxG.paused = !FlxG.paused;
				trace("pause menu");
				if(!FlxG.paused){ 
					this.remove(playButton);
					this.remove(title);
				}
				else{
					this.add(playButton);
					this.add(title)
					flash.ui.Mouse.show();
				}
			}
			
			if (!FlxG.paused) {
				super.update();
				FlxG.collide(player, levelOne.mainLayer);
				/*
				FlxG.collide(player, floor);
				FlxG.collide(player, platform);
				
				FlxG.collide(player2, floor);
				FlxG.collide(player2, platform);
				
				FlxG.collide(player3, floor);
				FlxG.collide(player3, platform);
				
				FlxG.collide(player4, floor);
				FlxG.collide(player4, platform);
				*/
			}
		}
		
		private function pressBackGame():void{
			FlxG.paused = false;
			this.remove(playButton);
			this.remove(title);
		}
		
	}

}