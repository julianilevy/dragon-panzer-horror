package
{
	import flash.events.MouseEvent;
	
	import Engine.CustomScreen;

	public class ScreenAchievements extends CustomScreen
	{
		public var completed:String = "Completed";
		public var achievementsYouGot:int = 0;
		public var totalAchievements:int = 20;
		public function ScreenAchievements()
		{
		}
		override public function Enter():void
		{
			ShowScreen("MC_AchievementsScreen");
			
			model.AchievBox.AchievBoxMove.y = 0;
			model.AchievBox.AchievBoxMove.addEventListener(MouseEvent.MOUSE_WHEEL, evBox);
			
			AchievementManager();
			
			model.UP.addEventListener(MouseEvent.CLICK, evUP);
			model.UP.addEventListener(MouseEvent.MOUSE_OVER, evOverUP);
			model.UP.addEventListener(MouseEvent.MOUSE_OUT, evOutUP);
			
			model.Dawn.addEventListener(MouseEvent.CLICK, evDawn);
			model.Dawn.addEventListener(MouseEvent.MOUSE_OVER, evOverDawn);
			model.Dawn.addEventListener(MouseEvent.MOUSE_OUT, evOutDawn);
			
			model.Back.addEventListener(MouseEvent.CLICK, evBack);
			model.Back.addEventListener(MouseEvent.MOUSE_OVER, evOverBack);
			model.Back.addEventListener(MouseEvent.MOUSE_OUT, evOutBack);
		}
		public function AchievementManager():void
		{
			if(Main.achievementController.firstWin < Main.achievementController.winForTheFirstTime)
			{
				model.AchievBox.AchievBoxMove.AchievWinForFirstTime.ProgresBar.tb_Progress.text = Main.achievementController.firstWin.toString();
				model.AchievBox.AchievBoxMove.AchievWinForFirstTime.ProgresBar.tb_Goal.text = Main.achievementController.winForTheFirstTime.toString();
				model.AchievBox.AchievBoxMove.AchievWinForFirstTime.ProgresBar.gotoAndStop(int((Main.achievementController.firstWin * 100) / Main.achievementController.winForTheFirstTime));
			}
			else
			{
				achievementsYouGot ++;
				model.AchievBox.AchievBoxMove.AchievWinForFirstTime.gotoAndStop("ON");
				model.AchievBox.AchievBoxMove.AchievWinForFirstTime.ProgresBar.tb_Progress.text = "";
				model.AchievBox.AchievBoxMove.AchievWinForFirstTime.ProgresBar.tb_Goal.text = "";
				model.AchievBox.AchievBoxMove.AchievWinForFirstTime.ProgresBar.tb_Dash.text = completed;
				model.AchievBox.AchievBoxMove.AchievWinForFirstTime.ProgresBar.gotoAndStop(100);
			}
			
			if(Main.achievementController.winsFor10 < Main.achievementController.win10Times)
			{
				model.AchievBox.AchievBoxMove.AchievWin10Times.ProgresBar.tb_Progress.text = Main.achievementController.winsFor10.toString();
				model.AchievBox.AchievBoxMove.AchievWin10Times.ProgresBar.tb_Goal.text = Main.achievementController.win10Times.toString();
				model.AchievBox.AchievBoxMove.AchievWin10Times.ProgresBar.gotoAndStop(int((Main.achievementController.winsFor10 * 100) / Main.achievementController.win10Times));
			}
			else
			{
				achievementsYouGot ++;
				model.AchievBox.AchievBoxMove.AchievWin10Times.gotoAndStop("ON");
				model.AchievBox.AchievBoxMove.AchievWin10Times.ProgresBar.tb_Progress.text = "";
				model.AchievBox.AchievBoxMove.AchievWin10Times.ProgresBar.tb_Goal.text = "";
				model.AchievBox.AchievBoxMove.AchievWin10Times.ProgresBar.tb_Dash.text = completed;
				model.AchievBox.AchievBoxMove.AchievWin10Times.ProgresBar.gotoAndStop(100);
			}
			
			if(Main.achievementController.winsFor50 < Main.achievementController.win50Times)
			{
				model.AchievBox.AchievBoxMove.AchievWin50Times.ProgresBar.tb_Progress.text = Main.achievementController.winsFor50.toString();
				model.AchievBox.AchievBoxMove.AchievWin50Times.ProgresBar.tb_Goal.text = Main.achievementController.win50Times.toString();
				model.AchievBox.AchievBoxMove.AchievWin50Times.ProgresBar.gotoAndStop(int((Main.achievementController.winsFor50 * 100) / Main.achievementController.win50Times));
			}
			else
			{
				achievementsYouGot ++;
				model.AchievBox.AchievBoxMove.AchievWin50Times.gotoAndStop("ON");
				model.AchievBox.AchievBoxMove.AchievWin50Times.ProgresBar.tb_Progress.text = "";
				model.AchievBox.AchievBoxMove.AchievWin50Times.ProgresBar.tb_Goal.text = "";
				model.AchievBox.AchievBoxMove.AchievWin50Times.ProgresBar.tb_Dash.text = completed;
				model.AchievBox.AchievBoxMove.AchievWin50Times.ProgresBar.gotoAndStop(100);
			}
			
			if(Main.achievementController.winsFor100 < Main.achievementController.win100Times)
			{
				model.AchievBox.AchievBoxMove.AchievWin100Times.ProgresBar.tb_Progress.text = Main.achievementController.winsFor100.toString();
				model.AchievBox.AchievBoxMove.AchievWin100Times.ProgresBar.tb_Goal.text = Main.achievementController.win100Times.toString();
				model.AchievBox.AchievBoxMove.AchievWin100Times.ProgresBar.gotoAndStop(int((Main.achievementController.winsFor100 * 100) / Main.achievementController.win100Times));
			}
			else
			{
				achievementsYouGot ++;
				model.AchievBox.AchievBoxMove.AchievWin100Times.gotoAndStop("ON");
				model.AchievBox.AchievBoxMove.AchievWin100Times.ProgresBar.tb_Progress.text = "";
				model.AchievBox.AchievBoxMove.AchievWin100Times.ProgresBar.tb_Goal.text = "";
				model.AchievBox.AchievBoxMove.AchievWin100Times.ProgresBar.tb_Dash.text = completed;
				model.AchievBox.AchievBoxMove.AchievWin100Times.ProgresBar.gotoAndStop(100);
			}
			
			if(Main.achievementController.killsFor10 < Main.achievementController.kill10Dragons)
			{
				model.AchievBox.AchievBoxMove.AchievKill10Dragons.ProgresBar.tb_Progress.text = Main.achievementController.killsFor10.toString();
				model.AchievBox.AchievBoxMove.AchievKill10Dragons.ProgresBar.tb_Goal.text = Main.achievementController.kill10Dragons.toString();
				model.AchievBox.AchievBoxMove.AchievKill10Dragons.ProgresBar.gotoAndStop(int((Main.achievementController.killsFor10 * 100) / Main.achievementController.kill10Dragons));
			}
			else
			{
				achievementsYouGot ++;
				model.AchievBox.AchievBoxMove.AchievKill10Dragons.gotoAndStop("ON");
				model.AchievBox.AchievBoxMove.AchievKill10Dragons.ProgresBar.tb_Progress.text = "";
				model.AchievBox.AchievBoxMove.AchievKill10Dragons.ProgresBar.tb_Goal.text = "";
				model.AchievBox.AchievBoxMove.AchievKill10Dragons.ProgresBar.tb_Dash.text = completed;
				model.AchievBox.AchievBoxMove.AchievKill10Dragons.ProgresBar.gotoAndStop(100);
			}
			
			if(Main.achievementController.killsFor100 < Main.achievementController.kill100Dragons)
			{
				model.AchievBox.AchievBoxMove.AchievKill100Dragons.ProgresBar.tb_Progress.text = Main.achievementController.killsFor100.toString();
				model.AchievBox.AchievBoxMove.AchievKill100Dragons.ProgresBar.tb_Goal.text = Main.achievementController.kill100Dragons.toString();
				model.AchievBox.AchievBoxMove.AchievKill100Dragons.ProgresBar.gotoAndStop(int((Main.achievementController.killsFor100 * 100) / Main.achievementController.kill100Dragons));
			}
			else
			{
				achievementsYouGot ++;
				model.AchievBox.AchievBoxMove.AchievKill100Dragons.gotoAndStop("ON");
				model.AchievBox.AchievBoxMove.AchievKill100Dragons.ProgresBar.tb_Progress.text = "";
				model.AchievBox.AchievBoxMove.AchievKill100Dragons.ProgresBar.tb_Goal.text = "";
				model.AchievBox.AchievBoxMove.AchievKill100Dragons.ProgresBar.tb_Dash.text = completed;
				model.AchievBox.AchievBoxMove.AchievKill100Dragons.ProgresBar.gotoAndStop(100);
			}
			
			if(Main.achievementController.killsFor500 < Main.achievementController.kill500Dragons)
			{
				model.AchievBox.AchievBoxMove.AchievKill500Dragons.ProgresBar.tb_Progress.text = Main.achievementController.killsFor500.toString();
				model.AchievBox.AchievBoxMove.AchievKill500Dragons.ProgresBar.tb_Goal.text = Main.achievementController.kill500Dragons.toString();
				model.AchievBox.AchievBoxMove.AchievKill500Dragons.ProgresBar.gotoAndStop(int((Main.achievementController.killsFor500 * 100) / Main.achievementController.kill500Dragons));
			}
			else
			{
				achievementsYouGot ++;
				model.AchievBox.AchievBoxMove.AchievKill500Dragons.gotoAndStop("ON");
				model.AchievBox.AchievBoxMove.AchievKill500Dragons.ProgresBar.tb_Progress.text = "";
				model.AchievBox.AchievBoxMove.AchievKill500Dragons.ProgresBar.tb_Goal.text = "";
				model.AchievBox.AchievBoxMove.AchievKill500Dragons.ProgresBar.tb_Dash.text = completed;
				model.AchievBox.AchievBoxMove.AchievKill500Dragons.ProgresBar.gotoAndStop(100);
			}
			
			if(Main.achievementController.killsFor1000 < Main.achievementController.kill1000Dragons)
			{
				model.AchievBox.AchievBoxMove.AchievKill1000Dragons.ProgresBar.tb_Progress.text = Main.achievementController.killsFor1000.toString();
				model.AchievBox.AchievBoxMove.AchievKill1000Dragons.ProgresBar.tb_Goal.text = Main.achievementController.kill1000Dragons.toString();
				model.AchievBox.AchievBoxMove.AchievKill1000Dragons.ProgresBar.gotoAndStop(int((Main.achievementController.killsFor1000 * 100) / Main.achievementController.kill1000Dragons));
			}
			else
			{
				achievementsYouGot ++;
				model.AchievBox.AchievBoxMove.AchievKill1000Dragons.gotoAndStop("ON");
				model.AchievBox.AchievBoxMove.AchievKill1000Dragons.ProgresBar.tb_Progress.text = "";
				model.AchievBox.AchievBoxMove.AchievKill1000Dragons.ProgresBar.tb_Goal.text = "";
				model.AchievBox.AchievBoxMove.AchievKill1000Dragons.ProgresBar.tb_Dash.text = completed;
				model.AchievBox.AchievBoxMove.AchievKill1000Dragons.ProgresBar.gotoAndStop(100);
			}
			
			if(Main.achievementController.winWithOutLosingLife)
			{
				achievementsYouGot ++;
				model.AchievBox.AchievBoxMove.AchievWinWithOutLosingLife.gotoAndStop("ON");
				model.AchievBox.AchievBoxMove.AchievWinWithOutLosingLife.ProgresBar.tb_Progress.text = "";
				model.AchievBox.AchievBoxMove.AchievWinWithOutLosingLife.ProgresBar.tb_Goal.text = "";
				model.AchievBox.AchievBoxMove.AchievWinWithOutLosingLife.ProgresBar.tb_Dash.text = completed;
				model.AchievBox.AchievBoxMove.AchievWinWithOutLosingLife.ProgresBar.gotoAndStop(100);
			}else
			{
				model.AchievBox.AchievBoxMove.AchievWinWithOutLosingLife.ProgresBar.tb_Progress.text = "0";
				model.AchievBox.AchievBoxMove.AchievWinWithOutLosingLife.ProgresBar.tb_Goal.text = "1";
				model.AchievBox.AchievBoxMove.AchievWinWithOutLosingLife.ProgresBar.gotoAndStop(1);
			}
			
			if(Main.achievementController.WinInLessThan3m)
			{
				achievementsYouGot ++;
				model.AchievBox.AchievBoxMove.AchievWinInLessThan3m.gotoAndStop("ON");
				model.AchievBox.AchievBoxMove.AchievWinInLessThan3m.ProgresBar.tb_Progress.text = "";
				model.AchievBox.AchievBoxMove.AchievWinInLessThan3m.ProgresBar.tb_Goal.text = "";
				model.AchievBox.AchievBoxMove.AchievWinInLessThan3m.ProgresBar.tb_Dash.text = completed;
				model.AchievBox.AchievBoxMove.AchievWinInLessThan3m.ProgresBar.gotoAndStop(100);
			}else
			{
				model.AchievBox.AchievBoxMove.AchievWinInLessThan3m.ProgresBar.tb_Progress.text = "0";
				model.AchievBox.AchievBoxMove.AchievWinInLessThan3m.ProgresBar.tb_Goal.text = "1";
				model.AchievBox.AchievBoxMove.AchievWinInLessThan3m.ProgresBar.gotoAndStop(1);
			}
			
			if(Main.achievementController.winWithOutHealingWith1OfLife)
			{
				achievementsYouGot ++;
				model.AchievBox.AchievBoxMove.AchievWinWithOutHealingAndWith1OfLife.gotoAndStop("ON");
				model.AchievBox.AchievBoxMove.AchievWinWithOutHealingAndWith1OfLife.ProgresBar.tb_Progress.text = "";
				model.AchievBox.AchievBoxMove.AchievWinWithOutHealingAndWith1OfLife.ProgresBar.tb_Goal.text = "";
				model.AchievBox.AchievBoxMove.AchievWinWithOutHealingAndWith1OfLife.ProgresBar.tb_Dash.text = completed;
				model.AchievBox.AchievBoxMove.AchievWinWithOutHealingAndWith1OfLife.ProgresBar.gotoAndStop(100);
			}else
			{
				model.AchievBox.AchievBoxMove.AchievWinWithOutHealingAndWith1OfLife.ProgresBar.tb_Progress.text = "0";
				model.AchievBox.AchievBoxMove.AchievWinWithOutHealingAndWith1OfLife.ProgresBar.tb_Goal.text = "1";
				model.AchievBox.AchievBoxMove.AchievWinWithOutHealingAndWith1OfLife.ProgresBar.gotoAndStop(1);
			}
			
			if(Main.achievementController.winForMedicKit < Main.achievementController.winWithMedicKit)
			{
				model.AchievBox.AchievBoxMove.AchievWinWithOutUsingMedicKit.ProgresBar.tb_Progress.text = Main.achievementController.winForMedicKit.toString();
				model.AchievBox.AchievBoxMove.AchievWinWithOutUsingMedicKit.ProgresBar.tb_Goal.text = Main.achievementController.winWithMedicKit.toString();
				model.AchievBox.AchievBoxMove.AchievWinWithOutUsingMedicKit.ProgresBar.gotoAndStop(int((Main.achievementController.winForMedicKit * 100) / Main.achievementController.winWithMedicKit));
			}
			else
			{
				achievementsYouGot ++;
				model.AchievBox.AchievBoxMove.AchievWinWithOutUsingMedicKit.gotoAndStop("ON");
				model.AchievBox.AchievBoxMove.AchievWinWithOutUsingMedicKit.ProgresBar.tb_Progress.text = "";
				model.AchievBox.AchievBoxMove.AchievWinWithOutUsingMedicKit.ProgresBar.tb_Goal.text = "";
				model.AchievBox.AchievBoxMove.AchievWinWithOutUsingMedicKit.ProgresBar.tb_Dash.text = completed;
				model.AchievBox.AchievBoxMove.AchievWinWithOutUsingMedicKit.ProgresBar.gotoAndStop(100);
			}
			
			if(Main.achievementController.winForMedicKit10 < Main.achievementController.winWith10MedicKit)
			{
				model.AchievBox.AchievBoxMove.AchievWinWithOutUsingMedicKit10Times.ProgresBar.tb_Progress.text = Main.achievementController.winForMedicKit10.toString();
				model.AchievBox.AchievBoxMove.AchievWinWithOutUsingMedicKit10Times.ProgresBar.tb_Goal.text = Main.achievementController.winWith10MedicKit.toString();
				model.AchievBox.AchievBoxMove.AchievWinWithOutUsingMedicKit10Times.ProgresBar.gotoAndStop(int((Main.achievementController.winForMedicKit10 * 100) / Main.achievementController.winWith10MedicKit));
			}
			else
			{
				achievementsYouGot ++;
				model.AchievBox.AchievBoxMove.AchievWinWithOutUsingMedicKit10Times.gotoAndStop("ON");
				model.AchievBox.AchievBoxMove.AchievWinWithOutUsingMedicKit10Times.ProgresBar.tb_Progress.text = "";
				model.AchievBox.AchievBoxMove.AchievWinWithOutUsingMedicKit10Times.ProgresBar.tb_Goal.text = "";
				model.AchievBox.AchievBoxMove.AchievWinWithOutUsingMedicKit10Times.ProgresBar.tb_Dash.text = completed;
				model.AchievBox.AchievBoxMove.AchievWinWithOutUsingMedicKit10Times.ProgresBar.gotoAndStop(100);
			}
			
			if(Main.achievementController.winsWithBattery < Main.achievementController.win3timesWithBattery)
			{
				model.AchievBox.AchievBoxMove.AchievWin3TimesWithBattery.ProgresBar.tb_Progress.text = Main.achievementController.winsWithBattery.toString();
				model.AchievBox.AchievBoxMove.AchievWin3TimesWithBattery.ProgresBar.tb_Goal.text = Main.achievementController.win3timesWithBattery.toString();
				model.AchievBox.AchievBoxMove.AchievWin3TimesWithBattery.ProgresBar.gotoAndStop(int((Main.achievementController.winsWithBattery * 100) / Main.achievementController.win3timesWithBattery));
			}
			else
			{
				achievementsYouGot ++;
				model.AchievBox.AchievBoxMove.AchievWin3TimesWithBattery.gotoAndStop("ON");
				model.AchievBox.AchievBoxMove.AchievWin3TimesWithBattery.ProgresBar.tb_Progress.text = "";
				model.AchievBox.AchievBoxMove.AchievWin3TimesWithBattery.ProgresBar.tb_Goal.text = "";
				model.AchievBox.AchievBoxMove.AchievWin3TimesWithBattery.ProgresBar.tb_Dash.text = completed;
				model.AchievBox.AchievBoxMove.AchievWin3TimesWithBattery.ProgresBar.gotoAndStop(100);
			}
			
			if(Main.achievementController.winsWithGoldenAmo < Main.achievementController.win3TimesWithGoldenAmo)
			{
				model.AchievBox.AchievBoxMove.AchievWin3TimesWithGoldAmo.ProgresBar.tb_Progress.text = Main.achievementController.winsWithGoldenAmo.toString();
				model.AchievBox.AchievBoxMove.AchievWin3TimesWithGoldAmo.ProgresBar.tb_Goal.text = Main.achievementController.win3TimesWithGoldenAmo.toString();
				model.AchievBox.AchievBoxMove.AchievWin3TimesWithGoldAmo.ProgresBar.gotoAndStop(int((Main.achievementController.winsWithGoldenAmo * 100) / Main.achievementController.win3TimesWithGoldenAmo));
			}
			else
			{
				achievementsYouGot ++;
				model.AchievBox.AchievBoxMove.AchievWin3TimesWithGoldAmo.gotoAndStop("ON");
				model.AchievBox.AchievBoxMove.AchievWin3TimesWithGoldAmo.ProgresBar.tb_Progress.text = "";
				model.AchievBox.AchievBoxMove.AchievWin3TimesWithGoldAmo.ProgresBar.tb_Goal.text = "";
				model.AchievBox.AchievBoxMove.AchievWin3TimesWithGoldAmo.ProgresBar.tb_Dash.text = completed;
				model.AchievBox.AchievBoxMove.AchievWin3TimesWithGoldAmo.ProgresBar.gotoAndStop(100);
			}
			
			if(Main.achievementController.winWithBothBuffs)
			{
				achievementsYouGot ++;
				model.AchievBox.AchievBoxMove.AchievWinWithBothUpgrades.gotoAndStop("ON");
				model.AchievBox.AchievBoxMove.AchievWinWithBothUpgrades.ProgresBar.tb_Progress.text = "";
				model.AchievBox.AchievBoxMove.AchievWinWithBothUpgrades.ProgresBar.tb_Goal.text = "";
				model.AchievBox.AchievBoxMove.AchievWinWithBothUpgrades.ProgresBar.tb_Dash.text = completed;
				model.AchievBox.AchievBoxMove.AchievWinWithBothUpgrades.ProgresBar.gotoAndStop(100);
			}else
			{
				model.AchievBox.AchievBoxMove.AchievWinWithBothUpgrades.ProgresBar.tb_Progress.text = "0";
				model.AchievBox.AchievBoxMove.AchievWinWithBothUpgrades.ProgresBar.tb_Goal.text = "1";
				model.AchievBox.AchievBoxMove.AchievWinWithBothUpgrades.ProgresBar.gotoAndStop(1);
			}
			
			if(Main.achievementController.winWithMaxAmoAndMaxLife)
			{
				achievementsYouGot ++;
				model.AchievBox.AchievBoxMove.AchievWinWithMaxAmoAndMaxLife.gotoAndStop("ON");
				model.AchievBox.AchievBoxMove.AchievWinWithMaxAmoAndMaxLife.ProgresBar.tb_Progress.text = "";
				model.AchievBox.AchievBoxMove.AchievWinWithMaxAmoAndMaxLife.ProgresBar.tb_Goal.text = "";
				model.AchievBox.AchievBoxMove.AchievWinWithMaxAmoAndMaxLife.ProgresBar.tb_Dash.text = completed;
				model.AchievBox.AchievBoxMove.AchievWinWithMaxAmoAndMaxLife.ProgresBar.gotoAndStop(100);
			}else
			{
				model.AchievBox.AchievBoxMove.AchievWinWithMaxAmoAndMaxLife.ProgresBar.tb_Progress.text = "0";
				model.AchievBox.AchievBoxMove.AchievWinWithMaxAmoAndMaxLife.ProgresBar.tb_Goal.text = "1";
				model.AchievBox.AchievBoxMove.AchievWinWithMaxAmoAndMaxLife.ProgresBar.gotoAndStop(1);
			}
			
			if(Main.achievementController.usedLessThan20Bullets)
			{
				achievementsYouGot ++;
				model.AchievBox.AchievBoxMove.AchievWinUsingLessThan20Bullets.gotoAndStop("ON");
				model.AchievBox.AchievBoxMove.AchievWinUsingLessThan20Bullets.ProgresBar.tb_Progress.text = "";
				model.AchievBox.AchievBoxMove.AchievWinUsingLessThan20Bullets.ProgresBar.tb_Goal.text = "";
				model.AchievBox.AchievBoxMove.AchievWinUsingLessThan20Bullets.ProgresBar.tb_Dash.text = completed;
				model.AchievBox.AchievBoxMove.AchievWinUsingLessThan20Bullets.ProgresBar.gotoAndStop(100);
			}else
			{
				model.AchievBox.AchievBoxMove.AchievWinUsingLessThan20Bullets.ProgresBar.tb_Progress.text = "0";
				model.AchievBox.AchievBoxMove.AchievWinUsingLessThan20Bullets.ProgresBar.tb_Goal.text = "1";
				model.AchievBox.AchievBoxMove.AchievWinUsingLessThan20Bullets.ProgresBar.gotoAndStop(1);
			}
			
			if(Main.achievementController.killedAllTheDragonsInTheLevel)
			{
				achievementsYouGot ++;
				model.AchievBox.AchievBoxMove.AchievKillAllTheDragonOnTheLevel.gotoAndStop("ON");
				model.AchievBox.AchievBoxMove.AchievKillAllTheDragonOnTheLevel.ProgresBar.tb_Progress.text = "";
				model.AchievBox.AchievBoxMove.AchievKillAllTheDragonOnTheLevel.ProgresBar.tb_Goal.text = "";
				model.AchievBox.AchievBoxMove.AchievKillAllTheDragonOnTheLevel.ProgresBar.tb_Dash.text = completed;
				model.AchievBox.AchievBoxMove.AchievKillAllTheDragonOnTheLevel.ProgresBar.gotoAndStop(100);
			}else
			{
				model.AchievBox.AchievBoxMove.AchievKillAllTheDragonOnTheLevel.ProgresBar.tb_Progress.text = "0";
				model.AchievBox.AchievBoxMove.AchievKillAllTheDragonOnTheLevel.ProgresBar.tb_Goal.text = "1";
				model.AchievBox.AchievBoxMove.AchievKillAllTheDragonOnTheLevel.ProgresBar.gotoAndStop(1);
			}
			
			if(Main.achievementController.loseAllYourLifeInLava)
			{
				achievementsYouGot ++;
				model.AchievBox.AchievBoxMove.AchievLoseAllYourLifeInTheLava.gotoAndStop("ON");
				model.AchievBox.AchievBoxMove.AchievLoseAllYourLifeInTheLava.ProgresBar.tb_Progress.text = "";
				model.AchievBox.AchievBoxMove.AchievLoseAllYourLifeInTheLava.ProgresBar.tb_Goal.text = "";
				model.AchievBox.AchievBoxMove.AchievLoseAllYourLifeInTheLava.ProgresBar.tb_Dash.text = completed;
				model.AchievBox.AchievBoxMove.AchievLoseAllYourLifeInTheLava.ProgresBar.gotoAndStop(100);
			}else
			{
				model.AchievBox.AchievBoxMove.AchievLoseAllYourLifeInTheLava.ProgresBar.tb_Progress.text = "0";
				model.AchievBox.AchievBoxMove.AchievLoseAllYourLifeInTheLava.ProgresBar.tb_Goal.text = "1";
				model.AchievBox.AchievBoxMove.AchievLoseAllYourLifeInTheLava.ProgresBar.gotoAndStop(1);
			}
			
			if(Main.achievementController.getAllTheAchievements)
			{
				achievementsYouGot ++;
				model.AchievBox.AchievBoxMove.AchievGetAllTheAchievement.gotoAndStop("ON");
				model.AchievBox.AchievBoxMove.AchievGetAllTheAchievement.ProgresBar.tb_Progress.text = "";
				model.AchievBox.AchievBoxMove.AchievGetAllTheAchievement.ProgresBar.tb_Goal.text = "";
				model.AchievBox.AchievBoxMove.AchievGetAllTheAchievement.ProgresBar.tb_Dash.text = completed;
				model.AchievBox.AchievBoxMove.AchievGetAllTheAchievement.ProgresBar.gotoAndStop(100);
			}else
			{
				model.AchievBox.AchievBoxMove.AchievGetAllTheAchievement.ProgresBar.tb_Progress.text = achievementsYouGot.toString();
				model.AchievBox.AchievBoxMove.AchievGetAllTheAchievement.ProgresBar.tb_Goal.text = totalAchievements.toString();
				model.AchievBox.AchievBoxMove.AchievGetAllTheAchievement.ProgresBar.gotoAndStop(int((achievementsYouGot * 100) / totalAchievements));
			}
			
			if(Main.achievementController.wroteVedoyaOnTheCOnsole)
			{
				model.AchievBox.AchievBoxMove.AchievWriteVedoyaNnTheConsole.gotoAndStop("ON");
				model.AchievBox.AchievBoxMove.AchievWriteVedoyaNnTheConsole.ProgresBar.tb_Progress.text = "";
				model.AchievBox.AchievBoxMove.AchievWriteVedoyaNnTheConsole.ProgresBar.tb_Goal.text = "";
				model.AchievBox.AchievBoxMove.AchievWriteVedoyaNnTheConsole.ProgresBar.tb_Dash.text = completed;
				model.AchievBox.AchievBoxMove.AchievWriteVedoyaNnTheConsole.ProgresBar.gotoAndStop(100);
			}else
			{
				model.AchievBox.AchievBoxMove.AchievWriteVedoyaNnTheConsole.gotoAndStop("OFF");
			}
			
			if(Main.achievementController.openedTheConsole)
			{
				model.AchievBox.AchievBoxMove.AchievOpenConsole.gotoAndStop("ON");
				model.AchievBox.AchievBoxMove.AchievOpenConsole.ProgresBar.tb_Progress.text = "";
				model.AchievBox.AchievBoxMove.AchievOpenConsole.ProgresBar.tb_Goal.text = "";
				model.AchievBox.AchievBoxMove.AchievOpenConsole.ProgresBar.tb_Dash.text = completed;
				model.AchievBox.AchievBoxMove.AchievOpenConsole.ProgresBar.gotoAndStop(100);
			}else
			{
				model.AchievBox.AchievBoxMove.AchievOpenConsole.gotoAndStop("OFF");
			}
			
			if(Main.achievementController.buggedTheGame)
			{
				model.AchievBox.AchievBoxMove.AchievBugTheGame.gotoAndStop("ON");
				model.AchievBox.AchievBoxMove.AchievBugTheGame.ProgresBar.tb_Progress.text = "";
				model.AchievBox.AchievBoxMove.AchievBugTheGame.ProgresBar.tb_Goal.text = "";
				model.AchievBox.AchievBoxMove.AchievBugTheGame.ProgresBar.tb_Dash.text = completed;
				model.AchievBox.AchievBoxMove.AchievBugTheGame.ProgresBar.gotoAndStop(100);
			}
			else
			{
				model.AchievBox.AchievBoxMove.AchievBugTheGame.gotoAndStop("OFF");
			}
			
		}
		override public function Update():void
		{
			if(model.AchievBox.AchievBoxMove.y <= -model.AchievBox.AchievBoxMove.height + model.AchievBox.AchievMAscBar.height)
			{
				model.AchievBox.AchievBoxMove.y = -model.AchievBox.AchievBoxMove.height + model.AchievBox.AchievMAscBar.height;
			}
			if(model.AchievBox.AchievBoxMove.y >= 0)
			{
				model.AchievBox.AchievBoxMove.y = 0;
			}
		}
		protected function evBox(event:MouseEvent):void
		{
			if(event.delta > 0)
			{
				model.AchievBox.AchievBoxMove.y += 40;
			}else if(event.delta < 0)
			{
				model.AchievBox.AchievBoxMove.y -= 40;
			}
		}
		protected function evUP(event:MouseEvent):void
		{
			model.AchievBox.AchievBoxMove.y += 150;
		}
		protected function evOverUP(event:MouseEvent):void
		{
			model.UP.gotoAndPlay("Over");
		}
		protected function evOutUP(event:MouseEvent):void
		{
			model.UP.gotoAndPlay("Idle");
		}
		protected function evDawn(event:MouseEvent):void
		{
			model.AchievBox.AchievBoxMove.y -= 150;
		}
		protected function evOverDawn(event:MouseEvent):void
		{
			model.Dawn.gotoAndPlay("Over");
		}
		protected function evOutDawn(event:MouseEvent):void
		{
			model.Dawn.gotoAndPlay("Idle");
		}
		protected function evBack(event:MouseEvent):void
		{
			Change("More");
		}
		protected function evOverBack(event:MouseEvent):void
		{
			model.Back.gotoAndPlay("Over");
		}
		protected function evOutBack(event:MouseEvent):void
		{
			model.Back.gotoAndPlay("Idle");
		}
		override public function Exit():void
		{
			Main.achievementController.Save();
			model.Back.removeEventListener(MouseEvent.CLICK, evBack);
			model.Back.removeEventListener(MouseEvent.MOUSE_OVER, evOverBack);
			model.Back.removeEventListener(MouseEvent.MOUSE_OUT, evOutBack);
			
			Main.ScreenContainer.removeChild(model);
		}
	}
}