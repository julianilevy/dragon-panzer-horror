package Items
{
	import flash.display.MovieClip;
	import flash.media.Sound;
	
	import Engine.Locator;
	import Engine.SoundController;
	
	public class AmmoKitGold
	{
		public var model:MovieClip = Locator.assetsManager.GetMovieClipsByName("MC_AmmoKitGold");
		public var currentScale:Number;
		public var fallSpeed:Number = 7;
		public var ammoQty:int = 6;
		public var grounded:Boolean;
		public var destroyed:Boolean;
		
		public var volume:Number = 70;
		
		public var itemSoundEffect:Sound = Locator.assetsManager.GetSoundByName("GetSuperItem");
		public var soundItem:SoundController;
		
		public function AmmoKitGold(PosX:Number, PosY:Number)
		{
			Game.world.model.underCharLayer.addChild(model);
			model.x = PosX;
			model.y = PosY;
			model.scaleX = model.scaleY = currentScale = 1;
			
			soundItem = new SoundController(itemSoundEffect);
			
			Game.locatedItems.allItems.push(this);
			
			Locator.updateManager.AddCallback(Update);
		}
		
		public function Update():void
		{
			if(!destroyed)
			{
				CheckCollisions();
				Fall();
			}
		}
		
		public function CheckCollisions():void
		{
			if(model.hitbox.hitTestObject(Game.character.model.hitbox))
			{
				soundItem.Play((Locator.soundVolume * volume) / 100,1);
				Game.character.ammo += ammoQty;
				Game.character.goldenWeapon = true;
				Main.scoreManager.AddScore(Main.scoreManager.pickUpgrade);
				model.parent.removeChild(model);
				destroyed = true;
				Locator.updateManager.RemoveCallback(Update);
			}
		}
		
		public function Fall():void
		{
			if(!grounded)
			{
				for (var i:int = 0; i < Game.world.hitboxesGround.length; i++)
				{
					if(model.hitboxGround.hitTestObject(Game.world.hitboxesGround[i]))
					{
						grounded = true;
						return;
					}
				}
				
				model.y += Game.world.gravity * fallSpeed;
			}
		}
		public function Restart():void
		{
			model.parent.removeChild(model);
			destroyed = true;
			Locator.updateManager.RemoveCallback(Update);
		}
	}
}