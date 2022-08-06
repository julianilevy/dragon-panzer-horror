package
{
	import flash.events.MouseEvent;
	
	import Engine.CustomScreen;

	public class ScreenMore extends CustomScreen
	{
		public function ScreenMore()
		{
		}
		override public function Enter():void
		{
			ShowScreen("MC_MoreScreen");
			
			model.Back.addEventListener(MouseEvent.CLICK, evBack);
			model.Back.addEventListener(MouseEvent.MOUSE_OVER, evOverBack);
			model.Back.addEventListener(MouseEvent.MOUSE_OUT, evOutBack);
			model.Achievements.addEventListener(MouseEvent.CLICK, evAchievements);
			model.Achievements.addEventListener(MouseEvent.MOUSE_OVER, evOverAchievements);
			model.Achievements.addEventListener(MouseEvent.MOUSE_OUT, evOutAchievements);
			model.Leaderbord.addEventListener(MouseEvent.CLICK, evLeaderbord);
			model.Leaderbord.addEventListener(MouseEvent.MOUSE_OVER, evOverLeaderbord);
			model.Leaderbord.addEventListener(MouseEvent.MOUSE_OUT, evOutLeaderbord);
			model.HowToPlay.addEventListener(MouseEvent.CLICK, evHowToPlay);
			model.HowToPlay.addEventListener(MouseEvent.MOUSE_OVER, evOverHowToPlay);
			model.HowToPlay.addEventListener(MouseEvent.MOUSE_OUT, evOutHowToPlay);
		}
		protected function evBack(event:MouseEvent):void
		{
			Change("Main Menu");
		}
		protected function evOverBack(event:MouseEvent):void
		{
			model.Back.gotoAndPlay("Over");
		}
		protected function evOutBack(event:MouseEvent):void
		{
			model.Back.gotoAndPlay("Idle");
		}
		protected function evAchievements(event:MouseEvent):void
		{
			Change("Achievements");
		}
		protected function evOverAchievements(event:MouseEvent):void
		{
			model.Achievements.gotoAndPlay("Over");
		}
		protected function evOutAchievements(event:MouseEvent):void
		{
			model.Achievements.gotoAndPlay("Idle");
		}
		protected function evLeaderbord(event:MouseEvent):void
		{
			Change("Leaderboard");
		}
		protected function evOverLeaderbord(event:MouseEvent):void
		{
			model.Leaderbord.gotoAndPlay("Over");
		}
		protected function evOutLeaderbord(event:MouseEvent):void
		{
			model.Leaderbord.gotoAndPlay("Idle");
		}
		protected function evHowToPlay(event:MouseEvent):void
		{
			Change("HowToPlay");
		}
		protected function evOverHowToPlay(event:MouseEvent):void
		{
			model.HowToPlay.gotoAndPlay("Over");
		}
		protected function evOutHowToPlay(event:MouseEvent):void
		{
			model.HowToPlay.gotoAndPlay("Idle");
		}
		override public function Exit():void
		{
			model.Back.removeEventListener(MouseEvent.CLICK, evBack);
			model.Back.removeEventListener(MouseEvent.MOUSE_OVER, evOverBack);
			model.Back.removeEventListener(MouseEvent.MOUSE_OUT, evOutBack);
			model.Achievements.removeEventListener(MouseEvent.CLICK, evAchievements);
			model.Achievements.removeEventListener(MouseEvent.MOUSE_OVER, evOverAchievements);
			model.Achievements.removeEventListener(MouseEvent.MOUSE_OUT, evOutAchievements);
			model.Leaderbord.removeEventListener(MouseEvent.CLICK, evLeaderbord);
			model.Leaderbord.removeEventListener(MouseEvent.MOUSE_OVER, evOverLeaderbord);
			model.Leaderbord.removeEventListener(MouseEvent.MOUSE_OUT, evOutLeaderbord);
			model.HowToPlay.removeEventListener(MouseEvent.CLICK, evHowToPlay);
			model.HowToPlay.removeEventListener(MouseEvent.MOUSE_OVER, evOverHowToPlay);
			model.HowToPlay.removeEventListener(MouseEvent.MOUSE_OUT, evOutHowToPlay);
			
			Main.ScreenContainer.removeChild(model);
		}
	}
}