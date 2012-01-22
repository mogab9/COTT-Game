package  
{
	import flash.display.Graphics;
	import flash.ui.Mouse;
	
	import org.flixel.*;
	
	import ui.DialogBox;
	import ui.DialogBoxAvatar;
	
	public class PlayState extends FlxState
	{
		[Embed(source = "../assets/textures/ui/heart.png")] private var ImgHeart:Class;
		
		private var players:Array; // Array with Player
		private var exitDoor:Exit;
		protected var levelOne:BaseLevel;
		protected var endLevel:uint;
		
		// Dialogs
		private var m_tDialogBox:DialogBox;
		private var m_tDialogLength:int; // number of dialogs for the given level
		private var m_xmlDialogs:XmlDialogs;
		private var m_DialogBoxAvatars:DialogBoxAvatar;
		
		// Pause elements
		private var title:FlxText;
		private var playButton:FlxButton;
		
		// Render layers
		static private var s_layerForeground:FlxGroup;
		static private var s_layerOverlay:FlxGroup;
		public var pauseGroup:FlxGroup;
		public var endLevelGroup:FlxGroup;
		
		//HUD
		private var currentRabbit_id:FlxText;
		private var currentRabbit_img:FlxSprite;
		private var hearthRabbit:FlxSprite;
		private var healthRabbit:FlxText;
		
		
		
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
			
			for (var i:int = 0 ; i < players.length ; i ++) {
				if (players[i] is FireRabbit) {
					add(players[i]._fireball);
				}
			}
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
				trace("Back to the game");
				FlxG.paused = false;
			}
			pauseGroup.add(playButton);
			pauseGroup.add(title);
			
			//--------EndLevel Menu---------
			title = new FlxText(0, 16, FlxG.width, "Level Completed !");
			title.setFormat (null, 16, 0xFFFFFFFF, "center");
			
			playButton = new FlxButton(FlxG.width / 2 - 40, FlxG.height / 2, "Next Level");

			playButton.onUp = function():void {
				trace("Next Level (aka restart level)");
				FlxG.switchState(new PlayState());
			}
			endLevelGroup.add(playButton);
			endLevelGroup.add(title);
			
			//----------Dialog-----------
				//Init
			m_tDialogBox = new DialogBox(levelOne.mainLayer.getScreenXY().x, levelOne.mainLayer.getScreenXY().y);
			m_DialogBoxAvatars = new DialogBoxAvatar;
			
				// Loading Xml Dialogs
			m_xmlDialogs = new XmlDialogs(1); // level number
			m_tDialogBox.setText(m_xmlDialogs.dialogs[0]);
			m_tDialogLength = m_xmlDialogs.dialogs.length;
			if (m_xmlDialogs.DialogBoxAvatars[0] > 0) {
				m_tDialogBox.setDialogBoxAvatar(m_DialogBoxAvatars.getDialogBoxAvatar(1));
			}
			
				// Adding to layers
			s_layerForeground.add(m_tDialogBox.m_aGraphics);
			
				// Activating
			m_tDialogBox.setIsActive(true);
			
			//----- Adding layers -------
			add(s_layerForeground);
			//add(pauseGroup):
			
			
			//---------- HUD ----------
			//current rabbit ID
			currentRabbit_id = new FlxText(5, 5, 100);
			currentRabbit_id.color = 0xffffffff;
			currentRabbit_id.shadow = 0xff000000;
			currentRabbit_id.scrollFactor.x = 0;
			currentRabbit_id.scrollFactor.y = 0;
			currentRabbit_id.text = "1";
			add(currentRabbit_id);
			//current rabbit img
			currentRabbit_img = new FlxSprite(20, 2);
			currentRabbit_img.scrollFactor.x = 0;
			currentRabbit_img.scrollFactor.y = 0;
			currentRabbit_img.loadGraphic(players[Player.currentId-1].playerPNG, true, true, 16, 18, true);
			add(currentRabbit_img);
			//health 
			healthRabbit = new FlxText(70, 5, 100);
			healthRabbit.color = 0xffffffff;
			healthRabbit.shadow = 0xff000000;
			healthRabbit.scrollFactor.x = 0;
			healthRabbit.scrollFactor.y = 0;
			healthRabbit.text = "1";
			add(healthRabbit);
			//img hearth
			hearthRabbit = new FlxSprite(50, 2);
			hearthRabbit.scrollFactor.x = 0;
			hearthRabbit.scrollFactor.y = 0;
			add(hearthRabbit);
			
			
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
			
			//current rabbit
			currentRabbit_id.text = Player.currentId.toString();
			currentRabbit_img.loadGraphic(players[Player.currentId-1].playerPNG, true, true, 16, 18, true);
			//health
			healthRabbit.text = players[Player.currentId-1].health.toString();
			hearthRabbit.loadGraphic(players[Player.currentId-1].ImgHealth, true, true, 16, 18, true);

			
			/*
			 * --------------------------------------------------------
			 *  			STEP 4 = the "normal" update
 			 * --------------------------------------------------------
			 */
			if (!FlxG.paused) {
				super.update();
				flash.ui.Mouse.hide();
				FlxG.collide(levelOne.masterLayer, levelOne.mainLayer); 
				// TODO collide the fireballs with the decor
				
				//trace("x = " + players[0].x + " // y = " + players[0].y);
			}
			
			/*
			 * --------------------------------------------------------
			 *  			STEP 5 = HUD character displayed
 			 * --------------------------------------------------------
			 */
			// TODO fix this shit by loading once every rabbit graphic and put it in a tableau
			if (FlxG.keys.ONE || FlxG.keys.TWO || FlxG.keys.THREE || FlxG.keys.FOUR) {
				currentRabbit_img.loadGraphic(players[Player.currentId-1].playerPNG, true, true, 16, 18, true);
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
						// update DialogBoxAvatar
						var next_DialogBoxAvatar_id:Number = m_xmlDialogs.DialogBoxAvatars[m_xmlDialogs.next];
						var new_DialogBoxAvatar:Class = m_DialogBoxAvatars.getDialogBoxAvatar(next_DialogBoxAvatar_id);
						if(new_DialogBoxAvatar != null)
							m_tDialogBox.setDialogBoxAvatar(new_DialogBoxAvatar); // displaying the next DialogBoxAvatar
							
						// update dialog
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