package Items
{
	import Engine.Locator;
	
	import Items.AmmoKit;
	
	public class LocatedItems
	{
		public var upgradeSpawned:Boolean;
		public var allItems:Array = new Array();
		public function LocatedItems()
		{
			allItems = new Array();
			Locator.updateManager.AddCallback(Update);
		}
		public function SpawnItems():void
		{
			for (var i:int = 1; i <= 8; i++)
			{
				var randomItem:Number = Math.ceil((Math.random() * (115 - 0)));
				
				if(randomItem <= 28)
				{
					if(i == 1) new MedicKit(190, 118);
					if(i == 2) new MedicKit(1080, 394);
					if(i == 3) new MedicKit(1670, 400);
					if(i == 4) new MedicKit(2822, 46);
					if(i == 5) new MedicKit(3722, 126);
					if(i == 6) new MedicKit(4858, 406);
					if(i == 7) new MedicKit(5794, 406);
					if(i == 8) new MedicKit(6078, 406);
				}
				if(randomItem > 28 && randomItem <= 105)
				{
					if(i == 1) new AmmoKit(190, 118);
					if(i == 2) new AmmoKit(1080, 394);
					if(i == 3) new AmmoKit(1670, 400);
					if(i == 4) new AmmoKit(2822, 46);
					if(i == 5) new AmmoKit(3722, 126);
					if(i == 6) new AmmoKit(4858, 406);
					if(i == 7) new AmmoKit(5794, 406);
					if(i == 8) new AmmoKit(6078, 406);
				}
				if(randomItem == 114 && !upgradeSpawned)
				{
					if(i == 1) new AmmoKitGold(190, 118);
					if(i == 2) new AmmoKitGold(1080, 394);
					if(i == 3) new AmmoKitGold(1670, 400);
					if(i == 4) new AmmoKitGold(2822, 46);
					if(i == 5) new AmmoKitGold(3722, 126);
					if(i == 6) new AmmoKitGold(4858, 406);
					if(i == 7) new AmmoKitGold(5794, 406);
					if(i == 8) new AmmoKitGold(6078, 406);
					upgradeSpawned = true;
				}
				if(randomItem == 115 && !upgradeSpawned)
				{
					if(i == 1) new Battery(190, 118);
					if(i == 2) new Battery(1080, 394);
					if(i == 3) new Battery(1670, 400);
					if(i == 4) new Battery(2822, 46);
					if(i == 5) new Battery(3722, 126);
					if(i == 6) new Battery(4858, 406);
					if(i == 7) new Battery(5794, 406);
					if(i == 8) new Battery(6078, 406);
					upgradeSpawned = true;
				}
			}
		}
		public function Update():void
		{
			CheckDestroyedItems();
		}
		public function CheckDestroyedItems():void
		{
			for (var i:int = 0; i < allItems.length; i++) 
			{
				if(allItems[i].destroyed)
				{
					allItems.splice(i, 1);
				}
			}
		}
		public function Restart():void
		{
			Locator.updateManager.RemoveCallback(Update);
			for(var i:int = 0; i < allItems.length; i++)
			{
				allItems[i].Restart();
			}
			allItems.splice(0, allItems.length);
		}
	}
}