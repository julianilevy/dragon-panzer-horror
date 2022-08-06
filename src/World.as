package
{
	import flash.display.MovieClip;
	
	import Engine.Locator;
	
	public class World
	{
		public var model:MovieClip = Locator.assetsManager.GetMovieClipsByName("MC_World");
		public var hitboxes:Vector.<MovieClip> = new Vector.<MovieClip>();
		public var hitboxesLava:Vector.<MovieClip> = new Vector.<MovieClip>();
		public var hitboxesGround:Vector.<MovieClip> = new Vector.<MovieClip>();
		public var hitboxesLimits:Vector.<MovieClip> = new Vector.<MovieClip>();
		public var hitboxesDragonDir:Vector.<MovieClip> = new Vector.<MovieClip>();
		public var lavaDamage:Number = 1;
		public var gravity:Number = 0.2;
		
		public function World()
		{
			Locator.CurrentBackGround = model;
			GetHitbox();
		}
		
		public function GetHitbox():void
		{
			hitboxes = new Vector.<MovieClip>();
			hitboxesLava = new Vector.<MovieClip>();
			hitboxesGround = new Vector.<MovieClip>();
			hitboxesLimits = new Vector.<MovieClip>();
			hitboxesDragonDir = new Vector.<MovieClip>();
			
			for (var i:int = 0; i < model.hitbox.numChildren; i++)
			{
				hitboxes.push(model.hitbox.getChildAt(i));
			}
			for (var j:int = 0; j < model.hitboxGround.numChildren; j++)
			{
				hitboxesGround.push(model.hitboxGround.getChildAt(j));
			}
			for (var k:int = 0; k < model.hitboxLava.numChildren; k++)
			{
				hitboxesLava.push(model.hitboxLava.getChildAt(k));
			}
			for (var l:int = 0; l < model.hitboxLimits.numChildren; l++)
			{
				hitboxesLimits.push(model.hitboxLimits.getChildAt(l));
			}
			for (var m:int = 0; m < model.hitboxDragonDir.numChildren; m++)
			{
				hitboxesDragonDir.push(model.hitboxDragonDir.getChildAt(m));
			}
		}
		public function Restart():void
		{
			Locator.CurrentBackGround = null;
			
			hitboxes.splice(0, hitboxes.length);
			hitboxesLava.splice(0, hitboxesLava.length);
			hitboxesGround.splice(0, hitboxesGround.length);
			hitboxesLimits.splice(0, hitboxesLimits.length);
			hitboxesDragonDir.splice(0, hitboxesDragonDir.length);
		}
	}
}