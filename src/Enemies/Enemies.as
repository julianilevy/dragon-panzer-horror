package Enemies
{
	import Engine.Locator;

	public class Enemies
	{
		public var allBlackDragons:Vector.<BlackDragon> = new Vector.<BlackDragon>();
		public var allGreyDragons:Vector.<GreyDragon> = new Vector.<GreyDragon>();
		public var blackDragon01:BlackDragon;
		public var blackDragon02:BlackDragon;
		public var blackDragon03:BlackDragon;
		public var blackDragon04:BlackDragon;
		public var blackDragon05:BlackDragon;
		public var greyDragon01:GreyDragon;
		public var greyDragon02:GreyDragon;
		public var greyDragon03:GreyDragon;
		public var greyDragon04:GreyDragon;
		public var greyDragon05:GreyDragon;
		public var greyDragon06:GreyDragon;
		public var greyDragon07:GreyDragon;
		public var greyDragon08:GreyDragon;
		public var bigDragon:BigDragon;
		public var bigDragonSpawned:Boolean;
		public var bigDragonDestroyed:Boolean;
		public var boss:Boss;
		public var bossSpawned:Boolean;
		
		public function Enemies()
		{
			allBlackDragons = new Vector.<BlackDragon>();
			allGreyDragons = new Vector.<GreyDragon>();
			blackDragon01 = new BlackDragon(670, 35, 0.9);
			allBlackDragons.push(blackDragon01);
			blackDragon02 = new BlackDragon(1920, 60, 0.7);
			allBlackDragons.push(blackDragon02);
			blackDragon03 = new BlackDragon(2835, 20, 0.9);
			allBlackDragons.push(blackDragon03);
			blackDragon04 = new BlackDragon(3865, -5, 0.9);
			allBlackDragons.push(blackDragon04);
			blackDragon05 = new BlackDragon(5125, 10, 0.9);
			allBlackDragons.push(blackDragon05);
			greyDragon01 = new GreyDragon(1270, 385, 0.7);
			allGreyDragons.push(greyDragon01);
			greyDragon02 = new GreyDragon(1875, 315, 0.7);
			allGreyDragons.push(greyDragon02);
			greyDragon03 = new GreyDragon(2280, 40, 0.9);
			allGreyDragons.push(greyDragon03);
			greyDragon04 = new GreyDragon(2925, 280, 0.7);
			allGreyDragons.push(greyDragon04);
			greyDragon05 = new GreyDragon(3370, 30, 0.8);
			allGreyDragons.push(greyDragon05);
			greyDragon06 = new GreyDragon(3930, 390, 0.8);
			allGreyDragons.push(greyDragon06);
			greyDragon07 = new GreyDragon(4770, 165, 0.8);
			allGreyDragons.push(greyDragon07);
			greyDragon08 = new GreyDragon(5585, 395, 0.7);
			allGreyDragons.push(greyDragon08);
			
			Locator.updateManager.AddCallback(Update);
		}
		
		public function Update():void
		{
			CheckDragons();
			BigDragonSpawn();
			BigDragonDestroy();
			BossSpawn();
			CheckDestroyedFireBalls();
		}
		
		public function CheckDestroyedFireBalls():void
		{
			for (var i:int = 0; i < Game.allFireballs.length; i++) 
			{
				if(Game.allFireballs[i].destroyed)
				{
					Game.allFireballs.splice(i, 1);
				}
			}
		}
		
		public function CheckDragons():void
		{
			for (var i:int = 0; i < allBlackDragons.length; i++)
			{
				if(allBlackDragons[i].dead)
				{
					allBlackDragons[i].model.parent.removeChild(allBlackDragons[i].model);
					allBlackDragons[i].model = null;
					allBlackDragons.splice(i, 1);
				}
			}
			for (var j:int = 0; j < allGreyDragons.length; j++)
			{
				if(allGreyDragons[j].dead)
				{
					allGreyDragons[j].model.parent.removeChild(allGreyDragons[j].model);
					allGreyDragons[j].model = null;
					allGreyDragons.splice(j, 1);
				}
			}
		}
		
		public function BigDragonSpawn():void
		{
			if(Game.character != null)
			{
				if(!bigDragonSpawned && Game.character.model.hitbox.hitTestObject(Game.world.model.bigDragonSpawn))
				{
					Game.instance.RemoveMusic();
					Game.instance.PlayBigDragonMusic();
					bigDragon = new BigDragon(Game.character.model.x - 400, Game.character.model.y + 115);
					bigDragonSpawned = true;
				}
			}
		}
		
		public function BigDragonDestroy():void
		{
			if(bigDragon != null)
			{
				if(!bigDragonDestroyed && Game.character.model.hitbox.hitTestObject(Game.world.model.bigDragonDestroy))
				{
					Game.instance.RemoveMusic();
					Game.instance.PlayMusic();
					bigDragonDestroyed = true;
				}
			}
		}
		
		public function BossSpawn():void
		{
			if(Game.character != null)
			{
				if(!bossSpawned && Game.character.model.hitbox.hitTestObject(Game.world.model.bossSpawn))
				{
					Game.instance.RemoveMusic();
					Game.character.locked = true;
					boss = new Boss(5905, 490);
					bossSpawned = true;
					//dejas de moverte
				}
			}
		}
		
		public function DestroyEnemies():void
		{
			for (var i:int = 0; i < allBlackDragons.length; i++)
			{
				if(!allBlackDragons[i].dying) allBlackDragons[i].health -= 2;
			}
			for (var j:int = 0; j < allGreyDragons.length; j++)
			{
				if(!allGreyDragons[j].dying) allGreyDragons[j].health -= 1;
			}
		}
		
		public function Restart():void
		{
			Locator.updateManager.RemoveCallback(Update);
			
			var i:int;
			
			for(i = 0; i < allBlackDragons.length; i++)
			{
				allBlackDragons[i].Restart();
			}
			allBlackDragons.splice(0, allBlackDragons.length);
			
			for(i = 0; i < allGreyDragons.length; i++)
			{
				allGreyDragons[i].Restart();
			}
			allGreyDragons.splice(0, allGreyDragons.length);
			
			for(i = 0; i < Game.allFireballs.length; i++)
			{
				Game.allFireballs[i].Restart();
			}
			Game.allFireballs.splice(0, Game.allFireballs.length);
			
			if(bigDragon != null)
			{
				bigDragon.Restart();
				bigDragon = null;
			}
			
			if(boss != null)
			{
				boss.Restart()
				boss = null;
			}
		}
	}
}