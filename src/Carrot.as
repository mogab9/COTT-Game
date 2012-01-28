package  
{
	import org.flixel.FlxSprite;

	public class Carrot extends FlxSprite
	{
		[Embed(source = '../assets/textures/elements/carrot.png')] private var carrotPNG:Class;
		
		public function Carrot(X:int, Y:int)
		{
			super(X * 16, Y * 16, carrotPNG);
			
			solid = true;
		}
		
	}

}