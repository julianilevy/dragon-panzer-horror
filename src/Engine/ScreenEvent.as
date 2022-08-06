package Engine
{
	import flash.events.Event;

	public class ScreenEvent extends Event
	{
		public static var CHANGE:String = "Change";
		public static var ENTER:String = "Enter";
		public static var EXIT:String = "Exit";
		public static var UPDATE:String = "Update";
		
		public var TargetScreen:String;
		public var Parameters:Array = new Array();
		
		public function ScreenEvent(Type:String, Cancelable:Boolean = false)
		{
			super(Type, Cancelable);
		}
	}
}