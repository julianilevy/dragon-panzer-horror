package
{
	import flash.display.MovieClip;
	
	import Engine.Locator;

	public class HUD
	{
		public var model:MovieClip = Locator.assetsManager.GetMovieClipsByName("MC_HUD");
		public var currentScale:Number;
		public var hudHealth:int;
		public var hudHealthSetted:Boolean;
		
		public function HUD()
		{
			Locator.ContainerHUD.addChild(model);
			model.x = 25;
			model.y = 25;
			model.scaleX = model.scaleY = currentScale = 1.7;
			model.HudLifeBar.gotoAndStop(100);
			
			Locator.updateManager.AddCallback(Update);
		}
		
		public function Update():void
		{
			if(Game.character.model != null)
			{
				CheckHealth();
				CheckAmmo();
				CheckMedicKit();
			}
		}
		
		public function CheckHealth():void
		{
			if(!hudHealthSetted)
			{
				hudHealth = Game.character.health;
				hudHealthSetted = true;
			}
			
			if(hudHealth > Game.character.health)
			{
				if(model.HudLifeBar.currentFrame != Game.character.health * 100 / Game.character.maxHealth) model.HudLifeBar.prevFrame();
				else hudHealth = Game.character.health;
			}
			if(hudHealth < Game.character.health)
			{
				if(model.HudLifeBar.currentFrame != Game.character.health * 100 / Game.character.maxHealth) model.HudLifeBar.nextFrame();
				else hudHealth = Game.character.health;
			}
		}
		
		public function CheckAmmo():void
		{
			if(Game.character.ammo < 10) model.HUDAmmo.amount.text = "X 0" + Game.character.ammo;
			else model.HUDAmmo.amount.text = "X " + Game.character.ammo;
		}
		
		public function CheckMedicKit():void
		{
			if(Game.character.extraMedicKit) ChangeAnimation(model.HUDMEdiKit, "HaveMEdiKit");
			else ChangeAnimation(model.HUDMEdiKit, "NoMediKit");
		}
		
		public function ChangeAnimation(mcModel:MovieClip, animationName:String):void
		{
			if (mcModel.currentLabel != animationName) mcModel.gotoAndPlay(animationName);
		}
		public function Restart():void
		{
			Locator.ContainerHUD.removeChild(model);
			Locator.updateManager.RemoveCallback(Update);
		}
	}
}