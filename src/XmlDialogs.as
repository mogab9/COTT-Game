package  
{
	import flash.utils.ByteArray;
	import org.flixel.FlxU;
	import XML

	public class XmlDialogs {
		
		public var dialogs:Array;
		public var DialogBoxAvatars:Array;
		public var next:int; // number of the next dialog
		private var level_number:int;
		
		[Embed(source='../assets/xml/dialogs.xml', mimeType="application/octet-stream")] public static const xmlFile:Class; 

		public function XmlDialogs(levelNumber:int) {
			level_number = levelNumber;
			next = 1;
			processXML();
		}
		
		private function processXML():void {
			var file:ByteArray = new xmlFile;
			var str:String = file.readUTFBytes( file.length );
			var xml:XML = new XML( str );
			var o:XML;
			
			dialogs = new Array;
			DialogBoxAvatars = new Array;
			
			for each (o in xml.level[level_number-1].dialog) {
				//addChild( new Block( o.@X, o.@Y, o.@WIDTH, o.@HEIGHT ) );
				
				//DialogBoxAvatar attribute
				if (Number(o.@avatar) > 0) {
					DialogBoxAvatars.push(o.@avatar);
				}else {
					DialogBoxAvatars.push( -1);
				}
				// dialog content
				dialogs.push(o);
			}
			
		}
	}
}