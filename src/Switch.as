package
{
	import org.flixel.FlxSprite;
	
	public class Switch extends FlxSprite
	{
		[Embed(source='../assets/textures/elements/switch.png')]
		private var switchPNG:Class;
		private var y_start:int;
		private var timer:uint = 0;
		
		public function Switch(X:int, Y:int)
		{
			this.width = 16;
			this.height = 11;
			
			this.y_start = (Y * 16) + 16 - this.height;
			
			super(X * 16, y_start) ; // 16-height because it height is not 16 and we do not want the switch to fly
			this.loadGraphic(switchPNG, true, true, 16, 11, true);
			
			this.allowCollisions = UP;
			this.immovable = true;

			this.addAnimation("idle", [0], 0, false);
			this.addAnimation("activated", [1], 0, false);
			//this.solid = true; // if we want the rabbit to collide with the border of the switch
		}
		
		override public function update():void
		{
			// tricks for handle the time for the rabbit to fall at the same height as the switch activated
			// ahahaha
			if (this.timer != 0) {
				timer --;
				return;
			}
			super.update();
			
			if (this.isTouching(UP)) {
				play("activated");
				this.height = 7;
				this.y = this.y_start + 4;
				this.offset.y = 4;
				this.timer = 30;
			}
			else {
				play("idle");
				this.height = 11;
				this.y = this.y_start;
				this.offset.y = 0;
			}
		}
	}

}