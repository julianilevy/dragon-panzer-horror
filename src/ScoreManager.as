package
{
	import Engine.Locator;

	public class ScoreManager
	{
		public var starterTime:int = 240000;
		public var timePlaying:Number;
		public var startClock:Boolean;
		public var score:int;
		
		public var dragonKill:int = 2000000;
		public var bossKill:int = 20000000;
		public var damaged:int = 500000;
		public var usedBullet:int = 500000;
		public var finishWithMedicKit:int = 3500000;
		public var heal:int = 1000000;
		public var pickUpgrade:int = 5000000;
		public var dead:int = 20000000;
		
		public function ScoreManager()
		{
			startClock = false;
			timePlaying = starterTime;
			score = 0;
		}
		public function Update():void
		{
			Time();
		}
		public function Time():void
		{
			//if(startClock)
			//{
			timePlaying -= 1000/Locator.mainStage.frameRate;
			//}
		}
		public function StartClock():void
		{
			Locator.updateManager.AddCallback(Update);
			//startClock = true;
		}
		public function StopClock():void
		{
			Locator.updateManager.RemoveCallback(Update);
			//startClock = false;
		}
		public function AddScore(value:int):void
		{
			score += value;
		}
		public function RemoveScore(value:int):void
		{
			score -= value;	
		}
		public function GetScore():int
		{
			var multiply:int;
			var auxScore:int;
			if(timePlaying > 0)
			{
				multiply = 10000;
			}else
			{
				multiply = 500;
			}
			auxScore = (timePlaying * multiply) + score;
			trace(score);
			trace(timePlaying);
			trace(auxScore);
			return auxScore;
		}
		public function GetScoreIfLost():int
		{
			var auxScore:int;
			auxScore = ((starterTime - timePlaying) * 50) + score;
			return auxScore;
		}
		public function Restart():void
		{
			Locator.updateManager.RemoveCallback(Update);
			timePlaying = starterTime;
			score = 0;
		}
	}
}