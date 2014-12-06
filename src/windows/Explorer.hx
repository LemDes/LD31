package windows;

import com.haxepunk.graphics.Graphiclist;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import com.haxepunk.Graphic;
import com.haxepunk.HXP;

import haxe.ds.StringMap;

import openfl.geom.Rectangle;

class Explorer extends Window
{
	private var icons:Array<Icon> = [];
	private var fileStructure:StringMap<Array<String>>;
	
	public function new(rect:Rectangle,fileName:String)
	{
		this.appName = "Explorer";
		this.fileName = fileName;
		fileStructure = new StringMap<Array<String>>();
		fileStructure.set("desktop",["test", "music.ogg"]);
		fileStructure.set("test",["vendetta-warrior.exe", "music.ogg"]);
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
			if ( dotPosition == -1) // a folder
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
		var icon = new Icon(type,Std.int(rect.x + (90*Std.int(pos/5))),Std.int(rect.y + titlebarHeight + (90*(pos%5))),function(){open(name,type);});
		icons.push(icon);
		HXP.scene.add(icon);
	}
	
	private function open(name:String,type:String)
	{
		if (type == "folder")
		{
			trace("hey");
			for (i in icons)
			{
				HXP.scene.remove(i);
			}
			icons = [];
			
			fileName = name;
			addFilesIcon();
		}
		else
		{
			trace(name);
		}
		
		text.visible = false;
		text.text =appName+" - " + fileName;
		text.color = 0x0;
		text.x = bar.x + (rect.width - new Text(appName+" - " + fileName, height=titlebarHeight-10).width)/2;
		text.y = bar.y+2;
		text.visible = true;
	}
}
