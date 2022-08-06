package
{
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	
	import Engine.CustomScreen;
	import Engine.Locator;
	import Engine.SoundController;

	public class MainMenu extends CustomScreen
	{
		public var menuSong:Sound = Locator.assetsManager.GetSoundByName("MusicMainMenu");
		
		public function MainMenu()
		{
			super();
		}
		
		override public function Enter():void
		{
			if(Main.Sound_BackGround == null)
			{
				PlayMusic();
			}
			if(Main.Sound_BackGround.musicAndSound != menuSong)
			{
				Main.Sound_BackGround.Remove();
				PlayMusic();
			}
			
			ShowScreen("MC_MainMenu");
			
			model.Start.addEventListener(MouseEvent.CLICK, evStart);
			model.Start.addEventListener(MouseEvent.MOUSE_OVER, evOverStart);
			model.Start.addEventListener(MouseEvent.MOUSE_OUT, evOutStart);
			model.Options.addEventListener(MouseEvent.CLICK, evOptions);
			model.Options.addEventListener(MouseEvent.MOUSE_OVER, evOverOptions);
			model.Options.addEventListener(MouseEvent.MOUSE_OUT, evOutOptions);
			model.Exit.addEventListener(MouseEvent.CLICK, evExit);
			model.Exit.addEventListener(MouseEvent.MOUSE_OVER, evOverExit);
			model.Exit.addEventListener(MouseEvent.MOUSE_OUT, evOutExit);
			model.More.addEventListener(MouseEvent.CLICK, evMore);
			model.More.addEventListener(MouseEvent.MOUSE_OVER, evOverMore);
			model.More.addEventListener(MouseEvent.MOUSE_OUT, evOutMore);
		}
		protected function PlayMusic():void
		{
			Main.Sound_BackGround = new SoundController(menuSong);
			Main.Sound_BackGround.Play(Locator.soundVolume / 2.5,999);
		}
		protected function evStart(event:MouseEvent):void
		{
			Locator.assetsManager.LoadLinks("linksGame.txt");
			Locator.assetsManager.addEventListener("all_assets_complete", eveGame);
		}
		
		protected function eveGame(event:Event):void
		{
			Change("Game");
		}
		
		protected function evOverStart(event:MouseEvent):void
		{
			model.Start.gotoAndPlay("Over");
		}
		protected function evOutStart(event:MouseEvent):void
		{
			model.Start.gotoAndPlay("Idle");
		}
		protected function evOptions(event:MouseEvent):void
		{
			Change("Options");
		}
		protected function evOverOptions(event:MouseEvent):void
		{
			model.Options.gotoAndPlay("Over");
		}
		protected function evOutOptions(event:MouseEvent):void
		{
			model.Options.gotoAndPlay("Idle");
		}
		protected function evExit(event:MouseEvent):void
		{
			Main.achievementController.Save();
			NativeApplication.nativeApplication.exit();
		}
		protected function evOverExit(event:MouseEvent):void
		{
			model.Exit.gotoAndPlay("Over");
		}
		protected function evOutExit(event:MouseEvent):void
		{
			model.Exit.gotoAndPlay("Idle");
		}
		protected function evMore(event:MouseEvent):void
		{
			Change("More");
		}
		protected function evOverMore(event:MouseEvent):void
		{
			model.More.gotoAndPlay("Over");
		}
		protected function evOutMore(event:MouseEvent):void
		{
			model.More.gotoAndPlay("Idle");
		}
		override public function Exit():void
		{
			model.Start.removeEventListener(MouseEvent.CLICK, evStart);
			model.Start.removeEventListener(MouseEvent.MOUSE_OVER, evOverStart);
			model.Start.removeEventListener(MouseEvent.MOUSE_OUT, evOutStart);
			model.Options.removeEventListener(MouseEvent.CLICK, evOptions);
			model.Options.removeEventListener(MouseEvent.MOUSE_OVER, evOverOptions);
			model.Options.removeEventListener(MouseEvent.MOUSE_OUT, evOutOptions);
			model.Exit.removeEventListener(MouseEvent.CLICK, evExit);
			model.Exit.removeEventListener(MouseEvent.MOUSE_OVER, evOverExit);
			model.Exit.removeEventListener(MouseEvent.MOUSE_OUT, evOutExit);
			model.More.removeEventListener(MouseEvent.CLICK, evMore);
			model.More.removeEventListener(MouseEvent.MOUSE_OVER, evOverMore);
			model.More.removeEventListener(MouseEvent.MOUSE_OUT, evOutMore);
			
			Main.ScreenContainer.removeChild(model);
			Locator.assetsManager.removeEventListener("all_assets_complete", eveGame);
		}
	}
}