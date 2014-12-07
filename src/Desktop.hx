import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.haxepunk.graphics.Image;

import windows.*;

class Desktop extends Scene
{
	static var windows = new Array<Window>();
	
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
	
	public override function begin ()
	{		
		// Wallpaper
		addGraphic(new Image("graphics/LD31-Background.png"));
		
		// TaskBar
		new taskbar.TaskBar(this);
		
		// Windows
		//~ windows = new Array<Window>();
		//~ windows.push( add(new windows.Explorer(new openfl.geom.Rectangle(50,50,300,300),"Desktop")) );
		//~ windows.push( add(new windows.ImageViewer(new openfl.geom.Rectangle(100,100,300,400),"toto")) );
		//~ windows.push( add(new windows.SoundPlayer(new openfl.geom.Rectangle(500,100,300,150),"sound.ogg")) );

		// Desktop links
		add( new Icon("explorer", 20, 20, Explorer.open.bind("Desktop"), "Explorer", 0) );
		add( new Icon("trash", 20, 120, Explorer.open.bind("Trash"), "Trash", 0) );
		add( new Icon("sound", 20, 220, SoundPlayer.open, "Sound player", 0) );
		add( new Icon("image", 20, 340, ImageViewer.open, "Image viewer", 0) );
	}
}
