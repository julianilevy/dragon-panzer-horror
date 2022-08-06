package
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	import Engine.CustomScreen;

	public class ScreenGame extends CustomScreen
	{
		public var game:Game;
		public static var eventVictory:String = "Victory";
		public static var eventGameOver:String = "GameOver";
		public function ScreenGame()
		{
		}
		override public function Enter():void
		{
			game = new Game();
			game.addEventListener(eventVictory, evVictory);
			game.addEventListener(eventGameOver, evGameOver);
		}
		
		protected function EvKeyDown(event:KeyboardEvent):void
		{
		}
		override public function Update():void
		{
			game.Update();
		}
		protected function evVictory(event:Event):void
		{
			Change(eventVictory);
		}
		protected function evGameOver(event:Event):void
		{
			Change(eventGameOver);
		}
		override public function Exit():void
		{
			game.removeEventListener(eventVictory, evVictory);
			game.removeEventListener(eventGameOver, evGameOver);
		}
	}
}