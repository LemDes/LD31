package windows;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.Sfx;
import com.haxepunk.graphics.Graphiclist;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import openfl.geom.Rectangle;

class SoundPlayer extends Window
{
	public var sound:Sfx;
	
	public var paused:Bool = false;
	public var playing:Bool = false;
	
	private var playIcon:Icon;
	private var pauseIcon:Icon;
	
	var icons : Array<Image>;
	var timeText : Entity;
	var timeLength : String;
	
	public static function open ()
	{
		Desktop.open( new windows.SoundPlayer(new openfl.geom.Rectangle(500,100,300,80),""));
	}
	
	public static function openFile (fileName="")
	{
		var sp =  new windows.SoundPlayer(new openfl.geom.Rectangle(500,100,300,80),fileName);
		Desktop.open( sp );
		sp.play();
	}
	
	public function new(rect:Rectangle,fileName:String)
	{
		this.appName = "Sound player";
		this.fileName = fileName;
		super(rect);
		
		if (fileName != "")	
		{
			#if flash
			var f = StringTools.replace(fileName, ".ogg", ".mp3");
			#else
			var f = fileName;
			#end			
			sound = new Sfx("audio/"+f);
		}
		
		playIcon = new Icon("play", Std.int(x + 27), Std.int(y) +titlebarHeight + 10, play);
		pauseIcon = new Icon("stop", Std.int(x + 71), Std.int(y) +titlebarHeight + 10, stop);
		
		icons = new Array<Image>();
		icons.push(playIcon.img_normal);
		icons.push(playIcon.img_hover);
		icons.push(new Image("graphics/icons/pause.png"));
		icons.push(new Image("graphics/icons/pause_hover.png"));
	}
	
	override public function added()
	{
		super.added();
		
		
		var t = new Text("00:00 / 00:00", {color: 0});
		
		HXP.scene.add(playIcon);
		HXP.scene.add(pauseIcon);
		timeText = HXP.scene.addGraphic(t, Desktop.minLayer, x + 155, Std.int(y) +titlebarHeight + 14);
		
		if (sound != null)
			timeLength = DateTools.format(Date.fromTime(DateTools.seconds(sound.length) - DateTools.hours(1)), "%M:%S");
		else
			timeLength = "00:00";
	}
	
	override public function update ()
	{
		super.update();
		
		if (sound == null)
			return;
			
		var pos = playing ? DateTools.format(Date.fromTime(DateTools.seconds(sound.position) - DateTools.hours(1)), "%M:%S") : "00:00";
		cast(timeText.graphic, Text).text = '$pos / $timeLength';
	}
	
	public function play()
	{
		if (sound == null)
			return;
		
		if (!playing)
		{
			sound.play();
			playing = true;
			playIcon.img_normal = icons[2];
			playIcon.img_hover = icons[3];
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
		addDelta(timeText, delta.x, delta.y);
	}
	
	public override function bringToFront ()
	{
		super.bringToFront();
		
		playIcon.layer = Desktop.minLayer - 1;
		pauseIcon.layer = Desktop.minLayer - 1;
		timeText.layer = Desktop.minLayer - 1;
	}
	
	public function pause()
	{
		if (sound == null)
			return;
		
		sound.stop();
		playing = true;
		paused = true;
		playIcon.img_normal = icons[0];
		playIcon.img_hover = icons[1];
	}
	
	public function stop()
	{
		if (sound == null)
			return;
		
		sound.stop();
		playing = false;
		paused = false;
		playIcon.img_normal = icons[0];
		playIcon.img_hover = icons[1];
	}
	
	public function resume()
	{
		if (sound == null)
			return;
		
		sound.resume();
		paused = false;
		playIcon.img_normal = icons[2];
		playIcon.img_hover = icons[3];
	}
	
	override public function close()
	{
		if (sound != null)
		{
			sound.stop();
			sound = null;
		}
		
		HXP.scene.remove(playIcon);
		HXP.scene.remove(pauseIcon);
		HXP.scene.remove(timeText);
		super.close();
	}
	
	override public function show()
	{
		super.show();
		
		timeText.visible = playIcon.visible = pauseIcon.visible = true;
	}
	
	override public function hide()
	{
		super.hide();
		
		timeText.visible = playIcon.visible = pauseIcon.visible = false;
	}
}
