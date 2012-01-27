package
{
	import org.flixel.*;
 
	public class LevelsCompleted
	{
		private static var _save:FlxSave; //The FlxSave instance #http://flixel.org/docs/org/flixel/FlxSave.html#
		private static var _temp:int = 0; //Holds level data if bind() did not work. This is not persitent, and will be deleted when the application ends
		private static var _loaded:Boolean = false; //Did bind() work? Do we have a valid SharedObject?
 
		/**
		 * Returns the number of levels that the player has completed
		 */
		public static function get levels():int
		{
			//We only get data from _save if it was loaded properly. Otherwise, use _temp
			if (_loaded)
			{
				return _save.data.levels;
			}
			else
			{
				return _temp;
			}
		}
 
		/**
		 * Sets the number of levels that the player has completed
		 */
		public static function set levels(value:int):void
		{
			if (_loaded)
			{
				_save.data.levels = value;
			}
			else
			{
				_temp = value;
			}
		}
 
		/**
		 * Setup LevelsCompleted
		 */
		public static function load():void
		{
			_save = new FlxSave();
			_loaded = _save.bind("myLevelData");
			
			/**
			 * Create the save if it the save is null
			 */
			if (_loaded && _save.data.levels == null)
			{
				_save.data.levels = 0;
			}
		}
	}
}