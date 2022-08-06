package Engine
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import Engine.AssetsManager;
	import Engine.InputManager;
	import Engine.SaveManager;
	import Engine.UpdateManager;
	
	public class Locator extends Sprite
	{
		public static var mainStage:Stage;
		public static var console:Console;
		
		public static var soundVolume:Number = 1;
		public static var maxVolume:Number = 1;
		public static var fullScreen:Boolean = true;
		
		public static var assetsManager:AssetsManager;
		public static var screenManager:ScreenManager;
		public static var updateManager:UpdateManager;
		public static var inputManager:InputManager;
		public static var saveManager:SaveManager;
		
		public static var View:MovieClip = new MovieClip();
		public static var CurrentBackGround:MovieClip;
		public static var ConteinerCurrentBackGround:MovieClip = new MovieClip();
		public static var ContainerHero:MovieClip = new MovieClip();
		public static var ContainerHUD:MovieClip = new MovieClip();
		
		public function Locator()
		{
			mainStage = stage;
			console = new Console();
			assetsManager = new AssetsManager();
			updateManager = new UpdateManager();
			screenManager = new ScreenManager();
			inputManager = new InputManager();
			saveManager = new SaveManager();
		}
	}
}