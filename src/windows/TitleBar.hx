package windows;

import com.haxepunk.graphics.Graphiclist;
import com.haxepunk.graphics.Image;

class TitleBar extends Graphiclist
{
	private var appName:String;
	private var fileName:String;
	public var height(default,null):Int = 20;
	
	public function new(appName:String,fileName:String)
	{
		this.appName = appName;
		this.fileName = fileName;
		super();
		add(Image.createRect(50,height,0x0000ff));
	}
}
