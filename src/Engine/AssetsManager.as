package Engine
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.media.Sound;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	public class AssetsManager extends EventDispatcher
	{
		public var urlLinksLoader:URLLoader;
		public var taskList:Array = new Array();
		public var allAssets:Dictionary;
		public var allAssetsNames:Array = new Array();
		public var preload:MC_Preload = new MC_Preload();
		public var assetsTotal:int;
		public var assetsLoaded:int;
		
		public function AssetsManager()
		{
			
		}
		
		public function LoadLinks(urlLinks:String):void
		{
			allAssets = new Dictionary();
			urlLinksLoader = new URLLoader();
			
			urlLinksLoader.dataFormat = URLLoaderDataFormat.VARIABLES;
			
			var url:URLRequest = new URLRequest( urlLinks );
			urlLinksLoader.addEventListener(Event.COMPLETE, EvUrlWithLinksForLoadComplete);
			urlLinksLoader.load(url);
			
			Locator.mainStage.addChild(preload);
			preload.mc_assetsloaded.gotoAndStop(1);
		}
		
		public function LoadAsset(urlAsset:String, assetName:String):void
		{
			var fileType:String = urlAsset.split("/")[0];
			urlAsset = "engine/" + urlAsset;
			switch(fileType)
			{
				case "images":
				case "swfs":
					var imageLoader:Loader = new Loader();
					imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, EvAssetComplete);
					imageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, EvIOErrorAsset);
					imageLoader.load( new URLRequest( urlAsset ) );
					allAssets[assetName] = imageLoader;
					break;
				
				case "sounds":
					var soundLoader:Sound = new Sound();
					soundLoader.addEventListener(Event.COMPLETE, EvAssetComplete);
					soundLoader.addEventListener(IOErrorEvent.IO_ERROR, EvIOErrorAsset);
					soundLoader.load( new URLRequest( urlAsset ) );
					allAssets[assetName] = soundLoader;
					break;
			}
		}
		
		protected function EvIOErrorAsset(event:IOErrorEvent):void
		{
			Locator.console.Write("No se encuentra lo que estás intentando cargar...");
		}
		
		public function GetImageByName(name:String):Bitmap
		{
			var img:Loader = allAssets[name];
			
			if(img != null)
			{
				var myBitmap:Bitmap = new Bitmap();
				var myBitmapData:BitmapData = new BitmapData(img.width, img.height, true);
				
				myBitmapData.draw(img);
				myBitmap.bitmapData = myBitmapData;
				
				return myBitmap;
			}else
			{
				return null;
			}
		}
		
		public function GetSoundByName(name:String):Sound
		{
			var snd:Sound = allAssets[name];
			if(snd != null)
			{
				return snd;
			}else{
				return null;
			}
		}
		
		public function GetMovieClipsByName(name:String):MovieClip
		{
			for(var varName:String in allAssets)
			{
				if(allAssets[varName] is Loader)
				{
					var myGreatLoader:Loader = allAssets[varName];
					
					try
					{
						var myClass:Class = myGreatLoader.contentLoaderInfo.applicationDomain.getDefinition(name) as Class;
						var myMovieClip:MovieClip = new myClass();
						return myMovieClip;
					}catch(e1:ReferenceError)
					{
					}
				}
			}
			
			return null;
		}
		
		protected function EvAssetComplete(event:Event):void
		{
			if(taskList.length > 0)
			{
				taskList.splice(0, 1);
				allAssetsNames.splice(0, 1);
				assetsLoaded++;
				preload.mc_assetsloaded.gotoAndStop(int(assetsLoaded * 100 / assetsTotal));
				if(taskList.length > 0)
				{
					LoadAsset( taskList[0], allAssetsNames[0] );
				}else
				{
					dispatchEvent( new Event("all_assets_complete") );
					Locator.mainStage.removeChild(preload);
				}
			}
		}
		
		protected function EvUrlWithLinksForLoadComplete(event:Event):void
		{
			var links:Array = new Array();
			for(var varName:String in urlLinksLoader.data)
			{
				var fixedValue:String = escape(urlLinksLoader.data[varName]).split("%0D%0A")[0];
				urlLinksLoader.data[varName] = fixedValue;
				links.push( fixedValue );
				allAssetsNames.push( varName );
			}
			
			assetsTotal = links.length;
			taskList = links;
			LoadAsset( links[0], allAssetsNames[0]);
		}
	}
}