package taskbar;

import com.haxepunk.graphics.Image;

class TaskBar
{
	var desktop : Desktop;
	
	public function new (desktop:Desktop)
	{
		this.desktop = desktop;
		
		desktop.addGraphic(new Image("graphics/shadow.png"), -10, 0, 500-19);
		desktop.addGraphic(new Image("graphics/taskbar.png"), -10, 0, 500);
		
		( desktop.add(new Icon("start_menu", 0, 500, function () trace("cb start menu"))) ).layer = -10;
		( desktop.add(new Icon("show_desktop", 40, 500, function () trace("cb show desktop"))) ).layer = -10;
		var clock = desktop.add(new Clock());
		clock.layer = -10;
		new Volume(desktop, clock);
	}
}
