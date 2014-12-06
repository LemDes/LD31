package windows;

import com.haxepunk.Sfx;
import com.haxepunk.graphics.Graphiclist;
import com.haxepunk.graphics.Image;
import openfl.geom.Rectangle;

class SoundPlayer extends Window
{
	
	public var sound:Sfx;
	
	public function new(rect:Rectangle,fileName:String)
	{
		this.appName = "Sound player";
		this.fileName = fileName;
		super(rect);		
		sound = new Sfx(fileName);
		play();
	}
	
	public function play()
	{
		sound.play();
	}
	
	public function stop()
	{
		sound.stop();
	}
	
	public function resume()
	{
		sound.resume();
	}
}
