package Engine
{
	import flash.events.KeyboardEvent;
	import flash.utils.Dictionary;
	
	public class InputManager
	{
		public var allKeys:Array = new Array();
		public var allKeysByName:Dictionary = new Dictionary();
		
		public function InputManager()
		{
			Locator.mainStage.addEventListener(KeyboardEvent.KEY_UP, EvKeyUp);
			Locator.mainStage.addEventListener(KeyboardEvent.KEY_DOWN, EvKeyDown);
		}
		
		public function SetRelation(name:String, code:int):void
		{
			var k:Key = allKeys[code];
			
			if(k == null)
			{
				k = new Key();
				allKeys[ code ] = k;
			}
			
			allKeysByName[name] = k;
		}
		public function RemoveRelation(name:String, code:int):void
		{
			var k:Key = allKeys[code];
			
			if(k != null)
			{
				allKeys[ code ] = null;	
			}
			
			allKeysByName[ name ] = null;
		}
		protected function EvKeyDown(event:KeyboardEvent):void
		{
			var k:Key = allKeys[ event.keyCode ];
			
			if(k == null)
			{
				k = new Key();
				allKeys[ event.keyCode ] = k;
			}
			
			if(!k.keyPress)
			{
				k.Press();
			}
		}
		
		protected function EvKeyUp(event:KeyboardEvent):void
		{
			var k:Key = allKeys[ event.keyCode ];
			
			if(k == null)
			{
				k = new Key();
				allKeys[ event.keyCode ] = k;
			}
			
			k.Release();
		}
		
		public function IsKeyPressedByName(name:String):Boolean
		{
			return allKeysByName[ name ] != null ? allKeysByName[ name ].keyPress : false;
		}
	}
}