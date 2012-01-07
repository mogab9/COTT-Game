package  
{
	import flash.display.Graphics;
	import flash.ui.Mouse;
	import ui.DialogBox;
	
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{
		private var players:Array; // Array with Player
		private var exitDoor:Exit;
		protected var levelOne:BaseLevel;
		protected var endLevel:uint;
		
		private var m_tDialogBox:DialogBox;

		// Pause elements
		private var title:FlxText;
		private var playButton:FlxButton;
		
		// Render layers
		static private var s_layerForeground:FlxGroup;
		static private var s_layerOverlay:FlxGroup;
		public var pauseGroup:FlxGroup;
		public var endLevelGroup:FlxGroup;
		
		//HUD
		private var currentRabbit:FlxText;
		
		public function PlayState() {
		}
		
		protected function onSpriteAddedCallback(sprite:FlxSprite, group:FlxGroup):void {
			/*
			if (sprite is Player) {
				player = sprite as Player;
			}
			*/
		}
		
		override public function create():void
		{
			// --------Init-----------
			levelOne = new Level_levelOne(true, onSpriteAddedCallback);
			players = levelOne.masterLayer.members[1].members,
			exitDoor = levelOne.masterLayer.members[2].members[0];
			pauseGroup = new FlxGroup(); // pauseGroup 
			endLevelGroup = new FlxGroup(); // endLevelGroup 
			s_layerForeground = new FlxGroup;
			s_layerOverlay = new FlxGroup;
			
			//--------Pause Menu---------
			title = new FlxText(0, 16, FlxG.width, "Pause");
			title.setFormat (null, 16, 0xFFFFFFFF, "center");
			
			//playButton = new FlxButton(0, -2, "Play");
			playButton = new FlxButton(FlxG.width / 2 - 40, FlxG.height / 2, "Resume");

			playButton.onUp = function():void {
				trace("pressBackGame triggered");
				FlxG.paused = false;
			}
			pauseGroup.add(playButton);
			pauseGroup.add(title);
			
			//--------EndLevel Menu---------
			title = new FlxText(0, 16, FlxG.width, "Level Completed !");
			title.setFormat (null, 16, 0xFFFFFFFF, "center");
			
			playButton = new FlxButton(FlxG.width / 2 - 40, FlxG.height / 2, "Next Level");

			playButton.onUp = function():void {
				trace("pressNextLevel triggered");
			}
			endLevelGroup.add(playButton);
			endLevelGroup.add(title);
			
			//----------Dialog-----------
				//Init
			m_tDialogBox = new DialogBox;
			
				// Setting text
			m_tDialogBox.setText("Damned, we are trapped like rabbits!");
			
				// Adding to layers
			s_layerForeground.add(m_tDialogBox.m_aGraphics);
			
				// Activating
			m_tDialogBox.setIsActive(true);
			
			//----- Adding layers -------
			add(s_layerForeground);
			//add(pauseGroup):
			
			currentRabbit = new FlxText(5, 5, 100);
			currentRabbit.color = 0xffffffff;
			currentRabbit.shadow = 0xff000000;
			currentRabbit.scrollFactor.x = 0;
			currentRabbit.scrollFactor.y = 0;
			currentRabbit.text = "1";
			add(currentRabbit);
		}

		override public function update():void {
			//trace(FlxG.camera.screen.getScreenXY().x,FlxG.camera.screen.getScreenXY().y)
			//We check the Escape key to display (or not) the Pause menu
			//trace(levelOne.mainLayer.getScreenXY().x);
			//trace(levelOne.mainLayer.getScreenXY().y);
				
			/**
			 * check the end of the level
			 */
			endLevel = 1;
			for (var i:uint = 0 ; i < players.length ; i++)
			{
				if ( Math.abs(players[i].x - exitDoor.x) < 5 && Math.abs(players[i].y - exitDoor.y) < 5 ) 
					endLevel *= 1;
				else 
					endLevel *= 0;
			}
			if (endLevel == 1) 
			{
				//trace("The level is done. Congratulation !");
				// save if it's the 1rst time the level is completed
				// if ( ... ) 
					//LevelsCompleted.levels += 1;
				
				FlxG.paused = true;
				
				playButton.x = -levelOne.mainLayer.getScreenXY().x + (FlxG.width/2) - (playButton.width/2);
				playButton.y = -levelOne.mainLayer.getScreenXY().y + (FlxG.height / 2) - (playButton.height / 2);
				
				title.x = -levelOne.mainLayer.getScreenXY().x;
				title.y = -levelOne.mainLayer.getScreenXY().y + (playButton.height / 2);

				flash.ui.Mouse.show();
				return endLevelGroup.update();
				// goToNextLevel();
				
			}
			
			/*
			if(FlxG.keys.justPressed("W"))
			{
				spawnBullet(player[1].getBulletSpawnPosition(player[1].facing));
			}
			 */
			/**
			 * Pause
			 */
			if (FlxG.keys.justReleased("ESCAPE") || FlxG.keys.justReleased("P")) {
				FlxG.paused = !FlxG.paused;
				if (FlxG.paused) {
					playButton.x = -levelOne.mainLayer.getScreenXY().x + (FlxG.width/2) - (playButton.width/2);
					playButton.y = -levelOne.mainLayer.getScreenXY().y + (FlxG.height / 2) - (playButton.height / 2);
					
					title.x = -levelOne.mainLayer.getScreenXY().x;
					title.y = -levelOne.mainLayer.getScreenXY().y + (playButton.height / 2);

					flash.ui.Mouse.show();
					return pauseGroup.update();
				}				
			}
			
			if(FlxG.paused && !m_tDialogBox.getIsActive())
				pauseGroup.update();
					
			if (!FlxG.paused) {
				super.update();
				flash.ui.Mouse.hide();
				FlxG.collide(null, levelOne.mainLayer); // WTF collide NULL with mainLayer Oo & it works ... 
			}
			
			if (m_tDialogBox.getIsActive() == true) {
				FlxG.paused = true;
			}
			processDialogsInput(); // Input listeners for Dialogs
			
			currentRabbit.text = Player.currentId.toString();
			//FlxG.log(Player.currentId); 
		}
		
		override public function draw():void {
			super.draw();
			
			if (m_tDialogBox.getIsActive == true) {
				s_layerForeground.draw();
			}
			if (FlxG.paused && !m_tDialogBox.getIsActive() && endLevel == 0){
				pauseGroup.draw();
			}
			if (endLevel == 1){
				endLevelGroup.draw();
			}
		}
		
		// Input listeners for Dialogs
		private function processDialogsInput():void {
			if (m_tDialogBox.getIsActive()) {
				if (FlxG.keys.justPressed("SPACE") || FlxG.keys.justPressed("ENTER")){
					m_tDialogBox.setIsActive(false);
					FlxG.paused = false;
				}
			}
		}
		
		/*
		//Create Fireball
		private function spawnBullet(p: FlxPoint):void
		{
			var fireball: Fireball = new Fireball(p.x, p.y, player[1].facing );
			add(fireball);
		}
		*/
	}

}