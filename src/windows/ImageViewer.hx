package windows;

import com.haxepunk.graphics.Graphiclist;
import com.haxepunk.graphics.Image;
import openfl.geom.Rectangle;

class ImageViewer extends Window
{
	public static function open ()
	{
		Desktop.open( new windows.ImageViewer(new openfl.geom.Rectangle(100,100,300,400), "toto") );
	}
	
	public function new(rect:Rectangle,fileName:String)
	{
		this.appName = "Image viewer";
		this.fileName = fileName;
		super(rect);
	}
	
	override public function makeMainFrame()
	{
		var mainFrame = Image.createRect(Std.int(rect.width-4),Std.int(rect.height- 2 -titlebarHeight),0x0ff00);
		mainFrame.x = 2;
		mainFrame.y = titlebarHeight;
		cast(graphic,Graphiclist).add(mainFrame);
	}
}
