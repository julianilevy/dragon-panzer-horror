package
{
	import flash.events.MouseEvent;
	
	import Engine.CustomScreen;

	public class ScreenVictory extends CustomScreen
	{
		public var maxCharacters:int = 5;
		public var name:String = "";
		public var score:int;
		
		public function ScreenVictory()
		{
		}
		override public function Enter():void
		{
			ShowScreen("MC_Victory");
			
			score = Main.scoreManager.GetScore();
			
			model.tb_YourScore.text = score;
			model.tb_HighScore.text = LeaderboardController.highscoreName[0] + " " + LeaderboardController.highscore[0].toString();
			
			model.MainMenu.addEventListener(MouseEvent.CLICK, evMainMenu);
			model.MainMenu.addEventListener(MouseEvent.MOUSE_OVER, evOverMainMenu);
			model.MainMenu.addEventListener(MouseEvent.MOUSE_OUT, evOutMainMenu);
		}
		override public function Update():void
		{
			if(model.tb_Name.text.length <= maxCharacters)
			{
				name = model.tb_Name.text;
			}
			if(model.tb_Name.text.length > maxCharacters)
			{
				model.tb_Name.text = name;
			}
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
			Main.leaderboardController.AddHighScoreWithName(score, model.tb_Name.text)
				
			model.MainMenu.removeEventListener(MouseEvent.CLICK, evMainMenu);
			model.MainMenu.removeEventListener(MouseEvent.MOUSE_OVER, evOverMainMenu);
			model.MainMenu.removeEventListener(MouseEvent.MOUSE_OUT, evOutMainMenu);
			
			Main.ScreenContainer.removeChild(model);
		}
	}
}