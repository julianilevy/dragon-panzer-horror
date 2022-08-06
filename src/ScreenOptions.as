package
{
	import flash.display.StageDisplayState;
	import flash.events.MouseEvent;
	
	import Engine.CustomScreen;
	import Engine.Locator;

	public class ScreenOptions extends CustomScreen
	{
		public var soundVol:int;
		public function ScreenOptions()
		{
		}
		override public function Enter():void
		{
			ShowScreen("MC_OptionsScreen");
			trace(Locator.soundVolume * 100);
			model.SoundBar.gotoAndStop(Locator.soundVolume * 100);
			
			if(!Locator.fullScreen)
			{
				model.FullScreenButton.gotoAndStop("off");	
			}else if(Locator.fullScreen)
			{
				model.FullScreenButton.gotoAndStop("on");
			}
			
			model.Back.addEventListener(MouseEvent.CLICK, evBack);
			model.Back.addEventListener(MouseEvent.MOUSE_OVER, evOverBack);
			model.Back.addEventListener(MouseEvent.MOUSE_OUT, evOutBack);
			model.Plus.addEventListener(MouseEvent.CLICK, evPlus);
			model.Plus.addEventListener(MouseEvent.MOUSE_OVER, evOverPlus);
			model.Plus.addEventListener(MouseEvent.MOUSE_OUT, evOutPlus);
			model.Less.addEventListener(MouseEvent.CLICK, evLess);
			model.Less.addEventListener(MouseEvent.MOUSE_OVER, evOverLess);
			model.Less.addEventListener(MouseEvent.MOUSE_OUT, evOutLess);
			model.FullScreenButton.addEventListener(MouseEvent.CLICK, evFullScreen);
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
		protected function evPlus(event:MouseEvent):void
		{
			if(MultiplyX100(Locator.soundVolume) < MultiplyX100(Locator.maxVolume))
			{
				soundVol = MultiplyX100(Locator.soundVolume) + 1;
				if(soundVol + 0.5 < MultiplyX100(Locator.soundVolume) + 1)
				{
					soundVol += 1;
				}
				//soundVol = MultiplyX100(Locator.soundVolume) + 5;
				Locator.soundVolume = soundVol / MultiplyX100(Locator.maxVolume);
				Main.Sound_BackGround.Volume(Locator.soundVolume);
				model.SoundBar.gotoAndStop(soundVol);
			}
		}
		protected function evOverPlus(event:MouseEvent):void
		{
			model.Plus.gotoAndPlay("Over");
		}
		protected function evOutPlus(event:MouseEvent):void
		{
			model.Plus.gotoAndPlay("Idle");
		}
		protected function evLess(event:MouseEvent):void
		{
			if(MultiplyX100(Locator.soundVolume) > 0)
			{
				soundVol = MultiplyX100(Locator.soundVolume) - 1;
				//soundVol = MultiplyX100(Locator.soundVolume) - 5;
				Locator.soundVolume = soundVol / MultiplyX100(Locator.maxVolume);
				Main.Sound_BackGround.Volume(Locator.soundVolume);
				model.SoundBar.gotoAndStop(soundVol);
			}
		}
		public function MultiplyX100(num:Number):Number
		{
			return (num * 100);
		}
		protected function evOverLess(event:MouseEvent):void
		{
			model.Less.gotoAndPlay("Over");
		}
		protected function evOutLess(event:MouseEvent):void
		{
			model.Less.gotoAndPlay("Idle");
		}
		protected function evFullScreen(event:MouseEvent):void
		{
			trace("Cabe");
			if(!Locator.fullScreen)
			{
				Locator.fullScreen = true;	
				model.FullScreenButton.gotoAndStop("on");
				Main.mainStage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			}else if(Locator.fullScreen)
			{
				Locator.fullScreen = false;
				model.FullScreenButton.gotoAndStop("off");
				Main.mainStage.displayState = StageDisplayState.NORMAL;
			}
		}
		override public function Exit():void
		{
			var optionsToSave:Object = new Object;
				
			optionsToSave.soundVolume = Locator.soundVolume;
			optionsToSave.fullScreen = Locator.fullScreen;
				
			Locator.saveManager.SaveObject(optionsToSave, Locator.saveManager.optionsFile, Locator.saveManager.optionsSaver);
			
			model.Back.removeEventListener(MouseEvent.CLICK, evBack);
			model.Back.removeEventListener(MouseEvent.MOUSE_OVER, evOverBack);
			model.Back.removeEventListener(MouseEvent.MOUSE_OUT, evOutBack);
			model.Plus.removeEventListener(MouseEvent.CLICK, evPlus);
			model.Plus.removeEventListener(MouseEvent.MOUSE_OVER, evOverPlus);
			model.Plus.removeEventListener(MouseEvent.MOUSE_OUT, evOutPlus);
			model.Less.removeEventListener(MouseEvent.CLICK, evLess);
			model.Less.removeEventListener(MouseEvent.MOUSE_OVER, evOverLess);
			model.Less.removeEventListener(MouseEvent.MOUSE_OUT, evOutLess);
			model.FullScreenButton.removeEventListener(MouseEvent.CLICK, evFullScreen);
			
			Main.ScreenContainer.removeChild(model);
		}
	}
}
