package windows;

import com.haxepunk.graphics.Graphiclist;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import openfl.geom.Rectangle;

class TextViewer extends Window
{
	static var textFiles:Map<String,String>;
	static function __init__() 
	{ 
		TextViewer.textFiles = new Map<String, String>();
		TextViewer.textFiles[" "] = "";
		TextViewer.textFiles["test.txt"] = "Hello dude!";
	}
	
	public function new(rect:Rectangle,fileName:String)
	{
		this.appName = "Text viewer";
		this.fileName = fileName;
		super(rect);		
	}
	
	public static function open ()
	{
		Desktop.open( new windows.TextViewer(new openfl.geom.Rectangle(500,100,300,150),""));
	}
	
	public static function openFile (fileName=" ")
	{
		Desktop.open(new windows.TextViewer(new openfl.geom.Rectangle(500,100,300,150),fileName));
	}
	
	override public function makeMainFrame()
	{
		var mainFrame = Image.createRect(Std.int(rect.width-4),Std.int(rect.height- 2 -titlebarHeight),0xffffff);
		mainFrame.x = 2;
		mainFrame.y = titlebarHeight;
		cast(graphic,Graphiclist).add(mainFrame);
		
		var text = new Text(TextViewer.textFiles[fileName],mainFrame.x +2, mainFrame.y + 2, mainFrame.width-4,mainFrame.height-2);
		text.color = 0x0;
		cast(graphic,Graphiclist).add(text);
	}
}
