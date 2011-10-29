//Code generated with DAME. http://www.dambots.com

package 
{
	import org.flixel.*;
	public class BaseLevel
	{
		public var masterLayer:FlxGroup = new FlxGroup;

		public var mainLayer:FlxTilemap;

		public var boundsMinX:int;
		public var boundsMinY:int;
		public var boundsMaxX:int;
		public var boundsMaxY:int;

		public function BaseLevel() { }

		public function addSpriteToLayer(type:Class, group:FlxGroup, x:Number, y:Number, angle:Number, flipped:Boolean, scrollX:Number, scrollY:Number, onAddCallback:Function = null):FlxSprite
		{
			var obj:FlxSprite = new type(x, y);
			obj.x += obj.offset.x;
			obj.y += obj.offset.y;
			obj.angle = angle;
			// Only override the facing value if the class didn't change it from the default.
			if( obj.facing == FlxObject.RIGHT )
				obj.facing = flipped ? FlxObject.LEFT : FlxObject.RIGHT;
			obj.scrollFactor.x = scrollX;
			obj.scrollFactor.y = scrollY;
			group.add(obj);
			if(onAddCallback != null)
				onAddCallback(obj, group);
			return obj;
		}

		virtual public function addSpritesForLayerGroup2Layer1(onAddCallback:Function = null):void { }
	}
}
