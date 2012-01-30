package  
{
	import org.flixel.*;
	
	public class Registry 
	{
		public static var level:Level;
		public static var levelExit:FlxPoint;
		public static var openExit:Boolean = false;
		
		public static var map:FlxTilemap;
		
		public static var players:Vector.<Player>;
		public static var player1:Player;
		public static var player2:Player;
		public static var player3:Player;
		public static var player4:Player;
		public static var currentPlayer:Player;
		
		public static var blops:Blops; // is a shortcut of level.blops
		
		public static var carrots:FlxGroup; // is a shortcut of level.carrots
		public static var totalCarrots:int; // is a shortcut of level.totalCarrots
		public static var switches:FlxGroup; // is a shortcut of level.switches
		public static var totalSwitches:int; // is a shortcut of level.totalSwitches
		
		public static var hud:HUD;
		public static var score:FlxText; // is a shortcut of hud.score
		
		public function Registry() 
		{
		}
		
		public static function init():void {
			openExit = false;
			level = new Level1; // fill level, blops & carrots
			
			player1 = new Player(80, 48);
			player2 = new FireRabbit(208, 112);				
			players = new Vector.<Player>(Player.nbPlayers, true);
			players[0]= player1;
			players[1] = player2;
			currentPlayer = player1;
			
			hud = new HUD();
		}
		
		public static function goToNextLevel():void {
			// TODO
		}
		
	}

}