package  
{
	import org.flixel.*;
	
	public class Registry 
	{
		public static var level:Level;
		public static var levelExit:FlxPoint;
		
		public static var players:Vector.<Player>;
		public static var player1:Player;
		public static var player2:Player;
		public static var player3:Player;
		public static var player4:Player;
		
		public static var hud:HUD;
		
		public function Registry() 
		{
		}
		
		public static function init():void {
			level = new Level1;
			
			player1 = new Player(80, 48);
			player2 = new FireRabbit(208, 112);				
			players = new Vector.<Player>(Player.nbPlayers, true);
			players[0]= player1;
			players[1] = player2;
			
			hud = new HUD();
		}
		
		public static function goToNextLevel():void {
			// TODO
		}
		
	}

}