package windows;

import com.haxepunk.graphics.Graphiclist;
import com.haxepunk.graphics.Image;
import openfl.geom.Rectangle;

class ImageViewer extends Window
{
	public static function open ()
	{
		Desktop.open( new windows.ImageViewer(new openfl.geom.Rectangle(100,100,404,330), "") );
	}
	public static function openFile (fileName:String)
	{
		Desktop.open( new windows.ImageViewer(new openfl.geom.Rectangle(100,100,404,330), fileName) );
	}
	
	public function new(rect:Rectangle,fileName:String)
	{
		this.appName = "Image viewer";
		this.fileName = fileName;
		super(rect);
	}
	
	override public function makeMainFrame()
	{
		var mainFrame : Image;
		
		if (fileName == "")
		{
			mainFrame = Image.createRect(400, 300, 0xFFFFFF);
		}
		else
		{
			mainFrame = new Image('graphics/'+fileName);
		}
		
		mainFrame.x = 2;
		mainFrame.y = titlebarHeight;
		cast(graphic,Graphiclist).add(mainFrame);
	}
}
