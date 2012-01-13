package
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class FireRabbit extends FlxSprite
	{
		[Embed(source = '../assets/textures/actors/firerabbit.png')] private var playerPNG:Class;
		//add a group to include all the fireball for handling
		public var _fireball:FlxGroup;
		//flag to show if fireball exist or not, defaut set to false
		private var fireflag:Boolean;
		
		public function FireRabbit (X:Number, Y:Number)
		{
			//	As this extends FlxSprite we need to call super() to ensure all of the parent variables we need are created
			super(X, Y);
			
			_fireball = new FlxGroup();// fireball group		
			//add(_fireball);
			fireflag = false;//init to false
			
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
			FlxControl.create(this, FlxControlHandler.MOVEMENT_ACCELERATES, FlxControlHandler.STOPPING_DECELERATES, 1, true, false);
			
			//	Sprite will be controlled with the left and right cursor keys
			FlxControl.player1.setCursorControl(false, false, true, true);
			
			//	And SPACE BAR will make them jump up to a maximum of 200 pixels (per second), only when touching the FLOOR
			FlxControl.player1.setJumpButton("SPACE", FlxControlHandler.KEYMODE_PRESSED, 200, FlxObject.FLOOR, 250, 200);
			
			//	Stop the player running off the edge of the screen and falling into nothing
			FlxControl.player1.setBounds(16, 0, 288, 240);
			
			//	Because we are using the MOVEMENT_ACCELERATES type the first value is the acceleration speed of the sprite
			//	Think of it as the time it takes to reach maximum velocity. A value of 100 means it would take 1 second. A value of 400 means it would take 0.25 of a second.
			FlxControl.player1.setMovementSpeed(400, 0, 100, 200, 400, 0);
			
			//	Set a downward gravity of 400px/sec
			FlxControl.player1.setGravity(0, 400);
			
			//	By default the sprite is facing to the right.
			//	Changing this tells Flixel to flip the sprite frames to show the left-facing ones instead.
			facing = FlxObject.RIGHT;
		}
		
		override public function update():void
		{
			super.update();
			
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
			
			//handler for fireball
			if(FlxG.keys.justPressed("W"))
			{
				//get the position in FireRabbit and then create the fireball and shoot
				spawnBullet(getBulletSpawnPosition(facing));
			
			}
			//make the fireball disappear when it bump into walls or overpass the boundry
			if (fireflag != false) {	
				if (_fireball.members[0].velocity.x==0 ||_fireball.members[0].x<0 ||_fireball.members[0].x>FlxG.width)
				{
					//kill the first fireball
					_fireball.members[0].kill;
					//shift all the fireball to detect the followed fireball
					_fireball.members.shift();
					
					//if there is no fireball left, set flag to false
					if (_fireball.members[0]==null)
					fireflag = false;
				}
			}
		}
		
		public function getBulletSpawnPosition(direct:uint):FlxPoint
		{
			var p: FlxPoint;
			if(direct==RIGHT)
				p= new FlxPoint(x + 2, y + 6);
			else
				p= new FlxPoint(x - 2, y + 6);
			return p;
		}
		//Create Fireball
		private function spawnBullet(p: FlxPoint):void
		{
			//p is the position for the firerabbit
			var fireball: Fireball = new Fireball(p.x, p.y, facing );
			//set the flag to true to show there is the fireball
			fireflag = true;
			//add to fireball group to draw
			_fireball.add(fireball);
		}
		
		
	}
}