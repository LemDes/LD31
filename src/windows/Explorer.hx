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
	
	public static function open (folder:String)
	{
		Desktop.open(new Explorer(new openfl.geom.Rectangle(80,25,800,450), folder));
	}
	
	public function new(rect:Rectangle,fileName:String)
	{
		this.appName = "Explorer";
		this.fileName = fileName;
		
		fileStructure = new Map<String, Array<String>>();
		fileStructure["Desktop"] = ["test", "sound.ogg","vendetta-warrior.exe"];
		fileStructure["Trash"] = ["..","vendetta-warrior.exe"];
		fileStructure["test"] = ["..", "vendetta-warrior.exe", "music.ogg"];
		
		parents = new Map<String, String>();
		parents["test"] = "Desktop";
		parents["Trash"] = "Desktop";
		
		super(rect);
	}
	
	override public function makeMainFrame()
	{
		var mainFrame = Image.createRect(Std.int(rect.width-4),Std.int(rect.height- 2 -titlebarHeight),0xffffff);
		mainFrame.x = 2;
		mainFrame.y = titlebarHeight;
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
				displayEntry(entry,i,entry.substr(dotPosition+1));
			}
			i++;
		}
	}
	
	private function displayEntry(name:String,pos:Int,type:String)
	{
		var r = 2;
		var icon = new Icon(type,Std.int(x + (120*Std.int(pos/r))),Std.int(y + titlebarHeight + (140*(pos%r))),function(){openName(name,type);}, name, 90);
		icons.push(icon);
		HXP.scene.add(icon);
	}
	
	private function openName(name:String,type:String)
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
			if (type == "ogg")
			{
				SoundPlayer.openFile(name);
			}
			if (type == "exe")
			{
				switch (fileName)
				{
					case "Desktop":
						SoundPlayer.openFile("enigma1.ogg");
				}
			}
		}
		
		text.visible = false;
		text.text = appName+" - " + fileName;
		text.color = 0x0;
		text.x = Std.int(bar.x + (rect.width - text.textWidth)/2);
		text.y = Std.int(bar.y+2);
		text.visible = true;
	}
	
	override function makeDrag ()
	{
		super.makeDrag();
		
		for (icon in icons)
		{
			addDelta(icon, delta.x, delta.y);
		}
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
	
	override public function show()
	{
		super.show();
		
		for (i in icons)
		{
			i.visible = true;
		}
	}
	
	override public function hide()
	{
		super.hide();
		
		for (i in icons)
		{
			i.visible = false;
		}
	}
	
	public override function bringToFront ()
	{
		super.bringToFront();
		
		for (icon in icons)
		{
			HXP.scene.sendToBack(icon);
		}
	}
}
