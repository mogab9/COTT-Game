package  
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;

	public class HUD extends FlxGroup
	{
		private var currentRabbit_id:FlxText;
		private var currentRabbit_img:FlxSprite;
		private var heartRabbit:FlxSprite;
		private var healthRabbit:FlxText;
		private var tabRabbits:Vector.<FlxSprite>;
		
		public function HUD()
		{			
			//----------rabbit-----------
			//current rabbit ID
			currentRabbit_id = new FlxText(5, 5, 100);
			currentRabbit_id.color = 0xffffffff;
			currentRabbit_id.shadow = 0xff000000;
			currentRabbit_id.scrollFactor.x = 0;
			currentRabbit_id.scrollFactor.y = 0;
			currentRabbit_id.text = "1";
			add(currentRabbit_id);
			
			//Current rabbit img
			//table of rabbits images
			tabRabbits = new Vector.<FlxSprite>(Player.nbPlayers, true);
			for(var j:uint=0; j< Player.nbPlayers; j++){
				tabRabbits[j] = new FlxSprite(20, 2);
				tabRabbits[j].scrollFactor.x = 0;
				tabRabbits[j].scrollFactor.y = 0;
				tabRabbits[j].loadGraphic(Registry.players[j].playerPNG, true, true, 16, 18, true);
			}
			//image of the HUD
			currentRabbit_img = new FlxSprite(20, 2);
			currentRabbit_img.scrollFactor.x = 0;
			currentRabbit_img.scrollFactor.y = 0;
			//currentRabbit_img.loadGraphic(players[Player.currentId-1].playerPNG, true, true, 16, 18, true);
			currentRabbit_img = tabRabbits[Player.currentId-1];
			add(currentRabbit_img);
			
			//-----------------health -----------------
			//health ID 
			healthRabbit = new FlxText(70, 5, 100);
			healthRabbit.color = 0xffffffff;
			healthRabbit.shadow = 0xff000000;
			healthRabbit.scrollFactor.x = 0;
			healthRabbit.scrollFactor.y = 0;
			healthRabbit.text = "1";
			//add(healthRabbit);
			
			//img hearth
			heartRabbit = new FlxSprite(50, 2);
			heartRabbit.scrollFactor.x = 0;
			heartRabbit.scrollFactor.y = 0;
			heartRabbit.loadGraphic(Registry.players[Player.currentId-1].ImgHealth, true, true, 16, 18, true); // TO DO > DON'T WORK !!!!
			//add(heartRabbit);	
		}
		
		override public function update():void
		{
			//healthRabbit.text = players[Player.currentId-1].health.toString();
			if (FlxG.keys.ONE || FlxG.keys.TWO || FlxG.keys.THREE || FlxG.keys.FOUR) {
				//FlxG.log(Player.currentId - 1);
				remove(currentRabbit_img);
				currentRabbit_img = tabRabbits[Player.currentId - 1];
				add(currentRabbit_img);
				currentRabbit_id.text = Player.currentId.toString();
			}
		}
		
		override public function destroy():void
		{
			trace("HUD nuked");
		}
		
	}

}