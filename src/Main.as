package
{
	import org.flixel.FlxGame;
	
	[SWF(width="640", height="480", backgroundColor="#000000")]

	public class Main extends FlxGame
	{
		public function Main()
		{
			super(320, 240, MenuState, 2, 60, 60);
			LevelsCompleted.load();
			forceDebugger = true;
		}
	}
}
