package Engine
{
	public class Key
	{
		public var keyPress:Boolean;
		
		public function Key()
		{
		}
		
		public function Press():void
		{
			keyPress = true;
		}
		
		public function Release():void
		{
			keyPress = false;
		}
	}
}