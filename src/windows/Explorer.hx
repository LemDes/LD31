package windows;

import com.haxepunk.graphics.Graphiclist;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import com.haxepunk.Graphic;
import com.haxepunk.HXP;

import openfl.geom.Rectangle;

class Explorer extends Window
{
	private var icons:Array<Icon> = [];
	private var fileStructure:Map<String, Array<String>>;
	private var parents:Map<String, String>;
	
	public function new(rect:Rectangle,fileName:String)
	{
		this.appName = "Explorer";
		this.fileName = fileName;
		
		fileStructure = new Map<String, Array<String>>();
		fileStructure["Desktop"] = ["test", "music.ogg"];
		fileStructure["test"] = ["..", "vendetta-warrior.exe", "music.ogg"];
		
		parents = new Map<String, String>();
		parents["test"] = "Desktop";
		
		super(rect);
	}
	
	override public function makeMainFrame()
	{
		var mainFrame = Image.createRect(Std.int(rect.width-4),Std.int(rect.height- 2 -titlebarHeight),0xffffff);
		mainFrame.x = rect.x+2;
		mainFrame.y = rect.y + titlebarHeight;
		cast(graphic,Graphiclist).add(mainFrame);
	}
	
	override public function added()
	{
		super.added();
		addFilesIcon();
	}
	
	private function addFilesIcon()
	{
		var i = 0;
		for (entry in fileStructure.get(fileName))
		{
			var dotPosition = entry.indexOf(".");
			if ( dotPosition == -1 || entry == "..") // a folder
			{
				displayEntry(entry,i,"folder");
			}
			else
			{
				displayEntry(entry,i,"other");
			}
			i++;
		}
	}
	
	private function displayEntry(name:String,pos:Int,type:String)
	{
		var icon = new Icon(type,Std.int(rect.x + (90*Std.int(pos/5))),Std.int(rect.y + titlebarHeight + (140*(pos%5))),function(){open(name,type);}, name, 90);
		icons.push(icon);
		HXP.scene.add(icon);
	}
	
	private function open(name:String,type:String)
	{
		if (type == "folder")
		{
			cleanIcons();
			
			if (name == "..")
			{
				name = parents[fileName];
			}
			fileName = name;
			
			addFilesIcon();
		}
		else
		{
			trace(name);
		}
		
		text.visible = false;
		text.text = appName+" - " + fileName;
		text.color = 0x0;
		text.x = Std.int(bar.x + (rect.width - text.textWidth)/2);
		text.y = Std.int(bar.y+2);
		text.visible = true;
	}
	
	public override function close ()
	{
		cleanIcons();		
		super.close();
	}
	
	function cleanIcons ()
	{
		for (icon in icons)
		{
			HXP.scene.remove(icon);
		}
		
		icons = [];
	}
}