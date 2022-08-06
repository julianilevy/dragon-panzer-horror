package Items
{
	import flash.display.MovieClip;
	import flash.media.Sound;
	
	import Engine.Locator;
	import Engine.SoundController;
	
	public class MedicKit
	{
		public var model:MovieClip = Locator.assetsManager.GetMovieClipsByName("MC_MedicKit");
		public var currentScale:Number;
		public var fallSpeed:Number = 7;
		public var grounded:Boolean;
		public var destroyed:Boolean;
		
		public var volume:Number = 70;
		
		public var itemSoundEffect:Sound = Locator.assetsManager.GetSoundByName("GetItem");
		public var soundItem:SoundController;
		
		public var healMK:Sound = Locator.assetsManager.GetSoundByName("HealMedicKit");
		public var soundHealMK:SoundController;
		
		public function MedicKit(PosX:Number, PosY:Number)
		{
			Game.world.model.underCharLayer.addChild(model);
			model.x = PosX;
			model.y = PosY + 6;
			model.scaleX = model.scaleY = currentScale = 1;
			
			soundItem = new SoundController(itemSoundEffect);
			soundHealMK = new SoundController(healMK);
			
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
				if(Game.character.health < 5)
				{
					soundHealMK.Play((Locator.soundVolume * volume) / 100,1);
					Game.character.health ++;
					model.parent.removeChild(model);
					Main.scoreManager.RemoveScore(Main.scoreManager.heal);
					destroyed = true;
					Locator.updateManager.RemoveCallback(Update);
					return;
				}
				if(Game.character.health >= 5 && !Game.character.extraMedicKit)
				{
					soundItem.Play((Locator.soundVolume * volume) / 100,1);
					Game.character.extraMedicKit = true;
					model.parent.removeChild(model);
					destroyed = true;
					Locator.updateManager.RemoveCallback(Update);
					return;
				}
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