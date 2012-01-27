package  
{
	import org.flixel.*;
	
	public class Blops extends FlxGroup
	{
		
		public function Blops() 
		{
			super();
		}
		
		public function addBlop(x:int, y:int):void
		{
			var tmpBlop:Blop = new Blop(x, y)
			
			add(tmpBlop);
		}
		
		override public function update():void
		{
			super.update();
		}
		
	}

}