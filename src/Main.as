package
{
	import org.flixel.FlxGame;
	
	[Frame(factoryClass="Preloader")] //Tells Flixel to use the default preloader
	[SWF(width="640", height="480", backgroundColor="#000000")]

	public class Main extends FlxGame
	{
		public function Main()
		{
			super(320, 240, MainMenuState, 2, 60, 60);
			
			LevelsCompleted.load(); // load the save system
			forceDebugger = true; // debugger to remove for the final version
		}
	}
}
