package
{
	import org.flixel.system.FlxPreloader
 
	public class Preloader extends FlxPreloader
	{
		public function Preloader():void
		{
			minDisplayTime = 10;
			className = "Main";
			super();
		}
	}
}