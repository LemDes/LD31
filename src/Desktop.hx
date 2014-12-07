import com.haxepunk.Scene;
import com.haxepunk.graphics.Image;

import windows.Window;

class Desktop extends Scene
{
	static var windows : Array<Window>;
	
	public static function inDrag () : Bool
	{
		for (window in windows)
		{
			if (window.drag != null)
			{
				return true;
			}
		}
		
		return false;
	}
	
	public override function begin ()
	{		
		// Wallpaper
		addGraphic(new Image("graphics/LD31-Background.png"));
		
		// TaskBar
		new taskbar.TaskBar(this);
		
		// Windows
		windows = new Array<Window>();
		windows.push( add(new windows.Explorer(new openfl.geom.Rectangle(50,50,300,300),"Desktop")) );
		//~ windows.push( add(new windows.ImageViewer(new openfl.geom.Rectangle(100,100,300,400),"toto")) );
		//~ windows.push( add(new windows.SoundPlayer(new openfl.geom.Rectangle(500,100,300,150),"sound.ogg")) );
	}
}
