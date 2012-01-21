package
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class Player extends FlxSprite
	{
		[Embed(source = '../assets/textures/actors/player.png')] public var playerPNG:Class;
		protected var isActive:Boolean;
		protected var idPlayer:uint;
		protected static var nbPlayers:uint;
		public static var currentId:uint;
		public static var playstate:PlayState;
		
		public function Player(X:Number, Y:Number)
		{
			nbPlayers++;
			
			idPlayer = nbPlayers;
			currentId = 1;

			
			// The first character created is the one who'll be active at the beginning of the game
			if (idPlayer == 1) {
				isActive = true; 
				FlxG.camera.follow(this);
			}
			
			//	As this extends FlxSprite we need to call super() to ensure all of the parent variables we need are created
			super(X, Y);
			
			//	Load the player.png into this sprite.
			//	The 2nd parameter tells Flixel it's a sprite sheet and it should chop it up into 16x18 sized frames.
			loadGraphic(playerPNG, true, true, 16, 18, true);
			
			//	The sprite is 16x18 in size, but that includes a little feather of hair on its head which we don't want to include in collision checks.
			//	We also shave 2 pixels off each side to make it slip through gaps easier. Changing the width/height does NOT change the visual sprite, just the bounding box used for physics.
			width = 12;
			height = 16;
			
			//	Because we've shaved a few pixels off, we need to offset the sprite to compensate
			offset.x = 2;
			offset.y = 2;
			
			//	The Animation sequences we need
			addAnimation("idle", [0], 0, false);
			addAnimation("walk", [0, 1, 0, 2], 10, true);
			addAnimation("jump", [1], 0, false);
			addAnimation("hurt", [4], 0, false);
			
			//	Enable the Controls plugin - you only need do this once (unless you destroy the plugin)
			if (FlxG.getPlugin(FlxControl) == null)
			{
				FlxG.addPlugin(new FlxControl);
			}
			
			//	Add this sprite to the FlxControl plugin and tell it we want the sprite to accelerate and decelerate smoothly
			FlxControl.create(this, FlxControlHandler.MOVEMENT_ACCELERATES, FlxControlHandler.STOPPING_DECELERATES, nbPlayers, true, false);
			
			switch(idPlayer) {
				case 1:
					//	Sprite will be controlled with the left and right cursor keys
					FlxControl.player1.setCursorControl(false, false, true, true);
					
					//	And SPACE BAR will make them jump up to a maximum of 200 pixels (per second), only when touching the FLOOR
					FlxControl.player1.setJumpButton("SPACE", FlxControlHandler.KEYMODE_PRESSED, 200, FlxObject.FLOOR, 250, 200);
						
					//	Stop the player running off the edge of the screen and falling into nothing
					FlxControl.player1.setBounds(0 + 16, 0 + 18, 320 - (2 * 16), 320 - (2 * 18));
					
					//	Because we are using the MOVEMENT_ACCELERATES type the first value is the acceleration speed of the sprite
					//	Think of it as the time it takes to reach maximum velocity. A value of 100 means it would take 1 second. A value of 400 means it would take 0.25 of a second.
					FlxControl.player1.setMovementSpeed(400, 0, 100, 200, 400, 0);
					
					//	Set a downward gravity of 400px/sec
					FlxControl.player1.setGravity(0, 400);
					
					//	By default the sprite is facing to the right.
					//	Changing this tells Flixel to flip the sprite frames to show the left-facing ones instead.
					
					facing = FlxObject.RIGHT;
				break;
				case 2:
					FlxControl.player2.setBounds(0 + 16, 0 + 18, 320 - (2 * 16), 320 - (2 * 18));
					FlxControl.player2.setMovementSpeed(400, 0, 100, 200, 400, 0);
					FlxControl.player2.setGravity(0, 400);
					facing = FlxObject.RIGHT;
				break;
				case 3:
					FlxControl.player3.setBounds(0 + 16, 0 + 18, 320 - (2 * 16), 320 - (2 * 18));
					FlxControl.player3.setMovementSpeed(400, 0, 100, 200, 400, 0);
					FlxControl.player3.setGravity(0, 400);
					facing = FlxObject.RIGHT;
				break;
				case 4:
					FlxControl.player4.setBounds(0 + 16, 0 + 18, 320 - (2 * 16), 320 - (2 * 18));
					FlxControl.player4.setMovementSpeed(400, 0, 100, 200, 400, 0);
					FlxControl.player4.setGravity(0, 400);
					facing = FlxObject.RIGHT;
				break;
			}
			
		}
		
		override public function update():void
		{
			super.update();
			
			// Manage the keyboard if the player changes
			if (FlxG.keys.ONE) {
				if(idPlayer == 1) {
					if (!isActive)	 {
						currentId = 1;
						isActive = true;
						FlxControl.player1.setCursorControl(false, false, true, true);
						FlxControl.player1.setJumpButton("SPACE", FlxControlHandler.KEYMODE_PRESSED, 200, FlxObject.FLOOR, 250, 200);
						FlxG.camera.follow(this);
					}
				}
				else if (isActive) {
					isActive = false;
					deactivateMouvement();
				}
			}
			
			if (FlxG.keys.TWO) {
				if (idPlayer == 2) {
					if (!isActive)	 {
						currentId = 2;
						isActive = true;
						FlxControl.player2.setCursorControl(false, false, true, true);
						FlxControl.player2.setJumpButton("SPACE", FlxControlHandler.KEYMODE_PRESSED, 200, FlxObject.FLOOR, 250, 200);
						FlxG.camera.follow(this);
					}
				}
				else if (isActive) {
					isActive = false;
					deactivateMouvement();
				}
			}
			
			if (FlxG.keys.THREE) {
				if (idPlayer == 3) {
					if (!isActive)	 {
						currentId = 3;
						isActive = true;
						FlxControl.player3.setCursorControl(false, false, true, true);
						FlxControl.player3.setJumpButton("SPACE", FlxControlHandler.KEYMODE_PRESSED, 200, FlxObject.FLOOR, 250, 200);
						FlxG.camera.follow(this);
					}
				}
				else if (isActive) {
					isActive = false;
					deactivateMouvement();
				}
			}
			
			if (FlxG.keys.FOUR) {
				if (idPlayer == 4) {
					if (!isActive)	 {
						currentId = 4;
						isActive = true;
						FlxControl.player4.setCursorControl(false, false, true, true);
						FlxControl.player4.setJumpButton("SPACE", FlxControlHandler.KEYMODE_PRESSED, 200, FlxObject.FLOOR, 250, 200);
						FlxG.camera.follow(this);
					}
				}
				else if (isActive) {
					isActive = false;
					deactivateMouvement();
				}
			}
			
			if (touching == FlxObject.FLOOR)
			{
				if (velocity.x != 0)
				{
					play("walk");
				}
				else
				{
					play("idle");
				}
			}
			else if (velocity.y < 0)
			{
				play("jump");
			}
		}
		
		protected function deactivateMouvement():void {
			switch(idPlayer) {
				case 1:
					FlxControl.player1.setCursorControl(false, false, false, false);
					FlxControl.player1.setJumpButton("SPACE", FlxControlHandler.KEYMODE_PRESSED, 0, FlxObject.FLOOR, 250, 200);
				break;
				case 2:
					FlxControl.player2.setCursorControl(false, false, false, false);
					FlxControl.player2.setJumpButton("SPACE", FlxControlHandler.KEYMODE_PRESSED, 0, FlxObject.FLOOR, 250, 200);
				break;
				case 3:
					FlxControl.player3.setCursorControl(false, false, false, false);
					FlxControl.player3.setJumpButton("SPACE", FlxControlHandler.KEYMODE_PRESSED, 0, FlxObject.FLOOR, 250, 200);
				break;
				case 4:
					FlxControl.player4.setCursorControl(false, false, false, false);
					FlxControl.player4.setJumpButton("SPACE", FlxControlHandler.KEYMODE_PRESSED, 0, FlxObject.FLOOR, 250, 200);
				break;
			}
		}		
	}
}