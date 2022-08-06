package
{
	import flash.events.MouseEvent;
	
	import Engine.CustomScreen;

	public class ScreenGameOver extends CustomScreen
	{
		public var score:int;
		public function ScreenGameOver()
		{
		}
		override public function Enter():void
		{
			ShowScreen("MC_GameOverScreen");
			
			score = Main.scoreManager.GetScoreIfLost();
			
			model.tb_YourScore.text = score.toString();
			
			model.MainMenu.addEventListener(MouseEvent.CLICK, evMainMenu);
			model.MainMenu.addEventListener(MouseEvent.MOUSE_OVER, evOverMainMenu);
			model.MainMenu.addEventListener(MouseEvent.MOUSE_OUT, evOutMainMenu);
		}
		protected function evMainMenu(event:MouseEvent):void
		{
			Change("Main Menu");
		}
		protected function evOverMainMenu(event:MouseEvent):void
		{
			model.MainMenu.gotoAndPlay("Over");
		}
		protected function evOutMainMenu(event:MouseEvent):void
		{
			model.MainMenu.gotoAndPlay("Idle");
		}
		override public function Exit():void
		{
			model.MainMenu.removeEventListener(MouseEvent.CLICK, evMainMenu);
			model.MainMenu.removeEventListener(MouseEvent.MOUSE_OVER, evOverMainMenu);
			model.MainMenu.removeEventListener(MouseEvent.MOUSE_OUT, evOutMainMenu);
			
			Main.ScreenContainer.removeChild(model);
		}
	}
}