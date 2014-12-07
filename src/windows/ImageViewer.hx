package windows;

import com.haxepunk.graphics.Graphiclist;
import com.haxepunk.graphics.Image;
import openfl.geom.Rectangle;

class ImageViewer extends Window
{
	public static function open ()
	{
		Desktop.open( new windows.ImageViewer(new openfl.geom.Rectangle(100,100,404,330), "coffee_beans2.jpg") );
	}
	
	public function new(rect:Rectangle,fileName:String)
	{
		this.appName = "Image viewer";
		this.fileName = fileName;
		super(rect);
	}
	
	override public function makeMainFrame()
	{
		var mainFrame = new Image('graphics/'+fileName);
		mainFrame.x = 2;
		mainFrame.y = titlebarHeight;
		cast(graphic,Graphiclist).add(mainFrame);
	}
}
