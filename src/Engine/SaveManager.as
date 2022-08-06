package Engine
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	public class SaveManager
	{
		public var characterURL:String = "Dragon Panzer Horror/SaveGames/Character.dat";
		public var leaderboardURL:String = "Dragon Panzer Horror/SaveGames/LeaderBoard.dat";
		public var optionsURL:String = "Dragon Panzer Horror/SaveGames/Options.dat";
		public var achievementsURL:String = "Dragon Panzer Horror/SaveGames/Achievements.dat";
		public var testURL:String = "Dragon Panzer Horror/SaveGames/Test.dat";
		
		public var characterSaver:FileStream;
		public var leaderboarSaver:FileStream;
		public var optionsSaver:FileStream;
		public var achievementsSaver:FileStream;
		public var testSaver:FileStream;
		
		public var characterFile:File;
		public var leaderboarFile:File;
		public var optionsFile:File;
		public var achievementsFile:File;
		public var testFile:File;
		
		public function SaveManager()
		{
			characterFile = File.documentsDirectory.resolvePath(characterURL);
			leaderboarFile = File.documentsDirectory.resolvePath(leaderboardURL);
			optionsFile = File.documentsDirectory.resolvePath(optionsURL);
			achievementsFile = File.documentsDirectory.resolvePath(achievementsURL);
			testFile = File.documentsDirectory.resolvePath(testURL);
		}
		public function SaveObject(object:Object, file:File, saver:FileStream):void
		{
			saver = new FileStream();
			saver.open(file, FileMode.WRITE);
			saver.writeObject(object);
			saver.close();
		}
		public function LoadObject(file:File, saver:FileStream):Object
		{
			saver = new FileStream();
			saver.open(file, FileMode.READ);
			var ObjectLoaded:Object = saver.readObject();
			saver.close();
			return ObjectLoaded;
		}
	}
}