package  
{
	import flash.display.Graphics;
	import flash.ui.Mouse;
	import ui.DialogBox;
	
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{
		[Embed(source = "../assets/textures/ui/heart.png")] private var ImgHeart:Class;
		
		private var players:Array; // Array with Player
		private var exitDoor:Exit;
		protected var levelOne:BaseLevel;
		protected var endLevel:uint;
		
		private var m_tDialogBox:DialogBox;
		private var m_tDialogLength:int; // number of dialogs for the given level
		private var m_xmlDialogs:XmlDialogs;
		
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
			Player.playstate = this;
			pauseGroup = new FlxGroup; // pauseGroup 
			endLevelGroup = new FlxGroup; // endLevelGroup 
			s_layerForeground = new FlxGroup;
			s_layerOverlay = new FlxGroup;
			add(levelOne.masterLayer.members[1].members[1]._fireball);
			/*
			_fireball = new FlxGroup();// fireball group		
			add(_fireball);
			fireflag = false;//init to false
			*/
			
			//--------Pause Menu---------
			title = new FlxText(0, 16, FlxG.width, "Pause");
			title.setFormat (null, 16, 0xFFFFFFFF, "center");
			
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
			
				// Loading Xml Dialogs
			m_xmlDialogs = new XmlDialogs(1); // level number
			m_tDialogBox.setText(m_xmlDialogs.dialogs[0]);
			m_tDialogLength = m_xmlDialogs.dialogs.length;
			
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
			 * --------------------------------------------------------
			 * 			STEP 1 = check the end of the level
			 * --------------------------------------------------------
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
				
				playButton = endLevelGroup.members[0];
				title = endLevelGroup.members[1];
				
				playButton.x = -levelOne.mainLayer.getScreenXY().x + (FlxG.width/2) - (playButton.width/2);
				playButton.y = -levelOne.mainLayer.getScreenXY().y + (FlxG.height / 2) - (playButton.height / 2);
				
				title.x = -levelOne.mainLayer.getScreenXY().x;
				title.y = -levelOne.mainLayer.getScreenXY().y + (playButton.height / 2);

				flash.ui.Mouse.show();
				return endLevelGroup.update();
				// goToNextLevel();
				
			}			
			/*
			/*
			 * --------------------------------------------------------
			 * 			STEP 2 = the pause menu
			 * --------------------------------------------------------
			 */
			if (FlxG.keys.justReleased("ESCAPE") || FlxG.keys.justReleased("P")) {
				FlxG.paused = !FlxG.paused;				
			}
			
			if (FlxG.paused && !m_tDialogBox.getIsActive()) {
				playButton = pauseGroup.members[0];
				title = pauseGroup.members[1];
				
				playButton.x = -levelOne.mainLayer.getScreenXY().x + (FlxG.width/2) - (playButton.width/2);
				playButton.y = -levelOne.mainLayer.getScreenXY().y + (FlxG.height / 2) - (playButton.height / 2);
				
				title.x = -levelOne.mainLayer.getScreenXY().x;
				title.y = -levelOne.mainLayer.getScreenXY().y + (playButton.height / 2);

				flash.ui.Mouse.show();
				pauseGroup.update();
			}
			
			/*
			 * --------------------------------------------------------
			 *  			STEP 3 = Handle the Dialogs
			 * --------------------------------------------------------
			 */
			if (m_tDialogBox.getIsActive() == true) {
				FlxG.paused = true;
			}
			processDialogsInput(); // Input listeners for Dialogs
			
			currentRabbit.text = Player.currentId.toString();
			//FlxG.log(Player.currentId); 
			
			/*
			 * --------------------------------------------------------
			 *  			STEP 4 = the "normal" update
 			 * --------------------------------------------------------
			 */
			if (!FlxG.paused) {
				super.update();
				flash.ui.Mouse.hide();
				FlxG.collide(null, levelOne.mainLayer); // WTF collide NULL with mainLayer Oo & it works ... it's magiccccc
			}
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
				if (FlxG.keys.justPressed("SPACE") || FlxG.keys.justPressed("ENTER")) {
					if (m_tDialogLength - 1 > 0) {
						m_tDialogLength--; // cpt
						m_tDialogBox.setText(m_xmlDialogs.dialogs[m_xmlDialogs.next]); // displaying the next text
						m_xmlDialogs.next += 1; // updating next
					}else {
						m_tDialogBox.setIsActive(false);
						FlxG.paused = false;
					}
				}
			}
		}
		
	}
}