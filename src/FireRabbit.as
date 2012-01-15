package
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class FireRabbit extends Player
	{
		[Embed(source = '../assets/textures/actors/firerabbit.png')] private var playerPNG:Class;
		//add a group to include all the fireball for handling
		public var _fireball:FlxGroup;
		//flag to show if fireball exist or not, defaut set to false
		private var fireflag:Boolean;
		
		public function FireRabbit (X:Number, Y:Number)
		{
			//	As this extends Rabbit we need to call super() to ensure all of the parent variables we need are created
			super(X, Y);
			
			_fireball = new FlxGroup();// fireball group		
			fireflag = false;//init to false
			
			//	Load the player.png into this sprite.
			//	The 2nd parameter tells Flixel it's a sprite sheet and it should chop it up into 16x18 sized frames.
			loadGraphic(playerPNG, true, true, 16, 18, true);
			width = 12;
			height = 16;
			offset.x = 2;
			offset.y = 2;
		}
		
		public function getBulletSpawnPosition(direct:uint):FlxPoint
		{
			var p: FlxPoint;
			if(direct == RIGHT)
				p = new FlxPoint(x + 2, y + 6);
			else
				p = new FlxPoint(x - 2, y + 6);
			return p;
		}
		
		override public function update():void
		{
			super.update(); // the update of the Player Class
			
			// Manage the keyboard if the player changes
			if (Player.currentId == idPlayer && FlxG.keys.justPressed("W")) {
				//handler for fireball
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