package
{
	import flash.ui.Keyboard;
	
	import Engine.Locator;
	
	public class UserController
	{
		public function UserController()
		{
			Locator.inputManager.SetRelation("Move Right", Keyboard.D);
			Locator.inputManager.SetRelation("Move Left", Keyboard.A);
			Locator.inputManager.SetRelation("Jump", Keyboard.W);
			Locator.inputManager.SetRelation("Heal", Keyboard.R);
			Locator.inputManager.SetRelation("Shoot", Keyboard.SPACE);
			Locator.updateManager.AddCallback(Update);
		}
		
		public function Update():void
		{
			if(Locator.inputManager.IsKeyPressedByName("Move Right")) Game.character.Move(1);
			else if(Locator.inputManager.IsKeyPressedByName("Move Left")) Game.character.Move(-1);
			if(Locator.inputManager.IsKeyPressedByName("Jump")) Game.character.Jump();
			if(Locator.inputManager.IsKeyPressedByName("Heal")) Game.character.Heal();
			if(Locator.inputManager.IsKeyPressedByName("Shoot")) Game.character.Shoot();
		}
		public function Restart():void
		{
			Locator.inputManager.RemoveRelation("Move Right", Keyboard.D);
			Locator.inputManager.RemoveRelation("Move Left", Keyboard.A);
			Locator.inputManager.RemoveRelation("Jump", Keyboard.W);
			Locator.inputManager.RemoveRelation("Heal", Keyboard.R);
			Locator.inputManager.RemoveRelation("Shoot", Keyboard.SPACE);
			Locator.updateManager.RemoveCallback(Update);
		}
	}
}