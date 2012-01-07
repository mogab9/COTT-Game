package  
{
	import flash.utils.ByteArray;
	import org.flixel.FlxU;
	import XML

	public class XmlDialogs {
		public  var dialogs:Array;
		[Embed(source='../datas/xml/dialogs.xml', mimeType="application/octet-stream")] public static const xmlFile:Class; 
		
		
		
		public function XmlDialogs() {
			
			processXML();
		}
		
		private function processXML():void {
			var file:ByteArray = new xmlFile;
			var str:String = file.readUTFBytes( file.length );
			var xml:XML = new XML( str );
			var o:XML;
			
			dialogs = new Array;
			
			for each (o in xml.level[0].dialog) {
				//addChild( new Block( o.@X, o.@Y, o.@WIDTH, o.@HEIGHT ) );
				dialogs.push(o);
			}
		}
	}
}