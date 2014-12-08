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
		fileStructure["Trash"] = ["..","vendetta-warrior.exe"];
		fileStructure["Home"] = ["seasonal","stuff","work","vendetta-warrior.exe"];
		fileStructure["work"] = ["..","LD31","vendetta-warrior.exe"];
		fileStructure["stuff"] = ["..","vendetta-warrior.exe"];
		fileStructure["seasonal"] = ["..","autumn","spring","summer","winter","vendetta-warrior.exe"];
		fileStructure["autumn"] = ["..","vendetta-warrior.exe"];
		fileStructure["spring"] = ["..","vendetta-warrior.exe"];
		fileStructure["summer"] = ["..","vendetta-warrior.exe"];
		fileStructure["winter"] = ["..","normal folder","secret folder","vendetta-warrior.exe"];
		fileStructure["normal folder"] = ["..","perpetuator.png","vendetta-warrior.exe","cancel-vendetta.exe"];
		fileStructure["secret folder"] = ["..","vendetta-warrior.exe"];
		
		
		fileStructure["test"] = ["..", "vendetta-warrior.exe", "music.ogg","test.txt"];
		
		parents = new Map<String, String>();
		parents["work"] = "Home";
		parents["stuff"] = "Home";
		parents["seasonal"] = "Home";
		parents["spring"] = "seasonal";
		parents["winter"] = "seasonal";
		parents["autumn"] = "seasonal";
		parents["summer"] = "seasonal";
		parents["normal folder"] = "winter";
		parents["secret folder"] = "winter";
		parents["Trash"] = "Home";
		
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
	
	override function clicked (mx:Float, my:Float) : Bool
	{
		var b = super.clicked(mx, my);
		
		for (icon in icons)
		{
			b = b || HXP.scene.collidePoint("icon", mx, my) == icon;
		}
		
		return b;
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
		var r = 3;
		var icon = new Icon(type,Std.int(10 +x + (120*Std.int(pos/r))),Std.int(10 + y + titlebarHeight + (140*(pos%r))),function(){openName(name,type);}, name, 90);
		icon.layer = layer;
		icons.push(icon);
		HXP.scene.add(icon);
	}
	
	private function openName(name:String,type:String)
	{
		if (type == "folder")
		{
			if (name != "LD31")
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
			{}
		}
		else
		{
			if (type == "ogg")
			{
				SoundPlayer.openFile(name);
			}
			else if (type == "png" || type == "jpg")
			{
				ImageViewer.openFile(name);
			}
			else if (type == "txt")
			{
				TextViewer.openFile(name);
			}
			else if (type == "exe")
			{
				if (name == "cancel-vendetta.exe")
				{
					Desktop.vendettaActive = false;
					for (i in fileStructure)
					{
						i.remove("vendetta-warrior.exe");
					}
					fileStructure[fileName].remove("cancel-vendetta.exe");
					cleanIcons();
					addFilesIcon();
				}
				else
				{
					switch (fileName)
					{
						case "Home":
							SoundPlayer.openFile("enigma1.ogg");
						case "winter":
							TextViewer.openFile("caesar_cipher.txt");
						default:
							SoundPlayer.openFile("enigma1.ogg");
					}
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
			icon.layer = Desktop.minLayer - 1;
		}
	}
}
