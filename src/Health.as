package 
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class Health extends FlxSprite
	{
		[Embed(source = "../assets/textures/ui/health.png")] private var ImgHealth:Class;
		
		private var _timer:Number;
		
		public function Health(X:int, Y:int)
		{
			super(ImgHealth, X - 16, Y + 17, true, false);
			
			_timer = 0;
			
			addAnimation("health", [0]);
			play("health");
		}
		
		override public function update():void 
		{
			super.update();
			
			if (dead)
				return;
			
			_timer += FlxG.elapsed;
			y -= 20 * FlxG.elapsed;
			alpha = (1 - _timer) / 1;
			if (_timer > 1)
				kill();
		}
		
		public function reset(X:int, Y:int):void
		{
			exists = true;
			dead = false;
			
			_timer = 0;
			alpha = 1;
			
			x = X - 16;
			y = Y + 17;
			
			play("health");
		}
	}
}