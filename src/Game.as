package
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	
	import Enemies.Enemies;
	
	import Engine.Locator;
	import Engine.SoundController;
	
	import Items.LocatedItems;
	
	public class Game extends EventDispatcher
	{
		public static var mainStage:Stage;
		public static var userController:UserController;
		public static var camera:Camera;
		public static var hud:HUD;
		public static var world:World;
		public static var character:Character;
		public static var enemies:Enemies;
		public static var locatedItems:LocatedItems;
		
		public static var instance:Game;
		
		public static var allFireballs:Array;
		
		public var backGroundSound:Sound = Locator.assetsManager.GetSoundByName("BackGroundMusic");
		public var fightMusic:Sound = Locator.assetsManager.GetSoundByName("MusicBossFight");
		public var bigDragonMusic:Sound = Locator.assetsManager.GetSoundByName("BigDragonMusic");
		
		public var endOfGame:Boolean;
		
		public function Game()
		{
			instance = this;
			
			if(Main.Sound_BackGround == null)
			{
				PlayMusic();
			}
			if(Main.Sound_BackGround.musicAndSound != backGroundSound)
			{
				RemoveMusic();
				PlayMusic();
			}
			
			Main.scoreManager.Restart();
			Main.scoreManager.StartClock();
			Main.achievementController.StartClock();
			Locator.View = new MovieClip();
			Locator.ContainerHUD = new MovieClip();
			Locator.mainStage.addChild(Locator.View);
			Locator.View.addChild(Locator.ConteinerCurrentBackGround);
			Locator.View.addChild(Locator.ContainerHero);
			Locator.mainStage.addChild(Locator.ContainerHUD);
			
			allFireballs = new Array();
			
			userController = new UserController();
			camera = new Camera();
			hud = new HUD();
			world = new World();
			enemies = new Enemies();
			locatedItems = new LocatedItems();
			locatedItems.SpawnItems();
			camera.RenderInCamera(Locator.CurrentBackGround);
			character = new Character(10, -40);
			camera.SetTarget(character.model);
			
			endOfGame = true;
			
			//character = new Character(10, -40);
			//character = new Character(2800, -200);
			//character = new Character(5600, 0);
		}
		public function PlayMusic():void
		{
			Main.Sound_BackGround = new SoundController(backGroundSound);
			Main.Sound_BackGround.Play(Locator.soundVolume / 2.5,999);
		}
		public function PlayBigDragonMusic():void
		{
			if(Main.Sound_BackGround.musicAndSound != bigDragonMusic)
			{
				Main.Sound_BackGround = new SoundController(bigDragonMusic);
				Main.Sound_BackGround.Play(Locator.soundVolume / 2,999);
			}
		}
		public function PlayFightMusic():void
		{
			if(Main.Sound_BackGround.musicAndSound != fightMusic)
			{
				Main.Sound_BackGround = new SoundController(fightMusic);
				Main.Sound_BackGround.Play(Locator.soundVolume / 2.5,999);
			}
		}
		public function RemoveMusic():void
		{
			Main.Sound_BackGround.Remove();
		}
		public function Update():void
		{
			GameStatus();	
		}
		public function GameStatus():void
		{
			if(endOfGame)
			{
				if(enemies.boss != null)
				{
					if(enemies.boss.dead)
					{
						endOfGame = false;
						Main.scoreManager.StopClock();
						trace("GANASTE");
						Main.achievementController.StopClock();
						Main.achievementController.WinTheGame();
						if(character.extraMedicKit)
						{
							Main.scoreManager.AddScore(Main.scoreManager.finishWithMedicKit);
							Main.achievementController.MedicKitNotUsed();
						}
						Restart();
						Locator.assetsManager.LoadLinks("linksMenu.txt");
						Locator.assetsManager.addEventListener("all_assets_complete", eveVictory);
					}
				}
			}
			if(endOfGame)
			{
				if(character.dead)
				{
					endOfGame = false;
					trace("Perdiste");
					Main.scoreManager.StopClock();
					Main.achievementController.StopClock();
					Main.achievementController.LostTheGame();
					Restart();
					Locator.assetsManager.LoadLinks("linksMenu.txt");
					Locator.assetsManager.addEventListener("all_assets_complete", eveGameOver);
				}
			}
		}
		
		protected function eveVictory(event:Event):void
		{
			DispatchEvent(ScreenGame.eventVictory);
			Locator.assetsManager.removeEventListener("all_assets_complete", eveVictory);
		}
		
		protected function eveGameOver(event:Event):void
		{
			DispatchEvent(ScreenGame.eventGameOver);
			Locator.assetsManager.removeEventListener("all_assets_complete", eveGameOver);
		}
		
		public function DispatchEvent(event:String):void
		{
			dispatchEvent(new Event (event));
		}
		public function Restart():void
		{
			hud.Restart();
			hud = null;
			
			character.Restart();
			character = null;
			
			userController.Restart();
			userController = null;
			
			camera.RenderOutCamera(Locator.CurrentBackGround);
			camera.Restart();
			camera = null;
			
			enemies.Restart();
			enemies = null;
			
			world.Restart();
			world = null;
			
			locatedItems.Restart();
			locatedItems = null;
			
			Locator.mainStage.removeChild(Locator.View);
			Locator.mainStage.removeChild(Locator.ContainerHUD);
		}
	}
}