package  
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.plugin.photonstorm.FX.CenterSlideFX;
	import org.flixel.plugin.photonstorm.FX.FloodFillFX;
	
	public class MainMenuState extends FlxState
	{
		[Embed(source = '../assets/titlepage.png')] private var titlePagePNG:Class;
		
		private var level:Level1;
		private var title:FlxSprite;
		private var dolly:FlxSprite;
		private var start:FlxText;
		private var reveal:CenterSlideFX;
		private var floodfill:FloodFillFX;
		
		public function MainMenuState() 
		{
		}
		
		override public function create():void
		{
			if (FlxG.getPlugin(FlxSpecialFX) == null)
			{
				FlxG.addPlugin(new FlxSpecialFX);
			}
			
			reveal = FlxSpecialFX.centerSlide();
			floodfill = FlxSpecialFX.floodFill();
			
			var t:FlxSprite = new FlxSprite(0, 0, titlePagePNG);
			
			title = floodfill.create(t, 0, 0, t.width, t.height, 0, 1);
			title.scrollFactor.x = 0;
			title.scrollFactor.y = 0;
			
			level = new Level1();
			
			start = new FlxText(0, 226, 320, "- ANY KEY TO START -");
			start.alignment = "center";
			start.shadow = 0xff000000;
			start.scrollFactor.x = 0;
			start.scrollFactor.y = 0;
			
			dolly = new FlxSprite(160, 170);
			dolly.facing = FlxObject.RIGHT;
			
			FlxG.worldBounds = new FlxRect(0, 0, level.width, level.height);
			FlxG.camera.setBounds(0, 0, level.width, level.height);
			FlxG.camera.follow(dolly, FlxCamera.STYLE_PLATFORMER);
			
			FlxG.playMusic(titleMusicMP3, 1);
			
			floodfill.start();
			
			add(level);
			add(level.carrots);
			add(title);
			add(start);
		}
		
		override public function update():void
		{
			super.update();
			
			if (FlxG.keys.any())
			{
				FlxG.fade(0xff000000, 2, changeState);
				FlxG.music.fadeOut(2);
			}
			
			if (dolly.facing == FlxObject.RIGHT)
			{
				dolly.x++;
				
				if (dolly.x >= (level.width - 160))
				{
					dolly.facing = FlxObject.LEFT;
				}
			}
			else if (dolly.facing == FlxObject.LEFT)
			{
				dolly.x--;
				
				if (dolly.x <= 0)
				{
					dolly.facing = FlxObject.RIGHT;
				}
			}
		}
		
		private function changeState():void
		{
			FlxG.switchState(new PlayState);
		}
		
		override public function destroy():void
		{
			FlxSpecialFX.clear();
			
			super.destroy();
		}
		
	}

}