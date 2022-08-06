package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.media.Sound;
	
	import Engine.Locator;
	import Engine.SoundController;
	
	public class Character
	{
		public var model:MovieClip = Locator.assetsManager.GetMovieClipsByName("MC_Character");
		public var currentScale:Number;
		public var takeDamageCD:Number = 110;
		public var timeToDisappear:Number = 420;
		public var timeToFall:Number;
		public var shootCD:Number = 0;
		public var xSpeed:Number = 2.5;
		public var ySpeed:Number = 0;
		public var jumpForce:Number = 6;
		public var jumpCD:Number = 30;
		public var jumpDone:Number = 0;
		public var maxJump:Number = 14;
		public var health:int = 5;
		public var maxHealth:int = 5;
		public var ammo:int = 6;
		public var directionX:int;
		public var goldenWeapon:Boolean;
		public var upgradedLight:Boolean;
		public var extraMedicKit:Boolean;
		public var vedoyaMode:Boolean;
		public var godMode:Boolean;
		public var allVisible:Boolean;
		public var bugged:Boolean;
		public var locked:Boolean;
		public var fallingTimer:Boolean;
		public var isOnGround:Boolean;
		public var jumping:Boolean;
		public var dying:Boolean;
		public var dead:Boolean;
		public var light:Light;
		
		public var volume:Number = 50;
		public var shoot:Sound = Locator.assetsManager.GetSoundByName("Shoot");
		public var soundShoot:SoundController;
		
		public var destroy:Sound = Locator.assetsManager.GetSoundByName("Destroy");
		public var soundDestroy:SoundController;
		
		public var hurted01:Sound = Locator.assetsManager.GetSoundByName("Hurted01");
		public var soundHurted01:SoundController;
		
		public var hurted02:Sound = Locator.assetsManager.GetSoundByName("Hurted02");
		public var soundHurted02:SoundController;
		
		public var healMK:Sound = Locator.assetsManager.GetSoundByName("HealMedicKit");
		public var soundHealMK:SoundController;
		
		public var characterMove:Sound = Locator.assetsManager.GetSoundByName("CharacterMove");
		public var soundCharacterMove:SoundController;
		
		public function Character(PosX:Number, PosY:Number)
		{
			Game.world.model.charLayer.addChild(model);
			model.x = PosX;
			model.y = PosY;
			model.scaleX = model.scaleY = currentScale = 1;
			model.scaleX = currentScale * -1;
			model.bald.alpha = 0;
			
			light = new Light();
			light.SetTarget(model);
			
			ChangeAnimation("Idle");
			
			model.addEventListener("Unlock", Unlock);
			
			soundShoot = new SoundController(shoot);
			soundDestroy = new SoundController(destroy);
			soundHurted01 = new SoundController(hurted01);
			soundHurted02 = new SoundController(hurted02);
			soundHealMK = new SoundController(healMK);
			soundCharacterMove = new SoundController(characterMove);
			
			Locator.updateManager.AddCallback(Update);
		}
		
		public function Update():void
		{
			if(!dying)
			{
				GodMode();
				CheckDamageCollisions();
				CheckCollisions();
				MovementSound();
				MakeJump();
				ApplyGravity();
				DamageAnimation();
				ManageCooldowns();
				LimitHealth();
				LimitAmmo();
				ManageBald();
				CheckBugMap();
			}
			if(!dead) Die();
		}
		
		public function GodMode():void
		{
			if(godMode)
			{
				health = 5;
				ammo = 99;
				extraMedicKit = true;
				upgradedLight = true;
				goldenWeapon = true;
			}
		}
		
		public function Unlock(event:Event):void
		{
			locked = false;
		}
		
		public function CheckDamageCollisions():void
		{
			for(var i:int = 0; i < Game.world.hitboxesLava.length; i++)
			{
				if(model.hitbox.hitTestObject(Game.world.hitboxesLava[i]))
				{
					TakeDamage(Game.world.lavaDamage);
				}
			}
		}
		
		public function CheckCollisions():void
		{
			for(var i:int = 0; i < Game.world.hitboxes.length; i++)
			{
				if(model.hitboxUp.hitTestObject(Game.world.hitboxes[i]))
				{
					model.y = model.y + 5;
				}
				if(model.hitboxDown.hitTestObject(Game.world.hitboxes[i]))
				{
					ySpeed = 0.16;
					model.y = model.y - ySpeed;
					ySpeed = 0;
				}
				if(model.hitboxForward.hitTestObject(Game.world.hitboxes[i]))
				{
					model.x = model.x - (xSpeed * directionX);
				}
				if(model.hitboxBack.hitTestObject(Game.world.hitboxes[i]))
				{
					model.x = model.x - (xSpeed * directionX);
				}
			}
			
			for(var j:int = 0; j < Game.world.hitboxesGround.length; j++)
			{
				if(model.hitboxDown.hitTestObject(Game.world.hitboxesGround[j]))
				{
					isOnGround = true;
					return;
				}
				else
				{
					isOnGround = false;
				}
			}
		}
		
		public function Shoot():void
		{
			if(!locked)
			{
				if(shootCD <= 0)
				{
					if(ammo > 0)
					{
						if(goldenWeapon) 
						{
							var goldenBullet:GoldenBullet = new GoldenBullet();
							if(godMode) goldenBullet.GodMode();
						}
						else
						{
							var bullet:Bullet = new Bullet();
							if(godMode) bullet.GodMode();
						}
						shootCD = 35;
						ammo --;
						Main.achievementController.AmoUsed();
						Main.scoreManager.RemoveScore(Main.scoreManager.usedBullet);
				
						soundShoot.Play((Locator.soundVolume * volume) / 100,1);
					}
				}
			}
		}
		
		public function Move(dirX:int):void
		{	
			if(!dying)
			{
				if(!locked)
				{
					directionX = dirX;
					
					if(dirX == 1)
					{
						MoveRightAndLeft(dirX);
					}
					else if(dirX == -1)
					{
						MoveRightAndLeft(dirX);
					}
				}
			}
		}
		
		public function ApplyGravity():void
		{
			if(isOnGround)
			{
				if(ySpeed > 0)
				{
					ySpeed *= -0.016;
				}
			}
			else
			{
				if(!jumping)
				{
					ySpeed += Game.world.gravity;
					
					Fall();
				}
			}
		}
		
		public function Jump():void
		{
			if(!locked)
			{
				if(jumpCD <= 0)
				{
					if(isOnGround)
					{
						jumping = true;
						jumpDone = 0;
						timeToFall = 0;
					}
				}
			}
		}
		
		public function MakeJump():void
		{
			jumpCD -= 1;
			
			if(jumpCD <= 0)
			{
				if(jumping)
				{
					jumpDone += 1;
					
					if(jumpDone <= maxJump)
					{
						model.y -= jumpForce;
					}
					else
					{
						jumpCD = 30;
						fallingTimer = true;
					}
				}
			}
			
			if(fallingTimer)
			{
				timeToFall += 1;
			}
			if(timeToFall >= 6)
			{
				jumping = false;
				fallingTimer = false;
				timeToFall = 0;
			}
		}
		
		public function Fall():void
		{
			model.y += ySpeed;
		}
		
		public function TakeDamage(damage:Number):void
		{
			if(!godMode)
			{
				if(!dead && !dying)
				{
					if(takeDamageCD >= 110)
					{
						health -= damage;
						
						Main.achievementController.Damaged();
						
						Main.scoreManager.RemoveScore(Main.scoreManager.damaged);
						
						var randomSound:Number = Math.ceil((Math.random() * (2 - 0)));
						
						if(randomSound == 1) soundHurted01.Play((Locator.soundVolume * volume) / 100,1);
						if(randomSound == 2) soundHurted02.Play((Locator.soundVolume * volume) / 100,1);
						
						if(health > 0) takeDamageCD = 0;
					}	
				}
			}
		}
		
		public function DamageAnimation():void
		{
			if (takeDamageCD < 10) model.visible = false;
			if (takeDamageCD > 10 && takeDamageCD < 20) model.visible = true;
			if (takeDamageCD > 20 && takeDamageCD < 30)	model.visible = false;
			if (takeDamageCD > 30 && takeDamageCD < 40)	model.visible = true;
			if (takeDamageCD > 40 && takeDamageCD < 50)	model.visible = false;
			if (takeDamageCD > 50 && takeDamageCD < 60)	model.visible = true;
			if (takeDamageCD > 60 && takeDamageCD < 70)	model.visible = false;
			if (takeDamageCD > 70 && takeDamageCD < 80)	model.visible = true;
			if (takeDamageCD > 80 && takeDamageCD < 90) model.visible = false;
			if (takeDamageCD > 90 && takeDamageCD < 100) model.visible = true;
			if (takeDamageCD > 100 && takeDamageCD < 110) model.visible = false;
			if (takeDamageCD == 110) model.visible = true;
		}
		
		public function ManageCooldowns():void
		{
			takeDamageCD += 1;
			shootCD -= 1;
		}
		
		public function LimitHealth():void
		{
			if(health > maxHealth) health = maxHealth;
			if(health < 0) health = 0;
		}
		
		public function LimitAmmo():void
		{
			if(ammo > 99) ammo = 99;
			if(ammo < 0) ammo = 0;
		}
		
		public function ManageBald():void
		{
			if(vedoyaMode) model.bald.alpha = 100;
			else model.bald.alpha = 0;
		}
		
		public function CheckBugMap():void
		{
			if(model.y >= 1000)
			{
				bugged = true;
				TakeDamage(5);
				Main.achievementController.YouBuggedTheGame();
			}
		}
		
		public function MovementSound():void
		{
			if (model.currentLabel != "Move" || !isOnGround)
			{
				if(soundCharacterMove.playing)
				{
					if(soundCharacterMove != null)
					{
						soundCharacterMove.Stop();
					}
				}
			}
		}
		
		public function MoveRightAndLeft(dirX:int):void
		{
			model.scaleX = -dirX * currentScale;
			model.x += xSpeed * dirX;
			light.Rotation(dirX);
			
			if(isOnGround)
			{
				if(!soundCharacterMove.playing)
				{
					soundCharacterMove.Play((Locator.soundVolume * (volume - 35)) / 100,100);
				}
			}

			ChangeAnimation("Move");
		}
		
		
		public function Heal():void
		{
			if(extraMedicKit)
			{
				if(health < 5)
				{
					soundHealMK.Play((Locator.soundVolume * (volume + 20)) / 100,1);
					health ++;
					extraMedicKit = false;
					Main.achievementController.Healed();
					Main.scoreManager.RemoveScore(Main.scoreManager.heal);
				}
			}
		}
		
		public function Die():void
		{
			if(health <= 0 && !dying)
			{
				ChangeAnimation("Death");
				soundDestroy.Play((Locator.soundVolume * volume) / 100,1);
				Main.scoreManager.RemoveScore(Main.scoreManager.dead);
				dying = true;
			}
			if(dying)
			{
				timeToDisappear --;
				DeadFall();
			}
			if(timeToDisappear <= 0)
			{
				if(soundCharacterMove != null) soundCharacterMove.Stop();
				model.parent.removeChild(model);
				dead = true;
				Locator.updateManager.RemoveCallback(Update);
			}
		}
		
		public function DeadFall():void
		{
			if(!isOnGround)
			{
				model.y += xSpeed;
				
				for (var i:int = 0; i < Game.world.hitboxesGround.length; i++)
				{
					if(model.hitboxGround.hitTestObject(Game.world.hitboxesGround[i]))
					{
						isOnGround = true;
						return;
					}
				}
			}
		}
		
		public function ChangeAnimation(animationName:String):void
		{
			if (model.currentLabel != animationName)
			{
				model.gotoAndPlay(animationName);
			}
		}
		public function Restart():void
		{
			light.Restart();
			light = null;
			model.removeEventListener("Unlock", Unlock);
			
			Locator.updateManager.RemoveCallback(Update);
		}
	}
}