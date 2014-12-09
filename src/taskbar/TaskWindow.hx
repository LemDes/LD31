package taskbar;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Graphiclist;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import com.haxepunk.utils.Input;

import windows.Window;

class TaskWindow extends Entity
{
	public var window : Window;
	var gl : Graphiclist;
	var img : Image;
	var text : Text;
	var t : String;
	
	public function new (window:Window)
	{
		super();
		
		width = 1;
		height = 20;
		
		layer = -12;
		type = "all";
		
		x = 0;
		y = 510;
		t = window.appText;
		
		createImg();
		
		this.window = window;
	}
	
	public function createImg()
	{			
		img = Image.createRect(width, height, 0x999999);
		text = new Text(t, 0, 0, width, {color: 0, size: 16, resizable: false});
		graphic = new Graphiclist([img, text]);
	}
	
	public override function update ()
	{
		super.update();
		
		if (window.appText != t)
		{
			t = window.text.text;
			createImg();
		}
		
		var mx = Input.mouseX;
		var my = Input.mouseY;
		
		if (x <= mx && mx <= x + width && y <= my && my <= y + height && !Desktop.inDrag() && HXP.scene.collidePoint("all", mx, my) == this)
		{
			img.color = 0xFFFFFF;
			
			if (Input.mouseReleased)
			{
				if (window.visible)
				{
					if (Desktop.isInFront(window))
					{
						window.hide();
					}
					else
					{
						Desktop.bringWinToFront(window);
					}
				}
				else
				{
					window.show();
					Desktop.bringWinToFront(window);
				}
			}
		}
		else
		{
			if (Desktop.isInFront(window))
				img.color = 0xFFFFFF;
			else
				img.color = 0x999999;
		}
		
		graphic = new Graphiclist([img, text]);
	}
}
