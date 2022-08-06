package Enemies
{
	import flash.display.MovieClip;
	
	import Engine.Locator;
	
	import Items.AmmoKit;
	import Items.AmmoKitGold;
	import Items.Battery;
	import Items.MedicKit;
	
	public class GreyDragon
	{
		public var model:MovieClip = Locator.assetsManager.GetMovieClipsByName("MC_GreyDragon");
		public var currentScale:Number;
		public var timeToDisappear:Number = 240;
		public var firstMove:Number = 0;
		public var speed:Number = 2.5;
		public var directionX:int = -1;
		public var health:int = 1;
		public var damage:int = 1;
		public var itemSpawned:Boolean;
		public var dying:Boolean;
		public var dead:Boolean;
		
		public function GreyDragon(PosX:Number, PosY:Number, cScale:Number)
		{
			Game.world.model.darkLayer.addChild(model);
			model.x = PosX;
			model.y = PosY;
			model.scaleX = model.scaleY = currentScale = cScale;
			model.scaleX = currentScale * -1;
			
			Locator.updateManager.AddCallback(Update);
		}
		
		public function Update():void
		{
			if(!dead)
			{
				CheckCollisions();
				Movement();
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
		
		public function Movement():void
		{
			if(!dying)
			{
				firstMove += 1;
				model.x += speed * directionX;
				
				if(firstMove >= 30)
				{
					for(var i:int = 0; i < Game.world.hitboxesDragonDir.length; i++)
					{
						if(model.hitbox.hitTestObject(Game.world.hitboxesDragonDir[i]))
						{
							directionX *= -1;
							model.scaleX *= -1;
						}
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
			if(dying) timeToDisappear --;
			if(timeToDisappear <= 0)
			{
				dead = true;
				Locator.updateManager.RemoveCallback(Update);
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