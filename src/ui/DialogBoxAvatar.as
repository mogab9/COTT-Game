package ui
{
	// DialogBoxAvatars for Dialogbox
	public class DialogBoxAvatar {
		[Embed(source = "../../assets/textures/portraits/player.png")] private var DialogBoxAvatar_01:Class;
		[Embed(source = "../../assets/textures/portraits/fire.png")] private var DialogBoxAvatar_02:Class;
		
		private var DialogBoxAvatars:Array; // array of DialogBoxAvatars
		
		public function DialogBoxAvatar() {
			DialogBoxAvatars = new Array;
			fillDialogBoxAvatarsArray();
		}
		
		public function getDialogBoxAvatar(n:int):Class {
			return DialogBoxAvatars[n-1];
		}
		
		// fill DialogBoxAvatars array with embedded images
		private function fillDialogBoxAvatarsArray():void {
			DialogBoxAvatars.push(DialogBoxAvatar_01);
			DialogBoxAvatars.push(DialogBoxAvatar_02);
		}
		
	}

}