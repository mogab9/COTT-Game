package
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class FireRabbit extends Player
	{
		[Embed(source = '../assets/textures/actors/firerabbit.png')] private var playerPNG:Class;
		
		public function FireRabbit (X:Number, Y:Number)
		{
			//	As this extends Rabbit we need to call super() to ensure all of the parent variables we need are created
			super(X, Y);

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
		}
		private function spawnBullet(p: FlxPoint):void
		{
			//p is the position for the firerabbit
			var fireball: Fireball = new Fireball(p.x, p.y, facing);
			//not collide with map, failed
			FlxG.overlap(fireball);
			Player.playstate.add(fireball);
		}
	}
}