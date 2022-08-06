package
{
	import flash.display.MovieClip;
	import flash.media.Sound;
	
	import Engine.Locator;
	import Engine.SoundController;
	
	public class GoldenBullet
	{
		public var model:MovieClip = Locator.assetsManager.GetMovieClipsByName("MC_GoldenBullet");
		public var currentScale:Number;
		public var directionX:Number;
		public var damage:Number = 2;
		public var speed:Number = 8;
		
		private var _fixPosX:Number = 25;
		private var _fixPosY:Number = -10;
		private var _timeToDestroy:Number = 120;
		private var _destroyed:Boolean;
		
		public var volume:Number = 50;
		
		public var explosion:Sound = Locator.assetsManager.GetSoundByName("Explosion");
		public var soundExplosion:SoundController;
		
		public var enemyDamaged:Sound = Locator.assetsManager.GetSoundByName("EnemiDamage");
		public var soundEnemyDamaged:SoundController;
		
		public var bossDamaged:Sound = Locator.assetsManager.GetSoundByName("BossHurt");
		public var soundBossDamaged:SoundController;
		
		public function GoldenBullet()
		{
			Game.world.model.lightLayer.addChild(model);
			directionX = Game.character.directionX;
			model.x = Game.character.model.x + (_fixPosX * directionX);
			model.y = Game.character.model.y + _fixPosY;
			model.scaleX = model.scaleY = currentScale = 1;
			model.scaleX = currentScale * -directionX;
			
			soundExplosion = new SoundController(explosion);
			soundEnemyDamaged = new SoundController(enemyDamaged);
			soundBossDamaged = new SoundController(bossDamaged);
			
			Locator.updateManager.AddCallback(Update);
		}
		
		public function GodMode():void
		{
			damage = 20;
		}
		
		public function Update():void
		{
			if(!_destroyed)
			{
				CheckCollisions();
				Move();
				Destroy();
			}
		}
		
		public function CheckCollisions():void
		{
			for (var i:int = 0; i < Game.enemies.allBlackDragons.length; i++)
			{
				if(model.hitbox.hitTestObject(Game.enemies.allBlackDragons[i].model.hitbox))
				{
					if(!Game.enemies.allBlackDragons[i].dying)
					{
						Game.enemies.allBlackDragons[i].health -= damage;
						new BulletExplosion(model.x, model.y);
						model.parent.removeChild(model);
						soundExplosion.Play((Locator.soundVolume * volume) / 100,1);
						soundEnemyDamaged.Play((Locator.soundVolume * volume) / 100,1);
						_destroyed = true;
						Locator.updateManager.RemoveCallback(Update);
					}
				}
			}
			for (var j:int = 0; j < Game.enemies.allGreyDragons.length; j++)
			{
				if(model.hitbox.hitTestObject(Game.enemies.allGreyDragons[j].model.hitbox))
				{
					if(!Game.enemies.allGreyDragons[j].dying)
					{
						Game.enemies.allGreyDragons[j].health -= damage;
						new BulletExplosion(model.x, model.y);
						model.parent.removeChild(model);
						soundExplosion.Play((Locator.soundVolume * volume) / 100,1);
						soundEnemyDamaged.Play((Locator.soundVolume * volume) / 100,1);
						_destroyed = true;
						Locator.updateManager.RemoveCallback(Update);
					}
				}
			}
			for (var k:int = 0; k < Game.world.hitboxesLava.length; k++)
			{
				if(model.hitbox.hitTestObject(Game.world.hitboxesLava[k]))
				{
					new BulletExplosion(model.x, model.y);
					model.parent.removeChild(model);
					soundExplosion.Play((Locator.soundVolume * volume) / 100,1);
					_destroyed = true;
					Locator.updateManager.RemoveCallback(Update);
				}
			}
			if(Game.enemies.bigDragon != null)
			{
				if(Game.enemies.bigDragon.model != null)
				{
					if(model.hitbox.hitTestObject(Game.enemies.bigDragon.model.hitboxExplosion))
					{
						new BulletExplosion(model.x, model.y);
						model.parent.removeChild(model);
						_destroyed = true;
						Locator.updateManager.RemoveCallback(Update);
					}
				}
				/*if(Game.enemies.bigDragon.blackWallModel != null)
				{
					if(model.hitbox.hitTestObject(Game.enemies.bigDragon.blackWallModel.hitbox))
					{
						new BulletExplosion(model.x, model.y);
						model.parent.removeChild(model);
						_destroyed = true;
						Locator.updateManager.RemoveCallback(Update);
					}
				}*/
			}
			if(Game.enemies.boss != null && Game.enemies.boss.model != null)
			{
				if(model.hitbox.hitTestObject(Game.enemies.boss.model.hitboxHP))
				{
					Game.enemies.boss.health -= damage;
					new BulletExplosion(model.x, model.y);
					model.parent.removeChild(model);
					soundExplosion.Play((Locator.soundVolume * volume) / 100,1);
					soundBossDamaged.Play((Locator.soundVolume * volume) / 100,1);
					_destroyed = true;
					Locator.updateManager.RemoveCallback(Update);
				}
			}
		}
		
		public function Move():void
		{
			model.x += speed * directionX;
		}
		
		public function Destroy():void
		{
			_timeToDestroy --;
			
			if(_timeToDestroy <= 0)
			{
				model.parent.removeChild(model);
				_destroyed = true;
				Locator.updateManager.RemoveCallback(Update);
			}
		}
	}
}