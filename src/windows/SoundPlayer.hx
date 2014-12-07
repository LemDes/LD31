package windows;

import com.haxepunk.HXP;
import com.haxepunk.Sfx;
import com.haxepunk.graphics.Graphiclist;
import com.haxepunk.graphics.Image;
import openfl.geom.Rectangle;

class SoundPlayer extends Window
{
	
	public var sound:Sfx;
	
	public var paused:Bool = false;
	public var playing:Bool = false;
	
	private var playIcon:Icon;
	private var pauseIcon:Icon;
	
	public static function open ()
	{
		Desktop.open( new windows.SoundPlayer(new openfl.geom.Rectangle(500,100,300,150),"sound.ogg"));
	}
	
	public static function openFile (fileName="sound.ogg")
	{
		var sp =  new windows.SoundPlayer(new openfl.geom.Rectangle(500,100,300,150),fileName);
		Desktop.open( sp );
		sp.play();
	}
	
	public function new(rect:Rectangle,fileName:String)
	{
		this.appName = "Sound player";
		this.fileName = fileName;
		super(rect);		
		sound = new Sfx("audio/"+fileName);
	}
	
	override public function added()
	{
		super.added();
		playIcon = new Icon("close", Std.int(rect.x + 10), Std.int(rect.y) +titlebarHeight + 10, play);
		pauseIcon = new Icon("close", Std.int(rect.x + 30), Std.int(rect.y) +titlebarHeight + 10, stop);
		HXP.scene.add(playIcon);
		HXP.scene.add(pauseIcon);
		
	}
	
	public function play()
	{
		if (!playing)
		{
			sound.play();
			playing = true;
		}
		else
		{
			if (paused)
				resume();
			else
				pause();
		}
	}
	
	override function makeDrag ()
	{
		super.makeDrag();
		
		addDelta(playIcon, delta.x, delta.y);
		addDelta(pauseIcon, delta.x, delta.y);
	}
	
	public function pause()
	{
		sound.stop();
		playing = true;
		paused = true;
	}
	
	public function stop()
	{
		sound.stop();
		playing = false;
		paused = false;
	}
	
	public function resume()
	{
		sound.resume();
		paused = false;
	}
	
	override public function close()
	{
		sound.stop();
		sound = null;
		HXP.scene.remove(playIcon);
		HXP.scene.remove(pauseIcon);
		super.close();
	}
}
