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
		
		//~ add(new windows.ImageViewer(new openfl.geom.Rectangle(100,100,300,400),"toto"));
		//~ add(new windows.SoundPlayer(new openfl.geom.Rectangle(500,100,300,150),"sound"));
		add(new windows.Explorer(new openfl.geom.Rectangle(50,50,300,300),"Desktop"));
	}
}
