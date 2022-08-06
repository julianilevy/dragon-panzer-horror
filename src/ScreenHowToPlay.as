package
{
	import flash.events.MouseEvent;
	
	import Engine.CustomScreen;

	public class ScreenHowToPlay extends CustomScreen
	{
		public function ScreenHowToPlay()
		{
		}
		override public function Enter():void
		{
			ShowScreen("MC_HowToPlayScreen");
			
			/*model.tb_HighScore1.Text += 1000;
			model.tb_HighScore2.Text += 1000;
			model.tb_HighScore3.Text += 1000;
			model.tb_HighScore4.Text += 1000;
			model.tb_HighScore5.Text += 1000;*/
			
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