package  
{
	import org.flixel.*;

	public class Cats extends FlxGroup
	{
		public function Cats()
		{
			super();
		}
		
		public function addCat(x:int, y:int):void
		{
			var tempCat:Cat = new Cat(x, y);
				
			add(tempCat);
		}
		
		override public function update():void
		{
			super.update();
		}
		
	}

}