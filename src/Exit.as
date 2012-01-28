package
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class Exit extends FlxSprite
	{
		[Embed(source = '../assets/textures/elements/exitdoor.png')] private var exitPNG:Class;
		
		public function Exit(X:Number, Y:Number):void
		{			
			//	As this extends FlxSprite we need to call super() to ensure all of the parent variables we need are created
			super(X, Y);
			
			// The door is only a image - it has not physical properties in the game
			this.allowCollisions = NONE;
			this.active = false;
			this.immovable = true;
			
			loadGraphic(exitPNG, true, true, 16, 32, true);
			width = 16;
			height = 32;

		}
		
		override public function update():void
		{
			super.update();
		}
		
	}
}