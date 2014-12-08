import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.haxepunk.graphics.Image;

import windows.*;
import taskbar.TaskWindow;

class Desktop extends Scene
{
	public static var vendettaActive = true;
	public static var windows = new Array<Window>();
	public static var taskwindows = new Array<TaskWindow>();
	
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
		HXP.scene.add(window);
		windows = [window].concat(windows);
		taskwindows.push( HXP.scene.add( new TaskWindow(window) ) );
		recalculateTW();
	}
	
	public static function close (window:Window)
	{		
		windows = windows.filter(function (w) return w != window);
		taskwindows = taskwindows.filter(function (tw) { if (tw.window != window) { return true; } else { HXP.scene.remove(tw); return false; } });
		recalculateTW();
		
		if (windows.length == 0)
		{
			minLayer = 15000;
		}
	}
	
	public static function bringWinToFront (window:Window)
	{
		if (windows[0] != window)
		{
			windows = windows.filter(function (w) return w != window);
			windows = [window].concat(windows);
			window.bringToFront();
		}
	}
	
	public static function isInFront (window:Window) : Bool
	{
		for (w in windows)
		{
			if (w.visible)
			{
				return w == window;
			}
		}
		
		return false; // should not happen
	}
	
	public static function hideAll ()
	{
		for (window in windows)
		{
			window.hide();
		}
	}
	
	static function	recalculateTW()
	{
		var tx : Float = 90;
		var twidth : Float = Math.min(200, 760/taskwindows.length);
		
		for (tw in taskwindows)
		{
			tw.x = Std.int(tx);
			tw.width = Std.int(twidth-5);
			
			tx += twidth;
			
			tw.createImg();
		}
	}
	
	public override function begin ()
	{		
		// Wallpaper
		addGraphic(new Image("graphics/LD31-Background.png"), 20000);
		
		
		add( new Icon("submit",680,340,function() 
			{
				if (Desktop.vendettaActive) 
				{
					Popup.openFile("onSubmitWithVendetta");
				}
				else 
				{
					trace("Victory");
				}
			}));
		
		// TaskBar
		new taskbar.TaskBar(this);

		// Desktop links
		add( new Icon("explorer", 20, 20, Explorer.open.bind("Home"), "Explorer", 0) );
		add( new Icon("trash", 20, 120, Explorer.open.bind("Trash"), "Trash", 0) );
		add( new Icon("sound", 20, 220, SoundPlayer.open, "Sound player", 0) );
		add( new Icon("image", 20, 340, ImageViewer.open, "Image viewer", 0) );
		add( new Icon("textviewer", 120, 20, TextViewer.open, "Text viewer", 0) );
		
		Popup.openFile("onStart","Reminder");
	}
}
