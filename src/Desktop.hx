import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.haxepunk.graphics.Image;

import windows.*;

class Desktop extends Scene
{
	public static var windows = new Array<Window>();
	
	public static var minLayer : Int = 15000;
	
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
	
	public static function open (window:Window)
	{
		windows.push( HXP.scene.add( window ) );
	}
	
	public static function close (window:Window)
	{
		windows = windows.filter(function (w) return w != window);
	}
	
	public override function begin ()
	{		
		// Wallpaper
		addGraphic(new Image("graphics/LD31-Background.png"), 20000);
		
		// TaskBar
		new taskbar.TaskBar(this);

		// Desktop links
		add( new Icon("explorer", 20, 20, Explorer.open.bind("Desktop"), "Explorer", 0) );
		add( new Icon("trash", 20, 120, Explorer.open.bind("Trash"), "Trash", 0) );
		add( new Icon("sound", 20, 220, SoundPlayer.open, "Sound player", 0) );
		add( new Icon("image", 20, 340, ImageViewer.open, "Image viewer", 0) );
	}
}
