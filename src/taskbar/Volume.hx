package taskbar;

import com.haxepunk.graphics.Image;

class Volume
{
	public var volume : Bool = true;
	var icon : Icon;
	var icons : Array<Image>;
	
	public function new (desktop:Desktop, clock:Clock)
	{
		icon = desktop.add(new Icon("volume_on", Std.int(clock.x - 30), 500, swap));
		
		icons = new Array<Image>();
		icons.push(icon.img_normal);
		icons.push(icon.img_hover);
		icons.push(new Image("graphics/icons/volume_off.png"));
		icons.push(new Image("graphics/icons/volume_off_hover.png"));
	}
	
	function swap ()
	{
		volume = !volume;
		
		if (volume)
		{
			icon.img_normal = icons[0];
			icon.img_hover = icons[1];
		}
		else
		{
			icon.img_normal = icons[2];
			icon.img_hover = icons[3];
		}
	}
}
