package Engine
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Dictionary;

	public class ScreenManager
	{
		public var AllScreens:Dictionary = new Dictionary();
		public var MyCurrentScreen:CustomScreen;
		public var Transition:MovieClip;
		public var isinTransition:Boolean;
		public var TargetScreenAfterTransition:String;
		
		public function ScreenManager()
		{
			trace("Inicio ScreenManager");
			
			Locator.updateManager.AddCallback(evUpdate);
			//Locator.mainStage.addEventListener(Event.ENTER_FRAME, evUpdate);
		}
		protected function evTransitionComplete(event:Event):void
		{
			LoadScreen(TargetScreenAfterTransition);
		}	
		protected function evUpdate(/*event:Event*/):void
		{
			if(MyCurrentScreen != null)
			{
				MyCurrentScreen.Update();
			}
		}
		public function RegisterScreen(Name:String, ScrennClass:Class):void
		{
			AllScreens[Name] = ScrennClass;
		}
		public function LoadScreen(Name:String):void
		{
			if(MyCurrentScreen != null)
			{
				MyCurrentScreen.Exit();
				MyCurrentScreen = null;
			}
			
			var myScreenClass:Class = AllScreens[Name];
			
			if(myScreenClass != null)
			{
				MyCurrentScreen = new myScreenClass();
				MyCurrentScreen.addEventListener("Change", evChange);
				MyCurrentScreen.Enter();
				
				//Transition.play();
			}else
			{
				Locator.console.Write("Could not Found Screen " + Name);
			}
		}
		protected function evChange(event:ScreenEvent):void
		{
			/*Main.ScreenTransition.addChild(Transition);
			Transition.gotoAndStop(1);
			Transition.addEventListener("LoadScren", evTransitionComplete);
			Transition.play();*/
			MyCurrentScreen.removeEventListener("Change", evChange)
			TargetScreenAfterTransition = event.TargetScreen;
			LoadScreen(TargetScreenAfterTransition);
		}
	}
}