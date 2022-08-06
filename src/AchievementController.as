package
{
	import Engine.Locator;

	public class AchievementController
	{
		public var Wins:int = 0;
		public var firstWin:int = 0;
		public var winsFor10:int = 0;
		public var winsFor50:int = 0;
		public var winsFor100:int = 0;
		public var winForTheFirstTime:int = 1;
		public var win10Times:int = 10;
		public var win50Times:int = 50;
		public var win100Times:int = 100;
		
		public var dragonsKilled:int = 0;
		public var killsFor10:int = 0;
		public var killsFor100:int = 0;
		public var killsFor500:int = 0;
		public var killsFor1000:int = 0;
		public var kill10Dragons:int = 10;
		public var kill100Dragons:int = 100;
		public var kill500Dragons:int = 500;
		public var kill1000Dragons:int = 1000;
		
		public var winWithOutLosingLife:Boolean = false;
		public var lostLifeOnTheGame:Boolean = false;
		
		public var WinInLessThan3m:Boolean = false;
		public var didntWonOn3m:int = 180000;
		public var clockTime:Number = 0;
		
		public var winWithOutHealingWith1OfLife:Boolean = false;
		public var healed:Boolean = false;
		
		public var medicKitUsed:int;
		public var winForMedicKit:int = 0;
		public var winForMedicKit10:int = 0;
		public var winWithMedicKit:int = 1;
		public var winWith10MedicKit:int = 10;
		
		public var winsWithBattery:int = 0;
		public var win3timesWithBattery:int = 3;
		
		public var winsWithGoldenAmo:int = 0;
		public var win3TimesWithGoldenAmo:int = 3;
		
		public var winWithBothBuffs:Boolean = false;
		
		public var winWithMaxAmoAndMaxLife:Boolean = false;
		
		public var usedLessThan20Bullets:Boolean = false;
		public var amoUsed:int = 0;
		public var maxAmoToUse:int = 20;
		
		public var killedAllTheDragonsInTheLevel:Boolean = false;
		public var dragonsKilledThisLevel:int = 0;
		public var maxDragonsPerLEvel:int = 13;
		
		public var loseAllYourLifeInLava:Boolean = false;
		public var hitedByLava:int = 0;
		
		public var getAllTheAchievements:Boolean = false;
		
		public var wroteVedoyaOnTheCOnsole:Boolean = false;
		
		public var openedTheConsole:Boolean = false;
		
		public var buggedTheGame:Boolean = false;
		
		
		public function AchievementController()
		{
			if(Locator.saveManager.achievementsFile.exists)
			{
				var loadAchievements:Object = Locator.saveManager.LoadObject(Locator.saveManager.achievementsFile, Locator.saveManager.achievementsSaver);
				for(var achievVarName:String in loadAchievements)
				{
					this[achievVarName] = loadAchievements[achievVarName];
				}
			}else
			{
				Save();
			}
		}
		public function StartClock():void
		{
			Locator.updateManager.AddCallback(Update);
		}
		public function StopClock():void
		{
			Locator.updateManager.RemoveCallback(Update);
		}
		public function Update():void
		{
			clockTime += 1000/Locator.mainStage.frameRate;
		}
		public function WinTheGame():void
		{
			Wins ++;
			if(dragonsKilledThisLevel >= maxDragonsPerLEvel)
			{
				killedAllTheDragonsInTheLevel = true;
			}
			if(Wins <= winForTheFirstTime)
			{
				firstWin ++;
			}
			if(Wins <= win10Times)
			{
				winsFor10 ++;
			}
			if(Wins <= win50Times)
			{
				winsFor50 ++;
			}
			if(Wins <= win100Times)
			{
				winsFor100 ++;
			}
			if(!lostLifeOnTheGame)
			{
				winWithOutLosingLife = true;
			}
			if(clockTime <= 180000)
			{
				WinInLessThan3m = true;
			}
			if(!healed && Game.character.health == 1)
			{
				winWithOutHealingWith1OfLife = true;
			}
			if(Game.character.upgradedLight && Game.character.goldenWeapon)
			{
				winWithBothBuffs = true;
			}
			if(Game.character.upgradedLight)
			{
				winsWithBattery++;
			}
			if(Game.character.goldenWeapon)
			{
				winsWithGoldenAmo++;
			}
			if(Game.character.health == 5 && Game.character.ammo == 99)
			{
				winWithMaxAmoAndMaxLife = true;
			}
			if(amoUsed <= maxAmoToUse)
			{
				usedLessThan20Bullets = true;
			}
			Reset();
			Save();
		}
		public function LostTheGame():void
		{
			if(hitedByLava >= 5 && !healed)
			{
				loseAllYourLifeInLava = true;
			}
			Reset();
			Save();
		}
		public function KilledDragon():void
		{
			dragonsKilled ++;
			dragonsKilledThisLevel++;
			if(dragonsKilled <= kill10Dragons)
			{
				killsFor10 ++;
			}
			if(dragonsKilled <= kill100Dragons)
			{
				killsFor100 ++ ;
			}
			if(dragonsKilled <= kill500Dragons)
			{
				killsFor500 ++;
			}
			if(dragonsKilled <= kill1000Dragons)
			{
				killsFor1000 ++ ;
			}
		}
		public function Damaged():void
		{
			lostLifeOnTheGame = true;
		}
		public function Healed():void
		{
			healed = true;
		}
		public function MedicKitNotUsed():void
		{
			medicKitUsed ++;
			if(medicKitUsed <= winWithMedicKit)
			{
				winForMedicKit ++;
			}
			if(medicKitUsed <= winWith10MedicKit)
			{
				winForMedicKit10 ++;
			}
		}
		public function AmoUsed():void
		{
			amoUsed++;
		}
		public function HitedByLava():void
		{
			hitedByLava++;
		}
		public function GetAllAchievements():void
		{
			if(Wins >= win100Times && 
				dragonsKilled >= kill1000Dragons)
			{
				getAllTheAchievements = true;
			}
		}
		public function VEDOYASAMA():void
		{
			wroteVedoyaOnTheCOnsole = true;
		}
		public function OpenTheConsole():void
		{
			openedTheConsole = true;
		}
		public function YouBuggedTheGame():void
		{
			buggedTheGame = true;
		}
		public function Reset():void
		{
			dragonsKilledThisLevel = 0;
			amoUsed = 0;
			hitedByLava = 0;
			clockTime = 0;
			lostLifeOnTheGame = false;
			healed = false;
		}
		public function Save():void
		{
			trace("HOLA");
			var achievementsToSave:Object = new Object;
			
			achievementsToSave.Wins = Wins;
			achievementsToSave.firstWin = firstWin;
			achievementsToSave.winsFor10 = winsFor10;
			achievementsToSave.winsFor50 = winsFor50;
			achievementsToSave.winsFor100 = winsFor100;
			achievementsToSave.winForTheFirstTime = winForTheFirstTime;
			achievementsToSave.win10Times = win10Times;
			achievementsToSave.win50Times = win50Times;
			achievementsToSave.win100Times = win100Times;
			
			achievementsToSave.dragonsKilled = dragonsKilled;
			achievementsToSave.killsFor10 = killsFor10;
			achievementsToSave.killsFor100 = killsFor100;
			achievementsToSave.killsFor500 = killsFor500;
			achievementsToSave.killsFor1000 = killsFor1000;
			achievementsToSave.kill10Dragons = kill10Dragons;
			achievementsToSave.kill100Dragons = kill100Dragons;
			achievementsToSave.kill500Dragons = kill500Dragons;
			achievementsToSave.kill1000Dragons = kill1000Dragons;
			
			achievementsToSave.winWithOutLosingLife = winWithOutLosingLife;
			achievementsToSave.lostLifeOnTheGame = lostLifeOnTheGame;
			
			achievementsToSave.WinInLessThan3m = WinInLessThan3m;
			achievementsToSave.didntWonOn3m = didntWonOn3m;
			achievementsToSave.clockTime = clockTime;
			
			achievementsToSave.winWithOutHealingWith1OfLife = winWithOutHealingWith1OfLife;
			achievementsToSave.healed = healed;
			
			achievementsToSave.medicKitUsed = medicKitUsed;
			achievementsToSave.winForMedicKit = winForMedicKit;
			achievementsToSave.winForMedicKit10 = winForMedicKit10;
			achievementsToSave.winWithMedicKit = winWithMedicKit;
			achievementsToSave.winWith10MedicKit = winWith10MedicKit;
			
			achievementsToSave.winsWithBattery = winsWithBattery;
			achievementsToSave.win3timesWithBattery = win3timesWithBattery;
			
			achievementsToSave.winsWithGoldenAmo = winsWithGoldenAmo;
			achievementsToSave.win3TimesWithGoldenAmo = win3TimesWithGoldenAmo;
			
			achievementsToSave.winWithBothBuffs = winWithBothBuffs;
			
			achievementsToSave.winWithMaxAmoAndMaxLife = winWithMaxAmoAndMaxLife;
			
			achievementsToSave.usedLessThan20Bullets = usedLessThan20Bullets;
			achievementsToSave.amoUsed = amoUsed;
			achievementsToSave.maxAmoToUse = maxAmoToUse;
			
			achievementsToSave.killedAllTheDragonsInTheLevel = killedAllTheDragonsInTheLevel;
			achievementsToSave.dragonsKilledThisLevel = dragonsKilledThisLevel;
			achievementsToSave.maxDragonsPerLEvel = maxDragonsPerLEvel;
			
			achievementsToSave.loseAllYourLifeInLava = loseAllYourLifeInLava;
			achievementsToSave.hitedByLava = hitedByLava;
			
			achievementsToSave.getAllTheAchievements = getAllTheAchievements;
			
			achievementsToSave.wroteVedoyaOnTheCOnsole = wroteVedoyaOnTheCOnsole;
			
			achievementsToSave.openedTheConsole = openedTheConsole;
			
			achievementsToSave.buggedTheGame = buggedTheGame;
			
			Locator.saveManager.SaveObject(achievementsToSave, Locator.saveManager.achievementsFile, Locator.saveManager.achievementsSaver);
		}
	}
}