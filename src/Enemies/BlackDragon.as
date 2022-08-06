package Enemies
{
	import flash.display.MovieClip;
	import flash.media.Sound;
	
	import Engine.Locator;
	import Engine.SoundController;
	
	import Items.AmmoKit;
	import Items.AmmoKitGold;
	import Items.Battery;
	import Items.MedicKit;

	public class BlackDragon
	{
		public var model:MovieClip = Locator.assetsManager.GetMovieClipsByName("MC_BlackDragon");
		public var currentScale:Number;
		public var timeToDisappear:Number = 240;
		public var shootCD:Number = 50;
		public var fallSpeed:Number = 7;
		public var directionX:int = 1;
		public var health:int = 2;
		public var damage:int = 1;
		public var grounded:Boolean;
		public var itemSpawned:Boolean;
		public var dying:Boolean;
		public var dead:Boolean;
		
		public var volume:Number = 50;
		
		public var fireBall:Sound = Locator.assetsManager.GetSoundByName("FireBall");
		public var soundFireBall:SoundController;
		
		public function BlackDragon(PosX:Number, PosY:Number, cScale:Number)
		{
			Game.world.model.darkLayer.addChild(model);
			model.x = PosX;
			model.y = PosY;
			model.scaleX = model.scaleY = currentScale = cScale;
			
			soundFireBall = new SoundController(fireBall);
			
			Locator.updateManager.AddCallback(Update);
		}
		
		public function Update():void
		{
			if(!dead)
			{
				CheckCollisions();
				Detection();
				Shoot();
				Die();
			}
		}
		
		public function CheckCollisions():void
		{
			if(!dying)
			{
				if(model.hitbox.hitTestObject(Game.character.model.hitbox))Game.character.TakeDamage(damage);
			}
		}
		
		public function Detection():void
		{
			if(!dying)
			{
				if(model.hitboxDetection.hitTestObject(Game.character.model.hitbox))
				{
					if(model.x >= Game.character.model.x)
					{
						model.scaleX = currentScale * -1;
						directionX = -1;
					}
					else
					{
						model.scaleX = currentScale;
						directionX = 1;
					}
				}
			}
		}
		
		public function Shoot():void
		{
			if(!dying)
			{
				shootCD -= 1;
				
				if(shootCD <= 0)
				{
					if(model.hitboxDetectionSmall.hitTestObject(Game.character.model.hitbox))
					{
						var fireball:Fireball = new Fireball(model.x, model.y, directionX);
						soundFireBall.Play((Locator.soundVolume * volume) / 100,1);
						shootCD = 50;
					}
				}
			}
		}
		
		public function Die():void
		{
			if(health <= 0 && !dying)
			{
				ChangeAnimation("Death");
				Main.scoreManager.AddScore(Main.scoreManager.dragonKill);
				Main.achievementController.KilledDragon();
				SpawnItem();
				dying = true;
			}
			if(dying)
			{
				timeToDisappear --;
				Fall();
			}
			if(timeToDisappear <= 0)
			{
				dead = true;
				Locator.updateManager.RemoveCallback(Update);
			}
		}
		
		public function Fall():void
		{
			if(!grounded)
			{
				model.y += Game.world.gravity * fallSpeed;
				
				for (var i:int = 0; i < Game.world.hitboxesGround.length; i++)
				{
					if(model.hitboxGround.hitTestObject(Game.world.hitboxesGround[i]))
					{
						grounded = true;
						return;
					}
				}
			}
		}
		
		public function SpawnItem():void
		{
			if(!itemSpawned)
			{
				var decideSpawn:Number = Math.ceil((Math.random() * (100 - 0)));
				
				if(decideSpawn >= 75)
				{
					var randomItem:Number = Math.ceil((Math.random() * (107 - 0)));
					
					if(randomItem <= 28) new MedicKit(model.x, model.y);
					if(randomItem > 28 && randomItem <= 105) new AmmoKit(model.x, model.y);
					if(randomItem == 106 && !Game.character.goldenWeapon) new AmmoKitGold(model.x, model.y);
					if(randomItem == 107 && !Game.character.upgradedLight) new Battery(model.x, model.y);
					
					itemSpawned = true;
				}
			}
		}
		
		public function ChangeAnimation(animationName:String):void
		{
			if (model.currentLabel != animationName) model.gotoAndPlay(animationName);
		}
		public function Restart():void
		{
			dead = true;
			
			Locator.updateManager.RemoveCallback(Update);
			
			Game.world.model.darkLayer.removeChild(model);
		}
	}
}