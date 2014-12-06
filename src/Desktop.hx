import com.haxepunk.Scene;
import com.haxepunk.graphics.Image;

class Desktop extends Scene
{
	public override function begin ()
	{
		// Wallpaper
		addGraphic(new Image("graphics/LD31-Background.png"));
		
		// TaskBar
		new taskbar.TaskBar(this);
	}
}
