package taskbar;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;

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
		
		x = 0;
		y = 510;
		
		createImg();
		
		this.window = window;
	}
	
	public function createImg()
	{			
		graphic = Image.createRect(width, height, 0xFF00FF);
	}
}
