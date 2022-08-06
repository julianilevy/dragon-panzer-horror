package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import Engine.Locator;

	public class BulletExplosion
	{
		public var model:MovieClip = Locator.assetsManager.GetMovieClipsByName("MC_BulletExplosion");
		public var currentScale:Number;
		public var destroyed:Boolean;
		
		public function BulletExplosion(PosX:Number, PosY:Number)
		{
			Game.world.model.lightLayer.addChild(model);
			model.x = PosX;
			model.y = PosY;
			model.scaleX = model.scaleY = currentScale = 1;
			
			model.addEventListener("Destroy", Destroy);
		}
		
		public function Destroy(event:Event):void
		{
			if(!destroyed)
			{
				model.parent.removeChild(model);
				destroyed = true;
			}
		}
	}
}