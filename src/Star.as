package  
{
	import org.flixel.FlxSprite;

	public class Star extends FlxSprite
	{
		[Embed(source = '../assets/star.png')] private var starPNG:Class;
		
		public function Star(X:int, Y:int)
		{
			super(X * 16, Y * 16, starPNG);
			
			solid = true;
		}
		
	}

}