package
{
	import Engine.Locator;

	public class LeaderboardController
	{
		public static var highscore:Array = new Array(0,0,0,0,0);
		public static var highscoreName:Array = new Array("", "", "", "", "");
		
		public static var maxHighscore:int;
		public static var minHighscore:int = 0;
		
		public function LeaderboardController()
		{
			if(Locator.saveManager.leaderboarFile.exists)
			{
				var loadLeaderboard:Object = Locator.saveManager.LoadObject(Locator.saveManager.leaderboarFile, Locator.saveManager.leaderboarSaver);
				for(var optionsVarName:String in loadLeaderboard)
				{
					LeaderboardController[optionsVarName] = loadLeaderboard[optionsVarName];
				}
			}else
			{
				var objToSAVE:Object = new Object;
				Locator.saveManager.SaveObject(objToSAVE, Locator.saveManager.leaderboarFile, Locator.saveManager.leaderboarSaver);
			}
		}
		public function addHighscore(value:int):void
		{
			var aux:int;
			for(var i : int = 0; i < 5; i++)
			{
				if(value > highscore[i])
				{
					aux = highscore[i];
					highscore[i] = value;
					value = aux;
				}
			}
			GetScores();
			SaveLeaderboard();
		}
		public function AddHighScoreWithName(value:int, name:String):void
		{
			var aux:int;
			var auxName:String;
			for(var i : int = 0; i < 5; i++)
			{
				if(value > highscore[i])
				{
					aux = highscore[i];
					auxName = highscoreName[i];
					highscore[i] = value;
					highscoreName[i] = name;
					value = aux;
					name = auxName;
				}
			}
			GetScores();
			SaveLeaderboard();
		}
		public function GetScores():void
		{
			maxHighscore = highscore[0];
			minHighscore = highscore[4];
		}
		public function SaveLeaderboard():void
		{
			var LeaderbordToSave:Object = new Object;
			
			LeaderbordToSave.highscore = highscore;
			LeaderbordToSave.highscoreName = highscoreName;
			
			Locator.saveManager.SaveObject(LeaderbordToSave, Locator.saveManager.leaderboarFile, Locator.saveManager.leaderboarSaver);
		}
	}
}