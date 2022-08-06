package
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import Engine.Locator;
	import Engine.SoundController;
	
	[SWF(frameRate="60", backgroundColor="0x000000", width="1920", height="1080")]
	
	public class Main extends Locator
	{
		public static var mainStage:Stage;
		
		public static var leaderboardController:LeaderboardController;
		public static var achievementController:AchievementController;
		public static var scoreManager:ScoreManager;
		
		public static var ScreenContainer:Sprite = new Sprite();
		public static var ScreenTransition:Sprite = new Sprite();
		public static var Sound_BackGround:SoundController;
		
		public function Main()
		{
			mainStage = stage;
			stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			stage.scaleMode = StageScaleMode.EXACT_FIT;
			
			Locator.mainStage.addChild(ScreenContainer);
			Locator.mainStage.addChild(ScreenTransition);
			
			Locator.assetsManager.LoadLinks("linksMenu.txt");
			Locator.assetsManager.addEventListener("all_assets_complete", EvStartGame);
		}
		public function EvStartGame(event:Event):void
		{
			leaderboardController = new LeaderboardController();
			achievementController = new AchievementController();
			scoreManager = new ScoreManager();
			
			Locator.screenManager.Transition = Locator.assetsManager.GetMovieClipsByName("MC_Transition");
			Locator.screenManager.RegisterScreen("Intro Anim", ScreenIntro);
			Locator.screenManager.RegisterScreen("Main Menu", MainMenu);
			Locator.screenManager.RegisterScreen("Options", ScreenOptions);
			Locator.screenManager.RegisterScreen("More", ScreenMore);
			Locator.screenManager.RegisterScreen("Leaderboard", ScreenLeaderboard);
			Locator.screenManager.RegisterScreen("HowToPlay", ScreenHowToPlay);
			Locator.screenManager.RegisterScreen("Achievements", ScreenAchievements);
			Locator.screenManager.RegisterScreen("Game", ScreenGame);
			Locator.screenManager.RegisterScreen("Victory", ScreenVictory);
			Locator.screenManager.RegisterScreen("GameOver", ScreenGameOver);
			
			if(Locator.saveManager.optionsFile.exists)
			{
				var loadOptions:Object = Locator.saveManager.LoadObject(Locator.saveManager.optionsFile, Locator.saveManager.optionsSaver);
				for(var optionsVarName:String in loadOptions)
				{
					Locator[optionsVarName] = loadOptions[optionsVarName];
				}
			}else
			{
				var objToSAVE:Object = new Object;
				Locator.saveManager.SaveObject(objToSAVE, Locator.saveManager.optionsFile, Locator.saveManager.optionsSaver);
			}
			
			if(!Locator.fullScreen)
			{
				Main.mainStage.displayState = StageDisplayState.NORMAL;
			}else if(Locator.fullScreen)
			{
				Main.mainStage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			}
			
			Locator.screenManager.LoadScreen("Intro Anim");
			Locator.assetsManager.removeEventListener("all_assets_complete", EvStartGame);
			//Locator.screenManager.LoadScreen("Victory");
		}
	}
}