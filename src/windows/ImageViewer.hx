package windows;

import com.haxepunk.graphics.Graphiclist;
import com.haxepunk.graphics.Image;
import openfl.geom.Rectangle;

class ImageViewer extends Window
{
	public function new(rect:Rectangle,fileName:String)
	{
		this.appName = "Image viewer";
		this.fileName = fileName;
		super(rect);
	}
	
	override public function makeMainFrame()
	{
		var mainFrame = Image.createRect(Std.int(rect.width),Std.int(rect.height),0x0ff00);
		mainFrame.x = rect.x;
		mainFrame.y = rect.y + bar.height;
		cast(graphic,Graphiclist).add(mainFrame);
	}
}
