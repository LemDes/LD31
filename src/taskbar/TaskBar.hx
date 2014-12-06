package taskbar;

import com.haxepunk.graphics.Image;

class TaskBar
{
	var desktop : Desktop;
	
	public function new (desktop:Desktop)
	{
		this.desktop = desktop;
		
		desktop.addGraphic(new Image("graphics/taskbar.png"), 0, 0, 500);
		
		desktop.add(new Icon("graphics/icons/start_menu.png", "graphics/icons/start_menu.png", 0, 500, 40, 40, function () trace("cb start menu")));
		desktop.add(new Icon("graphics/icons/show_desktop.png", "graphics/icons/show_desktop.png", 40, 500, 40, 40, function () trace("cb show desktop")));
	}
}
