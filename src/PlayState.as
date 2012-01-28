package  
{
	import org.flixel.*;
	
	import ui.DialogBox;
	import ui.DialogBoxAvatar;
	
	public class PlayState extends FlxState
	{	
		// Game Var
		private var endLevel:Boolean;
		private var pauseSprite:FlxSprite;
		
		// Dialogs
		private var m_tDialogBox:DialogBox;
		private var m_tDialogLength:int; // number of dialogs for the given level
		private var m_xmlDialogs:XmlDialogs;
		private var m_DialogBoxAvatars:DialogBoxAvatar;
		static private var s_layerForeground:FlxGroup;
		
		
		public function PlayState() 
		{
		}
		
		override public function create():void
		{
			Registry.init();
			
			add(Registry.level);
			for (var i:int = 0 ; i < Registry.players.length ; i++) {
				add(Registry.players[i]);
			}
			trace (Registry.blops);
			add(Registry.blops);
			add(Registry.hud);
			add(Registry.carrots);
			//add(level.cats);
			
			//	Tell flixel how big our game world is
			FlxG.worldBounds = new FlxRect(0, 0, Registry.level.width, Registry.level.height);
			
			//	Don't let the camera wander off the edges of the map
			FlxG.camera.setBounds(0, 0, Registry.level.width, Registry.level.height);
			
			//	The camera will follow the player
			FlxG.camera.follow(Registry.player1, FlxCamera.STYLE_PLATFORMER);
			
			FlxG.playMusic(level1MusicMP3, 0.5);
			
			
			//----------Dialog-----------
			//Init
			m_tDialogBox = new DialogBox();
			m_DialogBoxAvatars = new DialogBoxAvatar;
			
			// Loading XML Dialogs
			m_xmlDialogs = new XmlDialogs(1); // level number
			m_tDialogBox.setText(m_xmlDialogs.dialogs[0]);
			m_tDialogLength = m_xmlDialogs.dialogs.length;
			if (m_xmlDialogs.DialogBoxAvatars[0] > 0) {
				m_tDialogBox.setDialogBoxAvatar(m_DialogBoxAvatars.getDialogBoxAvatar(1));
			}
			add(m_tDialogBox.m_aGraphics);
			
			// Activating
			m_tDialogBox.setIsActive(true);
		}
		
		override public function update():void
		{
			// Handle the Dialogs if necessary
			if (m_tDialogBox.getIsActive() == true) {
				if (!FlxG.paused)	FlxG.paused = true;
				processDialogsInput(); // Input listeners for Dialogs
				return ;
			}
			if (FlxG.keys.justReleased("ESCAPE") || FlxG.keys.justReleased("P")) {
				FlxG.paused = !FlxG.paused;
				if (FlxG.paused) {
					// dark screen
					pauseSprite = new FlxSprite(0, 0);
					pauseSprite.makeGraphic(320, 240, 0xAA000000);
					pauseSprite.scrollFactor.x = pauseSprite.scrollFactor.y = 0;
					add(pauseSprite);
					// stop the music
					FlxG.mute = true;
				}
				else {
					// remove the dark screen & then set the music back
					remove(pauseSprite);
					FlxG.mute = false;
				}
			}
			if (FlxG.paused) {
				return;
			}			
			
			//	Players walked through end of level exit?
			endLevel = true;
			for (var i:int = 0 ; i < Registry.players.length ; i++) {
				if ( !(Math.abs(Registry.players[i].x - Registry.levelExit.x) < 5) || !(Math.abs(Registry.players[i].y - Registry.levelExit.y) < 5)) {
					endLevel = false;
				}
			}
			if (endLevel) {
				for (var ii:int = 0 ; ii < Registry.players.length && !endLevel ; ii++) {
					Registry.players[ii].exists = false;
				}
				FlxG.fade(0xff000000, 2, changeState);
				FlxG.music.fadeOut(2);
				return;
			}
			
			super.update();
			
			// Manage the collisions / hits
			for (var iii:int = 0 ; iii < Registry.players.length ; iii++) {
				FlxG.collide(Registry.players[iii], Registry.level);
				
				FlxG.overlap(Registry.players[iii], Registry.carrots, hitCarrot);
				//FlxG.overlap(Registry.players[iii], Registry.blops, hitBlops);
			}
			FlxG.collide(Registry.blops, Registry.level);
		}
		
		private function changeState():void
		{
			FlxG.switchState(new LevelEndState);
		}
		
		private function processDialogsInput():void {
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
		
		override public function destroy():void
		{
			super.destroy();
		}
		
		/*private function hitCat(player:FlxObject, cat:FlxObject):void
		{
			if (Cat(cat).isDying)
			{
				return;
			}
			
			if (player.y < cat.y)
			{
				cat.kill();
			}
			else
			{
				Player(player).restart();
			}
		}*/
		
		private function hitCarrot(p:FlxObject, carrot:FlxObject):void
		{
			carrot.kill();
			
			FlxG.score += 1;
			
			if (FlxG.score == Registry.totalCarrots)
			{
				Registry.score.text = FlxG.score.toString() + " / " + Registry.totalCarrots.toString() + " PERFECT!";
				//	Opens the exit at the end of the level		
				//level.openExit();
			}
			else
			{
				Registry.score.text = FlxG.score.toString() + " / " + Registry.totalCarrots.toString();
			}
		}
		
	}

}