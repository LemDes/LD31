package windows;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Graphiclist;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;

import openfl.geom.Rectangle;

class Window extends Entity
{
	public var appName(default,null):String;
	public var fileName:String;
	public var rect(default,null):Rectangle;
	
	public var bar:Image;
	public var text:Text;
	
	public var titlebarHeight(default,null):Int = 27;
	private var reduceIcon:Icon;
	private var closeIcon:Icon;
	
	
	public function new(rect:Rectangle)
	{
		super();
		this.rect = rect;
		graphic = new Graphiclist();
		makeTitleBar();		
		makeMainFrame();
	}
	
	public override function added ()
	{
		closeIcon = new Icon("close", Std.int(rect.x+rect.width-20), Std.int(rect.y+4), function () close());
		reduceIcon = new Icon("reduce", Std.int(rect.x+rect.width-45), Std.int(rect.y+4), function () hide());
		HXP.scene.add(closeIcon);
		HXP.scene.add(reduceIcon);
	}
	
	public function makeTitleBar()
	{		
		bar = Image.createRect(Std.int(rect.width),Std.int(rect.height),0xDDDAD8);
		bar.x = rect.x;
		bar.y = rect.y;
		cast(graphic,Graphiclist).add(bar);
		
		var appText = appName;
		if (fileName != null && fileName != "")
			appText += " - " + fileName;
		text = new Text(appText, height=titlebarHeight-10);
		text.color = 0x0;
		text.x = Std.int(bar.x + (rect.width - text.width)/2);
		text.y = Std.int(bar.y+2);
		cast(graphic,Graphiclist).add(text);
		
	}
	
	public function makeMainFrame()
	{
	}
	
	public function close()
	{
		HXP.scene.remove(closeIcon);
		HXP.scene.remove(reduceIcon);
		HXP.scene.remove(this);
	}
	
	public function show()
	{
		closeIcon.visible = reduceIcon.visible = visible = true;
	}
	
	public function hide()
	{
		closeIcon.visible = reduceIcon.visible = visible = false;
	}
}
