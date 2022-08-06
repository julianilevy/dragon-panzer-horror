package
{
	import flash.display.MovieClip;
	
	import Engine.Locator;

	public class Light
	{
		public var model:MovieClip = Locator.assetsManager.GetMovieClipsByName("MC_Light");
		public var upgradedModel:MovieClip = Locator.assetsManager.GetMovieClipsByName("MC_LightUpgraded");
		public var target:MovieClip;
		public var currentScale:Number;
		public var directionX:int;
		public var fixPosX:int = 12;
		public var upgraded:Boolean;
		
		public function Light()
		{
			model.scaleX = model.scaleY = currentScale = 1;
			
			Game.world.model.lightLayer.addChild(model);
			Locator.updateManager.AddCallback(Update);
		}
		
		public function SetTarget(settarget:MovieClip):void
		{
			target = settarget;
		}
		
		public function Update():void
		{
			Follow();
			UpgradeLight();
		}
		
		public function Rotation(dirX : Number):void
		{
			directionX = dirX;
			if(!upgraded) model.scaleX = dirX * currentScale;
			else upgradedModel.scaleX = dirX * currentScale;
		}
		
		public function Follow():void
		{
			if(!upgraded)
			{
				model.x = target.x + fixPosX * directionX;
				model.y = target.y;
			}
			else
			{
				upgradedModel.x = target.x + fixPosX * directionX;
				upgradedModel.y = target.y;
			}
		}
		
		public function UpgradeLight():void
		{
			if(!upgraded && Game.character.upgradedLight)
			{
				Game.world.model.lightLayer.addChild(upgradedModel);
				fixPosX = 17;
				model.parent.removeChild(model);
				upgraded = true;
			}
			if(Game.character.allVisible)
			{
				model.alpha = 0;
				upgradedModel.alpha = 0;
			}
		}
		public function Restart():void
		{
			Locator.updateManager.RemoveCallback(Update);
		}
	}
}