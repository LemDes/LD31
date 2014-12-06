package taskbar;

import com.haxepunk.graphics.Image;

class TaskBar
{
	var desktop : Desktop;
	
	public function new (desktop:Desktop)
	{
		this.desktop = desktop;
		
		desktop.addGraphic(new Image("graphics/taskbar.png"), 0, 0, 500);
		
		desktop.add(new Icon("start_menu", 0, 500, function () trace("cb start menu")));
		desktop.add(new Icon("show_desktop", 40, 500, function () trace("cb show desktop")));
		var clock = desktop.add(new Clock());
		new Volume(desktop, clock);
	}
}
