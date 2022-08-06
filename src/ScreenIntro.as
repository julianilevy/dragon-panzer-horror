package
{
	import flash.events.Event;
	
	import Engine.CustomScreen;
	import Engine.Locator;

	public class ScreenIntro extends CustomScreen
	{
		public var mainMenu:MainMenu;
		public var animEnded:Boolean;
		public var timeToChangeScreen:Number = 1000;
		public var currentTimeToBeOnChangeScreen:Number = timeToChangeScreen;
		public function ScreenIntro()
		{
			super();
		}
		override public function Enter():void
		{
			animEnded = false;
			ShowScreen("MC_IntroAnim");
			model.addEventListener("IntroAnimEND", evAnimEND);
		}
		override public function Update():void
		{
			if(animEnded)
			{
				currentTimeToBeOnChangeScreen -= 1000/Locator.mainStage.frameRate;
				if(currentTimeToBeOnChangeScreen <= 0)
				{
					currentTimeToBeOnChangeScreen = timeToChangeScreen;
					Change("Main Menu");
				}
			}
		}
		override public function Exit():void
		{
			animEnded = false;
			Main.ScreenContainer.removeChild(model);
		}
		public function evAnimEND(event:Event):void
		{
			animEnded = true;
		}
	}
}