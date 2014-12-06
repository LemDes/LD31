package windows;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Graphiclist;

import openfl.geom.Rectangle;

class Window extends Entity
{
	private var titleBar:TitleBar;
	public var appName(default,null):String;
	public var fileName:String;
	public var rect(default,null):Rectangle;
	
	public function new(rect:Rectangle)
	{
		super();
		this.rect = rect;
		titleBar = new TitleBar(appName,fileName);
		graphic = new Graphiclist();
		addTitleBar(titleBar);		
	}
	
	public function addTitleBar(titleBar:TitleBar)
	{
		titleBar.x = rect.x;
		titleBar.y = rect.y;
		cast(graphic,Graphiclist).add(titleBar);
	}
	
	public function addMainFrame(mainFrame:Graphic)
	{
		mainFrame.x = rect.x;
		mainFrame.y = rect.y + titleBar.height;
		cast(graphic,Graphiclist).add(mainFrame);
	}
}
