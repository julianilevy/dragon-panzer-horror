package Enemies
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.media.Sound;
	
	import Engine.Locator;
	import Engine.SoundController;
	
	import Items.AmmoKit;
	import Items.MedicKit;

	public class Boss
	{
		public var model:MovieClip = Locator.assetsManager.GetMovieClipsByName("MC_Boss");
		public var healthBar:MovieClip = Locator.assetsManager.GetMovieClipsByName("MC_BossHealthBar");
		public var currentScale:Number;
		public var timeToStartFight:Number = 150;
		public var timeToDisappear:Number = 420;
		public var skillCD:Number = 420;
		public var speed:Number = 1.8;
		public var attackDirX:Number = 0;
		public var attackDirY:Number = 0;
		public var attackSkillTimer:Number = 300;
		public var timeToAttackSkill:Number = 10;
		public var directionY:int = -1;
		public var hudHealth:int = 20;
		public var health:int = 20;
		public var maxHealth:int = 20;
		public var damage:int = 1;
		public var skillNumber:int = 0;
		public var fireSkillNumber:int = 0;
		public var shootsFired:int = 0;
		public var appeared:Boolean;
		public var entranceBlocked:Boolean;
		public var fightStarted:Boolean;
		public var fireSkillON:Boolean;
		public var firePosReached:Boolean;
		public var attackSkillON:Boolean;
		public var attackSkillTargetSet:Boolean;
		public var goingBack:Boolean;
		public var dying:Boolean;
		public var dead:Boolean;
		
		public var volume:Number = 60;
		
		public var bossWingEffect:Sound = Locator.assetsManager.GetSoundByName("BossWingEffect");
		public var soundWing:SoundController;
		
		public var bossDie:Sound = Locator.assetsManager.GetSoundByName("BossDie");
		public var soundBossDie:SoundController;
		
		public var bossAppears:Sound = Locator.assetsManager.GetSoundByName("BossAppears");
		public var soundBossAppears:SoundController;
		
		public var bossBite:Sound = Locator.assetsManager.GetSoundByName("BossBite");
		public var soundBossBite:SoundController;
		
		public var fireBall:Sound = Locator.assetsManager.GetSoundByName("FireBall");
		public var soundFireBall:SoundController;
		
		public var fireBallWave:Sound = Locator.assetsManager.GetSoundByName("FireBallWave");
		public var soundFireBallWave:SoundController;
		
		public function Boss(PosX:Number, PosY:Number)
		{
			Game.world.model.bossLayer.addChild(model);
			model.x = PosX;
			model.y = PosY;
			model.scaleX = model.scaleY = currentScale = 0.8;
			
			Locator.ContainerHUD.addChild(healthBar);
			healthBar.x = 700;
			healthBar.y = 900;
			healthBar.scaleX = 2.8;
			healthBar.scaleY = 2.8;
			healthBar.bar.gotoAndPlay(0);
			
			model.addEventListener("ShootFire", ShootFire);
			model.addEventListener("CheckShootsFired", CheckShootsFired);
			model.addEventListener("AttackDone", AttackDone);
			model.addEventListener("FlySound", FlySound);
			model.addEventListener("BiteSound", BiteSound);
			
			soundWing = new SoundController(bossWingEffect);
			soundBossDie = new SoundController(bossDie);
			soundBossAppears = new SoundController(bossAppears);
			soundBossBite = new SoundController(bossBite);
			soundFireBall = new SoundController(fireBall);
			soundFireBallWave = new SoundController(fireBallWave);
			
			Locator.updateManager.AddCallback(Update);
		}
		
		protected function FlySound(event:Event):void
		{
			soundWing.Play((Locator.soundVolume * volume) / 100,1);
		}
		protected function BiteSound(event:Event):void
		{
			soundBossBite.Play((Locator.soundVolume * (volume - 20)) / 100,1);	
		}
		public function Update():void
		{
			if(!dead)
			{
				Appear();
				
				if(fightStarted)
				{
					ManageHealthBar();
					Die();
					
					if(!dying)
					{
						CheckCollisions();
						Movement();
						SkillCooldown();
						DoFireSkill();
						DoAttackSkill();
						GoBackToOriginalPos();
					}
				}
			}
		}
		
		public function Appear():void
		{
			if(!appeared)
			{
				model.y -= 2.5;
				MoveEntrance();
				healthBar.bar.gotoAndPlay(0);
				
				if(model.hitboxHP.hitTestObject(Game.world.model.bossLimit))
				{
					soundBossAppears.Play((Locator.soundVolume * volume) / 100,1);
					appeared = true;
				}
			}
			if(appeared && !fightStarted)
			{
				timeToStartFight--;
				MoveEntrance();
				healthBar.bar.nextFrame();
				
				if(timeToStartFight <= 0)
				{
					//volves a mover
					Game.instance.PlayFightMusic();
					Game.character.locked = false;
					fightStarted = true;
				}
			}
		}
		
		public function MoveEntrance():void
		{
			if(!entranceBlocked)
			{
				Game.world.model.bossDoor.y += 0.3;
				
				if(Game.world.model.bossDoor.hitTestObject(Game.world.model.bossDoorLimit))
				{
					Game.world.hitboxes.push(Game.world.model.bossDoor);
					entranceBlocked = true;
				}
			}
		}
		
		public function ManageHealthBar():void
		{
			if(hudHealth > health)
			{
				if(healthBar.bar.currentFrame != health * 100 / maxHealth) healthBar.bar.prevFrame();
				else hudHealth = health;
			}
			
			if(health <= 0)
			{
				if (healthBar.currentLabel != "Disappear") healthBar.gotoAndPlay("Disappear");
			}
		}
		
		public function CheckCollisions():void
		{
			if(model.hitboxDamage.hitTestObject(Game.character.model.hitbox))Game.character.TakeDamage(damage);
		}
		
		public function Movement():void
		{
			if(!firePosReached && !attackSkillON)
			{
				if(model.hitboxDirection.hitTestObject(Game.world.model.bossDown)) directionY = -1;
				if(model.hitboxDirection.hitTestObject(Game.world.model.bossUp)) directionY = 1;
				
				model.y += speed * directionY;
			}
		}
		
		public function SkillCooldown():void
		{
			if(!fireSkillON && !attackSkillON) skillCD --;
			if(skillCD <= 0)
			{
				skillNumber = Math.ceil((Math.random() * (2 - 0)));
				
				if(skillNumber == 1)
				{
					fireSkillNumber = Math.ceil((Math.random() * (2 - 0)));
					fireSkillON = true;
					skillCD = 420;
				}
				if(skillNumber == 2)
				{
					attackSkillON = true;
					skillCD = 420;
				}
			}
		}
		
		public function DoFireSkill():void
		{
			if(fireSkillON)
			{
				if(fireSkillNumber == 1)
				{
					if(model.hitboxFirePos.hitTestObject(Game.world.model.bossFirePos01)) firePosReached = true;
				}
				if(fireSkillNumber == 2)
				{
					if(model.hitboxFirePos.hitTestObject(Game.world.model.bossFirePos02)) firePosReached = true;
				}
				if(firePosReached) ChangeAnimation("Fire");
			}
		}
		
		public function ShootFire(event:Event):void
		{
			if(fireSkillNumber == 1)
			{
				new BossFireball(model.x + 25, model.y, Game.character.model.x, Game.character.model.y - 40, 1);
				shootsFired++;
				soundFireBall.Play((Locator.soundVolume * volume) / 100,1);
			}
			if(fireSkillNumber == 2)
			{
				new BossFireball(model.x + 20, model.y - 120, Game.world.model.bossTarget.x, Game.world.model.bossTarget.y, -1);
				new BossFireball(model.x + 20, model.y - 120, Game.world.model.bossTarget.x + 200, Game.world.model.bossTarget.y - 250, -1);
				new BossFireball(model.x + 20, model.y - 120, Game.world.model.bossTarget.x + 200, Game.world.model.bossTarget.y - 500, -1);
				new BossFireball(model.x + 20, model.y - 120, Game.world.model.bossTarget.x + 200, Game.world.model.bossTarget.y - 600, -1);
				new BossFireball(model.x + 20, model.y - 120, Game.world.model.bossTarget.x + 200, Game.world.model.bossTarget.y - 670, -1);
				new BossFireball(model.x + 20, model.y - 120, Game.world.model.bossTarget.x - 168, Game.world.model.bossTarget.y - 250, -1);
				new BossFireball(model.x + 20, model.y - 120, Game.world.model.bossTarget.x - 168, Game.world.model.bossTarget.y - 500, -1);
				new BossFireball(model.x + 20, model.y - 120, Game.world.model.bossTarget.x - 168, Game.world.model.bossTarget.y - 600, -1);
				new BossFireball(model.x + 20, model.y - 120, Game.world.model.bossTarget.x - 168, Game.world.model.bossTarget.y - 670, -1);
				shootsFired++;
				soundFireBallWave.Play((Locator.soundVolume * volume) / 100,1);
			}
		}
		
		public function CheckShootsFired(event:Event):void
		{
			if(shootsFired >= 10)
			{
				ChangeAnimation("Fly");
				fireSkillON = false;
				firePosReached = false;
				shootsFired = 0;
				SpawnItems();
			}
		}
		
		public function DoAttackSkill():void
		{
			if(attackSkillON)
			{
				if(!attackSkillTargetSet)
				{
					attackSkillTimer--;
					
					var distanceX:Number = Game.character.model.x - model.x;
					var distanceY:Number = Game.character.model.y - model.y - 30;
					var radians:Number = Math.atan2(distanceY, distanceX);
					attackDirX = Math.cos(radians);
					attackDirY = Math.sin(radians);
					
					model.x += attackDirX * speed;
					model.y += attackDirY * speed;
					
					if(model.hitboxAttackPos.hitTestObject(Game.character.model.hitboxBossAttack) || attackSkillTimer <= 0)
					{
						attackSkillTargetSet = true;
					}
				}

				if(attackSkillTargetSet && !goingBack)
				{
					timeToAttackSkill--;
					
					if(timeToAttackSkill <= 0)
					{
						ChangeAnimation("Attack");
					}
				}
			}
		}
		
		public function AttackDone(event:Event):void
		{
			goingBack = true;
		}
		
		public function GoBackToOriginalPos():void
		{
			if(goingBack)
			{
				if(model.x > 5905) model.x -= speed;
				if(model.x < 5905) model.x += speed;
				
				if(model.x >= 5903 && model.x <= 5907)
				{
					model.x = 5905;
					attackSkillTimer = 300;
					timeToAttackSkill = 10;
					goingBack = false;
					attackSkillTargetSet = false;
					attackSkillON = false;
					SpawnItems();
				}
			}
		}
		
		public function SpawnItems():void
		{
			var randomItem:Number = Math.ceil((Math.random() * (12 - 0)));
			var randomPosition:Number = Math.ceil((Math.random() * (6 - 0)));
			
			if(randomItem <= 2)
			{
				switch(randomPosition)
				{
					case 1:
						new MedicKit(5826, 322);
						break;
					case 2:
						new MedicKit(5678, 240);
						break;
					case 3:
						new MedicKit(5800, 154);
						break;
					case 4:
						new MedicKit(6048, 322);
						break;
					case 5:
						new MedicKit(6196, 240);
						break;
					case 6:
						new MedicKit(6074, 154);
						break;
				}
			}
			if(randomItem > 2 && randomItem <= 10)
			{
				switch(randomPosition)
				{
					case 1:
						new AmmoKit(5826, 322);
						break;
					case 2:
						new AmmoKit(5678, 240);
						break;
					case 3:
						new AmmoKit(5800, 154);
						break;
					case 4:
						new AmmoKit(6048, 322);
						break;
					case 5:
						new AmmoKit(6196, 240);
						break;
					case 6:
						new AmmoKit(6074, 154);
						break;
				}
			}
		}
		
		public function Die():void
		{
			if(health <= 0 && !dying)
			{
				ChangeAnimation("Death");
				soundBossDie.Play((Locator.soundVolume * volume) / 100,1);
				Main.scoreManager.AddScore(Main.scoreManager.bossKill);
				Main.achievementController.KilledDragon();
				dying = true;
			}
			if(dying)
			{
				timeToDisappear --;
				model.y += speed;
			}
			if(timeToDisappear <= 0)
			{
				model.parent.removeChild(model);
				dead = true;
				Locator.updateManager.RemoveCallback(Update);
			}
		}
		
		public function ChangeAnimation(animationName:String):void
		{
			if (model.currentLabel != animationName) model.gotoAndPlay(animationName);
		}
		
		public function Restart():void
		{
			if(model != null)
			{
				dead = true;
				
				Locator.updateManager.RemoveCallback(Update);
				
				model.removeEventListener("ShootFire", ShootFire);
				model.removeEventListener("CheckShootsFired", CheckShootsFired);
				model.removeEventListener("AttackDone", AttackDone);
				
				if(!dead) Game.world.model.bossLayer.removeChild(model);
			}
		}
	}
}