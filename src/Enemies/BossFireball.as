package Enemies
{
	import flash.display.MovieClip;
	
	import Engine.Locator;
	
	public class BossFireball
	{
		public var model:MovieClip = Locator.assetsManager.GetMovieClipsByName("MC_Fireball");
		public var currentScale:Number;
		public var directionX:Number = -1;
		public var directionY:Number;
		public var damage:Number = 1;
		public var speed:Number = 4;
		public var destroyed:Boolean;
		
		private var _radians:Number;
		private var _distanceX:Number;
		private var _distanceY:Number;
		private var _dirX:Number;
		private var _dirY:Number;
		private var _fixPosX:Number = 35;
		private var _fixPosY:Number = -60;
		private var _timeToDestroy:Number = 300;
		
		public function BossFireball(posX:int, posY:int, distanceX:int, distanceY:int, dirY:int)
		{
			Game.world.model.overLavaLayer.addChild(model);
			directionY = dirY;
			model.x = posX + (_fixPosX * directionX);
			model.y = posY + (_fixPosY * directionY);
			model.scaleX = model.scaleY = currentScale = 3;
			model.scaleX = currentScale * -directionX;
			
			_distanceX = distanceX - model.x;
			_distanceY = distanceY - model.y;
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