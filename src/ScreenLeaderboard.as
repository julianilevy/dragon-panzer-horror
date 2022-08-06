package
{
	import flash.events.MouseEvent;
	
	import Engine.CustomScreen;

	public class ScreenLeaderboard extends CustomScreen
	{
		public function ScreenLeaderboard()
		{
		}
		override public function Enter():void
		{
			ShowScreen("MC_LeaderboardScreen");
			
			model.tb_HighScore1.text = LeaderboardController.highscoreName[0] + " " + LeaderboardController.highscore[0].toString();
			model.tb_HighScore2.text = LeaderboardController.highscoreName[1] + " " + LeaderboardController.highscore[1].toString();
			model.tb_HighScore3.text = LeaderboardController.highscoreName[2] + " " + LeaderboardController.highscore[2].toString();
			model.tb_HighScore4.text = LeaderboardController.highscoreName[3] + " " + LeaderboardController.highscore[3].toString();
			model.tb_HighScore5.text = LeaderboardController.highscoreName[4] + " " + LeaderboardController.highscore[4].toString();
			
			model.Back.addEventListener(MouseEvent.CLICK, evBack);
			model.Back.addEventListener(MouseEvent.MOUSE_OVER, evOverBack);
			model.Back.addEventListener(MouseEvent.MOUSE_OUT, evOutBack);
		}
		protected function evBack(event:MouseEvent):void
		{
			Change("More");
		}
		protected function evOverBack(event:MouseEvent):void
		{
			model.Back.gotoAndPlay("Over");
		}
		protected function evOutBack(event:MouseEvent):void
		{
			model.Back.gotoAndPlay("Idle");
		}
		override public function Exit():void
		{
			model.Back.removeEventListener(MouseEvent.CLICK, evBack);
			model.Back.removeEventListener(MouseEvent.MOUSE_OVER, evOverBack);
			model.Back.removeEventListener(MouseEvent.MOUSE_OUT, evOutBack);
			
			Main.ScreenContainer.removeChild(model);
		}
	}
}