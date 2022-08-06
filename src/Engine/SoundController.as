package Engine
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	public class SoundController
	{
		public var musicAndSound:Sound;
		public var configuration:SoundTransform;
		public var channel:SoundChannel;
		public var currentPosition:int;
		public var playing:Boolean;
		
		public function SoundController(MusicAndSound:Sound)
		{
			this.musicAndSound = MusicAndSound;
			configuration = new SoundTransform();
		}
		public function Play(Volume:Number, Loops:int):void
		{
			configuration.volume = Volume;
			channel = musicAndSound.play(0, Loops, configuration);
			playing = true;
		}
		public function Stop():void
		{
			currentPosition = channel.position;
			channel.stop();
			playing = false;
		}
		public function Resume():void
		{
			channel = musicAndSound.play(currentPosition, 0, configuration);
			playing = true;
		}
		public function Remove():void
		{
			channel.stop();
			musicAndSound = null;
			playing = false;
		}
		public function Volume(volume:Number):void
		{
			configuration.volume = volume;
			channel.soundTransform = configuration;
		}
	}
}