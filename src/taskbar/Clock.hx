package taskbar;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Text;

class Clock extends Entity
{
	var text : Text;
	
	public function new ()
	{
		super();
		
		graphic = text = new Text("00:00:00", {color: 0xBECFD2});
		x = 960 - text.width - 10;
		y = 500 + (40 - text.height) / 2;
	}
	
	public override function update ()
	{
		super.update();
		
		text.text = DateTools.format(Date.now(), "%H:%M:%S");
	}
}
