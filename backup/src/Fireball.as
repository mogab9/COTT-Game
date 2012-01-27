package  
{
	import org.flixel.*;
	
	public class Fireball extends FlxSprite
	{
		[Embed(source = '../assets/textures/elements/fireball1.png')] private var fireballPNG:Class;
		public function Fireball(X:Number, Y:Number,direct:uint):void 
		{
			super(X, Y);
			
			//load the image for fireball
			loadGraphic(fireballPNG, true, true, 12, 10);
			
			//make the animation for fireball
			addAnimation("shoo", [0, 1], 6, true);
			play("shoo");
			
			//set the velocity and direction of the fireball
			if (direct == RIGHT)
			{
				facing = FlxObject.RIGHT;
				velocity.x = 200;
			}
			else
			{
				facing = FlxObject.LEFT;
				velocity.x = -200;
			}
		}
	}
}