package ui 
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	/**
	 * LD19 - "Discovery"
	 * @author Paul S Burgess - 19/12/10
	 */
	public class DialogBox
	{
		[Embed(source = '../../assets/textures/ui/dialog_box.png')] private var imgBackingBox:Class;
		
		public var m_aGraphics:FlxGroup;
		
		// Graphic objects:
		private var m_tBackingBox:FlxSprite;
		private var m_tText:FlxText;
		
		private var m_bActive:Boolean = false;
		
		public function DialogBox() 
		{
			m_tBackingBox = new FlxSprite(0,90);
			m_tBackingBox.loadGraphic(imgBackingBox);
			//m_tBackingBox.x = (FlxG.width - m_tBackingBox.width) * 0.5;
			m_tBackingBox.x = -10;
			m_tBackingBox.y = 150;
			m_tText = new FlxText(m_tBackingBox.x + 50, m_tBackingBox.y, 250, "", false);
			//m_tText = new FlxText(m_tBackingBox.x + 8, 120, m_tBackingBox.width -16);
			m_tText.setFormat("Istria", 16, 0xff2d1601);
			m_aGraphics = new FlxGroup;
			m_aGraphics.add(m_tBackingBox);
			m_aGraphics.add(m_tText);
			m_aGraphics.exists = false;
		}
		
		public function setIsActive(bActive:Boolean):void
		{
			m_bActive = bActive;
			m_aGraphics.exists = m_bActive;
		}
		
		public function getIsActive():Boolean
		{
			return m_bActive;
		}
		
		public function setText(sString:String):void
		{
			m_tText.text = sString;
		}
	}
}