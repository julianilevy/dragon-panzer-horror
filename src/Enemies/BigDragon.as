package Enemies
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.media.Sound;
	
	import Engine.Locator;
	import Engine.SoundController;

	public class BigDragon
	{
		public var model:MovieClip = Locator.assetsManager.GetMovieClipsByName("MC_BigDragon");
		public var eyeModel:MovieClip = Locator.assetsManager.GetMovieClipsByName("MC_BigDragonEye");
		public var blackWallModel:MovieClip = Locator.assetsManager.GetMovieClipsByName("MC_BigDragonBlackWall");
		public var currentScale:Number;
		public var shootCD:Number = 240;
		public var firstMoveTimer:Number = 0;
		public var lastMoveTimer:Number = 0;
		public var speed:Number = 1.8;
		public var directionX:int = -1;
		public var damage:int = 10;
		public var quitSound:Boolean;
		public var dead:Boolean;
		
		public var volume:Number = 80;
		
		public var fireBall:Sound = Locator.assetsManager.GetSoundByName("FireBallWave");
		public var soundFireBall:SoundController;
		
		public var bigDragonEnter:Sound = Locator.assetsManager.GetSoundByName("BigDragonEnter");
		public var soundbigDragonEnter:SoundController;
		
		public var bigDragonBreathing:Sound = Locator.assetsManager.GetSoundByName("BigDragonBreathing");
		public var soundbigDragonBreathing:SoundController;
		
		public var bigDragonQuit:Sound = Locator.assetsManager.GetSoundByName("BigDragonQuit");
		public var soundBigDragonQuit:SoundController;
		
		public function BigDragon(PosX:Number, PosY:Number)
		{
			Game.world.model.darkLayer.addChild(model);
			Game.world.model.bigDragonEyeLayer.addChild(eyeModel);
			Game.world.model.bigDragonLayer.addChild(blackWallModel);
			model.x = PosX;
			eyeModel.x = PosX;
			blackWallModel.x = PosX - 913;
			model.y = PosY;
			eyeModel.y = PosY;
			blackWallModel.y = PosY;
			model.scaleX = model.scaleY = currentScale = 0.9;
			eyeModel.scaleX = eyeModel.scaleY = currentScale = 0.9;
			blackWallModel.scaleX = eyeModel.scaleY = currentScale = 0.9;
			
			model.addEventListener("CreateBigFireball", CreateBigFireball);
			
			soundFireBall = new SoundController(fireBall);
			soundbigDragonEnter = new SoundController(bigDragonEnter);
			soundbigDragonBreathing = new SoundController(bigDragonBreathing);
			soundBigDragonQuit = new SoundController(bigDragonQuit);
			
			soundbigDragonEnter.Play((Locator.soundVolume * (volume - 20)) / 100,1);
			soundbigDragonBreathing.Play((Locator.soundVolume * (volume + 20)) / 100,100);
			
			Locator.updateManager.AddCallback(Update);
		}
		
		public function Update():void
		{
			if(!dead)
			{
				CheckCollisions();
				Shoot();
				Movement();
				Position();
				Destroy();
			}
		}
		
		public function CheckCollisions():void
		{
			if(model.hitbox.hitTestObject(Game.character.model.hitbox))Game.character.TakeDamage(damage);
			if(blackWallModel.hitbox.hitTestObject(Game.character.model.hitbox))Game.character.TakeDamage(damage);
		}
		
		public function Shoot():void
		{
			if(!Game.enemies.bigDragonDestroyed)
			{
				shootCD -= 1;
				
				if(shootCD <= 0)
				{
					ChangeAnimation(model, "Attack");
					ChangeAnimation(eyeModel, "Attack");
				}
			}
		}
		
		public function CreateBigFireball(event:Event):void
		{
			var bigFireball:BigFireball = new BigFireball(model.x, model.y, directionX);
			soundFireBall.Play((Locator.soundVolume * volume) / 100,1);
			shootCD = 240;
		}
		
		public function Movement():void
		{
			if(!Game.enemies.bigDragonDestroyed)
			{
				if(Game.character.model.x >= model.x - 400)
				{
					firstMoveTimer += 1;
					
					if(firstMoveTimer <= 60)
					{
						model.x += speed * 2.5;
						eyeModel.x += speed * 2.5;
						blackWallModel.x += speed * 2.5;
					}
					else
					{
						model.x += speed;
						eyeModel.x += speed;
						blackWallModel.x += speed;
					}
				}
			}
		}
		
		public function Position():void
		{
			if(!Game.enemies.bigDragonDestroyed)
			{
				model.y = Game.character.model.y + 240;
				eyeModel.y = Game.character.model.y + 240;
				blackWallModel.y = Game.character.model.y + 240;
			}
		}
		
		public function Destroy():void
		{
			if(Game.enemies.bigDragonDestroyed)
			{
				lastMoveTimer += 1;
				
				if(!quitSound)
				{
					soundBigDragonQuit.Play((Locator.soundVolume * (volume - 10)) / 100,1);
					soundbigDragonBreathing.Stop();
					quitSound = true;
				}
				
				if(lastMoveTimer < 300)
				{
					model.x -= speed * 1.8;
					eyeModel.x -= speed * 1.8;
					blackWallModel.x -= speed * 1.8;
				}
				if(lastMoveTimer >= 300)
				{
					model.removeEventListener("CreateBigFireball", CreateBigFireball);
					model.parent.removeChild(model);
					eyeModel.parent.removeChild(eyeModel);
					blackWallModel.parent.removeChild(blackWallModel);
					model = null;
					eyeModel = null;
					blackWallModel = null;
					dead = true;
					Locator.updateManager.RemoveCallback(Update);
				}
			}
		}
		
		public function ChangeAnimation(mcModel:MovieClip, animationName:String):void
		{
			if (mcModel.currentLabel != animationName) mcModel.gotoAndPlay(animationName);
		}
		public function Restart():void
		{
			dead = true;
			Locator.updateManager.RemoveCallback(Update);
			
			if(model != null)
			{
				model.removeEventListener("CreateBigFireball", CreateBigFireball);
				Game.world.model.darkLayer.removeChild(model);
				Game.world.model.bigDragonEyeLayer.removeChild(eyeModel);
				Game.world.model.bigDragonLayer.removeChild(blackWallModel);
			}
		}
	}
}