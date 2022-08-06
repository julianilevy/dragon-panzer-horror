package Engine
{
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	
	[Event(name="Change", type="myEngine.ScreenEvent")]
	[Event(name="Enter", type="myEngine.ScreenEvent")]
	[Event(name="Exit", type="myEngine.ScreenEvent")]
	[Event(name="Update", type="myEngine.ScreenEvent")]

	public class CustomScreen extends EventDispatcher
	{
		public var model:MovieClip;
		
		public function CustomScreen()
		{
			
		}
		public function Enter():void
		{
			
		}
		public function Update():void
		{
			
		}
		public function Exit():void
		{
			
		}
		public function ShowScreen(MCNameClass:String):void
		{
			model = Locator.assetsManager.GetMovieClipsByName(MCNameClass);
			Main.ScreenContainer.addChild(model);
		}
		public function Change(Target:String):void
		{
			var MyScreenEvent:ScreenEvent = new ScreenEvent("Change");
			MyScreenEvent.TargetScreen = Target;
			MyScreenEvent.Parameters.push("Screen");
			
			dispatchEvent(MyScreenEvent);
		}
	}
}