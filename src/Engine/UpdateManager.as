package Engine
{
	import flash.events.Event;

	public class UpdateManager
	{
		public var updateables:Vector.<Function> = new Vector.<Function>();
		public var paused:Boolean;
		
		public function UpdateManager()
		{
			Locator.mainStage.addEventListener(Event.ENTER_FRAME, EvUpdate);
		}
		
		protected function EvUpdate(event:Event):void
		{
			if(!paused)
			{
				for(var i:int = 0; i < updateables.length; i ++)
				{
					updateables[i]();
				}
			}
		}
		
		public function AddCallback(Callback:Function):void
		{
			updateables.push(Callback);
		}
		
		public function RemoveCallback(Callback:Function):void
		{
			var Index:int = updateables.indexOf(Callback);
			
			if(Index != -1)
			{
				updateables.splice(Index, 1);
			}
		}
		
		public function Pause():void
		{
			paused = true;
		}
		
		public function Resume():void
		{
			paused = false;
		}
	}
}