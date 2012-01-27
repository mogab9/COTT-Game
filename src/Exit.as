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
			
			//	Load the end.png into this sprite.
			//	The 2nd parameter tells Flixel it's a sprite sheet and it should chop it up into 16x34 sized frames.
			loadGraphic(exitPNG, true, true, 16, 34, true);
			
			//	The sprite is 16x34 in size, but that includes a little feather of hair on its head which we don't want to include in collision checks.
			//	We also shave 2 pixels off each side to make it slip through gaps easier. Changing the width/height does NOT change the visual sprite, just the bounding box used for physics.
			width = 12;
			height = 32;
			
			//	Because we've shaved a few pixels off, we need to offset the sprite to compensate
			offset.x = 2;
			offset.y = 2;
		}
		
		override public function update():void
		{
			super.update();
		}
		
	}
}