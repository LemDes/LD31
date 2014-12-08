package taskbar;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;

import windows.Window;

class TaskWindow extends Entity
{
	public var window : Window;
	
	public function new (window:Window)
	{
		super();
		
		width = 1;
		height = 20;
		
		layer = -12;
		type = "taskwindow";
		
		x = 0;
		y = 510;
		
		createImg();
		
		this.window = window;
	}
	
	public function createImg()
	{			
		graphic = Image.createRect(width, height, 0x0000FF);
	}
	
	public override function update ()
	{
		super.update();
		
		var mx = Input.mouseX;
		var my = Input.mouseY;
		
		if (x <= mx && mx <= x + width && y <= my && my <= y + height && !Desktop.inDrag() && HXP.scene.collidePoint("taskwindow", mx, my) == this)
		{
			cast(graphic, Image).color = 0xFF00FF;
			
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
			cast(graphic, Image).color = 0x0000FF;
		}
	}
}
