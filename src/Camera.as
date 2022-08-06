package 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import Engine.Locator;
	
	public class Camera
	{
		public var view:Sprite = new Sprite();
		public var target:MovieClip;
		public var zoom:Number = 3;
		
		private var _backGroundWidth:Number;
		private var _backGroundHeight:Number;
		private var _fixHeightUp:Number = 140;
		private var _fixHeightDown:Number = 376;
		
		public function Camera()
		{
			Locator.updateManager.AddCallback(Update);
		}
		
		public function EnableCamara():void
		{
			Locator.View.visible = true;
		}
		public function DisableCamera():void
		{
			Locator.View.visible = false;
		}
		public function RenderInCamera(BackGround:MovieClip):void
		{
			Locator.ConteinerCurrentBackGround.addChild(BackGround);
			_backGroundWidth = BackGround.width;
			_backGroundHeight = BackGround.height + _fixHeightUp;
		}
		public function RenderOutCamera(BackGround:MovieClip):void
		{
			if(Locator.ConteinerCurrentBackGround.contains(BackGround))
			{
				Locator.ConteinerCurrentBackGround.removeChild(BackGround);
			}
		}
		public function SetTarget(MyTarget:MovieClip):void
		{
			target = MyTarget;
		}
		public function Update():void
		{
			LookAt();
			Locator.View.scaleX = Locator.View.scaleY = zoom;
		}
		public function LookAt():void
		{
			if(target.x <= Locator.mainStage.stage.stageWidth/ (zoom * 2))
			{
				Locator.View.x = 0 ;
			}
			else if(target.x >= _backGroundWidth - Locator.mainStage.stage.stageWidth / (zoom * 2))
			{
			}
			else
			{
				Locator.View.x = -target.x * zoom + Locator.mainStage.stageWidth/2;
			}
			if(target.y <= - _backGroundHeight/2 + Locator.mainStage.stage.stageHeight / (zoom * 2))
			{
			}
			else if(target.y >= (_backGroundHeight - _fixHeightDown) - Locator.mainStage.stage.stageWidth / (zoom * 2))
			{
			}
			else
			{
				Locator.View.y = -target.y * zoom - Locator.mainStage.stageHeight / zoom;
			}
		}
		public function Restart():void
		{
			Locator.updateManager.RemoveCallback(Update);
			
			target = null;
		}
	}
}