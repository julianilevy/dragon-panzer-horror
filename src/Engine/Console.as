package Engine
{
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	
	public class Console
	{
		public var model:MC_Console;
		public var allCommands:Dictionary = new Dictionary();
		
		public static var IsOpen:Boolean;
		
		public function Console()
		{
			model = new MC_Console();
			
			RegisterCommand("Ayuda", Help, "muestra todos los comandos.");
			RegisterCommand("Vedoya", Vedoya, "you feel bold...");
			RegisterCommand("Salud", Salud, "recupera toda la salud.");
			RegisterCommand("Botiquin", Botiquin, "otorga un botiquin.");
			RegisterCommand("Municion", Municion, "otorga el maximo de municion.");
			RegisterCommand("Dorado", Dorado, "otorga municion dorada.");
			RegisterCommand("Bateria", Bateria, "otorga la bateria.");
			RegisterCommand("Vision", Vision, "otorga la vision total del mapa.");
			RegisterCommand("Holocausto", Holocausto, "elimina a todos los dragones del mapa.");
			RegisterCommand("JefeTP", JefeTP, "teletransporta al personaje al area del jefe.");
			RegisterCommand("GodMode", GodMode, "no puede morir y dispara municion mortal.");
			
			Locator.mainStage.addEventListener(KeyboardEvent.KEY_DOWN, EvKeyDown);
		}
		
		public function Help():void
		{
			for each(var cData:CommandData in allCommands)
			{
				Write( cData.CommandName + ": " + cData.Description + "\n" );
			}
		}
		public function Vedoya():void
		{
			Main.achievementController.VEDOYASAMA();
			
			if(Game.character != null)
			{
				if(Game.character.vedoyaMode)
				{
					Game.character.vedoyaMode = false;
				}else if(!Game.character.vedoyaMode)
				{
					Game.character.vedoyaMode = true;
				}
			}
		}
		
		public function Salud():void
		{
			if(Game.character != null)
			{
				Game.character.health = 5;
			}
		}
		
		public function Botiquin():void
		{
			if(Game.character != null)
			{
				Game.character.extraMedicKit = true;
			}
		}
		
		public function Municion():void
		{
			if(Game.character != null)
			{
				Game.character.ammo = 99;
			}
		}
		
		public function Dorado():void
		{
			if(Game.character != null)
			{
				Game.character.goldenWeapon = true;
			}
		}
		
		public function Bateria():void
		{
			if(Game.character != null)
			{
				Game.character.upgradedLight = true;
			}
		}
		
		public function Vision():void
		{
			if(Game.character != null)
			{
				Game.character.allVisible = true;
			}
		}
		
		public function Holocausto():void
		{
			if(Game.character != null)
			{
				Game.enemies.DestroyEnemies();
			}
		}
		
		public function JefeTP():void
		{
			if(Game.character != null)
			{
				Game.character.model.x = 5660;
				Game.character.model.y = 100;
			}
		}
		
		public function GodMode():void
		{
			if(Game.character != null)
			{
				Game.character.godMode = true;
			}
		}
		
		protected function EvKeyDown(event:KeyboardEvent):void
		{
			if(event.keyCode == Keyboard.F8)
			{
				if(!IsOpen)
				{
					Open();
					Main.achievementController.OpenTheConsole();
					Locator.updateManager.Pause();
				}
				else if(IsOpen)
				{
					Close();
					Locator.updateManager.Resume();
				}
			}
			
			else if(IsOpen && event.keyCode == Keyboard.ENTER)
			{
				Execute();
				model.tb_input.text = "";
			}
		}
		
		public function RegisterCommand(Name:String, Command:Function, Description:String):void
		{
			var cData:CommandData = new CommandData();
			cData.Command = Command;
			cData.CommandName = Name;
			cData.Description = Description;
			allCommands[Name] = cData;
		}
		
		public function Execute():void
		{
			var ConsoleText:String = model.tb_input.text;
			var SplittedText:Array = ConsoleText.split(" ");
			var CommandName:String = SplittedText[0];
			var cData:CommandData = allCommands[CommandName];
			
			try
			{
				cData.Command();
			}
			catch(Error1:ArgumentError)
			{
				var MyCommand:Function = cData.Command;
				SplittedText.splice(0, 1);
				
				try
				{
					MyCommand.apply(this, SplittedText);
				}
				catch(SubError1:ArgumentError)
				{
					Write("La cantidad de parametros es invalida...");
				}
			}
			catch(Error2:Error)
			{
				trace("Error" + Error2);
				Write("El comando es inexistente...");
			}
		}
		
		public function Write(Something:String):void
		{
			model.tb_back.text += Something + "\n";
		}
		
		public function Open():void
		{
			IsOpen = true;
			Locator.mainStage.addChild(model);
			Locator.mainStage.focus = model.tb_input;
		}
		
		public function Close():void
		{
			IsOpen = false;
			Locator.mainStage.removeChild(model);
			Locator.mainStage.focus = Locator.mainStage;
			model.tb_input.text = "";
		}
	}
}