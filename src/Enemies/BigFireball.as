package Enemies
{
	import flash.display.MovieClip;
	
	import Engine.Locator;
	
	public class BigFireball
	{
		public var model:MovieClip = Locator.assetsManager.GetMovieClipsByName("MC_BigFireball");
		public var currentScale:Number;
		public var directionX:Number;
		public var damage:Number = 1;
		public var speed:Number = 3;
		public var destroyed:Boolean;
		
		private var _radians:Number;
		private var _distanceX:Number;
		private var _distanceY:Number;
		private var _dirX:Number;
		private var _dirY:Number;
		private var _fixPosX:Number = 20;
		private var _fixPosY:Number = -410;
		private var _timeToDestroy:Number = 430;
		
		public function BigFireball(posX:int, posY:int, dirX:int)
		{
			Game.world.model.overLavaLayer.addChild(model);
			directionX = dirX;
			model.x = posX + (_fixPosX * directionX);
			model.y = posY + _fixPosY;
			model.scaleX = model.scaleY = currentScale = 0.8;
			model.scaleX = currentScale * -directionX;
			
			_distanceX = Game.character.model.x - model.x;
			_distanceY = Game.character.model.y - model.y - 60;
			_radians = Math.atan2(_distanceY, _distanceX);
			_dirX = Math.cos(_radians);
			_dirY = Math.sin(_radians);
			
			Game.allFireballs.push(this);
			
			Locator.updateManager.AddCallback(Update);
		}
		
		public function Update():void
		{
			if(!destroyed)
			{
				CheckCollisions();
				Move();
				Destroy();
			}
		}
		
		public function CheckCollisions():void
		{
			if(model.hitbox.hitTestObject(Game.character.model.hitbox))Game.character.TakeDamage(damage);
		}
		
		public function Move():void
		{
			model.x += _dirX * speed;
			model.y += _dirY * speed;
		}
		
		public function Destroy():void
		{
			_timeToDestroy --;
			
			if(_timeToDestroy <= 0)
			{
				model.parent.removeChild(model);
				model = null;
				destroyed = true;
				Locator.updateManager.RemoveCallback(Update);
			}
		}
		public function Restart():void
		{
			destroyed = true;
			
			Locator.updateManager.RemoveCallback(Update);
			
			Game.world.model.overLavaLayer.removeChild(model);
			model = null;
		}
	}
}