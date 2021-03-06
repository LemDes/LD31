package windows;

import com.haxepunk.graphics.Graphiclist;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import openfl.geom.Rectangle;

class Popup extends Window
{
	
	static var textFiles:Map<String,String>;
	static function __init__() 
	{ 
		Popup.textFiles = new Map<String, String>();
		Popup.textFiles[""] = "";
		Popup.textFiles["onStart"] = "You finished your game for the LD 31. There's only 10min left so don't forget to submit it!";
		Popup.textFiles["onSubmitWithVendetta"] = "Error file in use:\n\"I wont let you publish your shitty LD game. Try to find me and stop me if you dare!\"";
		Popup.textFiles["failed"] = "Too late to submit :(\nIt seems the evil perpetrator won and you lose.";
		Popup.textFiles["victory"] = "You submited your game, time to start voting.\n\nCongratulation you've won MetaLD! :)";
	}
	
	private var t="";
	public var okIcon:Icon;
	
	public static function open()
	{
		Desktop.open( new windows.Popup(new openfl.geom.Rectangle(500,100,350,150),""));
	}
	
	public static function openFile(text:String,?fileName:String=null)
	{
		Desktop.open( new windows.Popup(new openfl.geom.Rectangle(500,100,350,150),text,fileName) );
	}
	
	public function new(rect:Rectangle,text:String,?fileName:String=null)
	{
		this.appName = fileName != null ? "Popup" : "Error";
		this.t = text;
		this.fileName=fileName;
		super(rect);
	}
	
	public override function added ()
	{
		closeIcon = new Icon("close", Std.int(x+rect.width-20), Std.int(y+4), function () close());
		okIcon = new Icon("ok", Std.int(x+(rect.width/2)-41), Std.int(y+rect.height-50), function () close());
		HXP.scene.add(closeIcon);
		HXP.scene.add(okIcon);
	}
	
	override public function makeMainFrame()
	{
		var text = new Text(Popup.textFiles[t],4,titlebarHeight+2, Std.int(rect.width-4),0,{wordWrap:true,align:flash.text.TextFormatAlign.CENTER,color:0x0});
		text.y = text.y + Std.int(((rect.height-70-titlebarHeight)-text.textHeight));
		cast(graphic,Graphiclist).add(text);
	}
	
	override public function close()
	{
		Desktop.close(this);
		
		HXP.scene.remove(okIcon);
		HXP.scene.remove(closeIcon);
		HXP.scene.remove(this);
	}
	
	override public function bringToFront()
	{
		layer = Desktop.minLayer - 1;
		closeIcon.layer = Desktop.minLayer - 1;
		okIcon.layer = Desktop.minLayer - 1;
		
		Desktop.minLayer -= 1;
	}
	
	override function makeDrag ()
	{
		addDelta(this, delta.x, delta.y);			
		addDelta(closeIcon, delta.x, delta.y);		
		addDelta(okIcon, delta.x, delta.y);		
	}
	
	override public function show()
	{
		closeIcon.visible = okIcon.visible = visible = true;
	}
	
	override public function hide()
	{
		closeIcon.visible = okIcon.visible = visible = false;
	}
	public override function update ()
	{
		super.update();
		
		var mx : Float = Input.mouseX;
		var my : Float = Input.mouseY;
		
		if (Input.mousePressed && clicked(mx, my))
		{
			Desktop.bringWinToFront(this);
			
			if (x <= mx && mx <= x + width - 45 && y <= my && my <= y + height - 20)
			{
				drag = { x: mx, y: my };
			}
		}
		
		if (Input.mouseReleased)
		{
			drag = null;
		}
		
		if (drag != null)
		{
			my = Math.min(my, 514-titlebarHeight);
			delta = { x: mx - drag.x, y: my - drag.y };
			drag = { x: mx, y: my };
		
			makeDrag();
		}
	}
}
