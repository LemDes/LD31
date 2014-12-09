package taskbar;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Text;

class Clock extends Entity
{
	var text : Text;	
	var start : Float;
	
	public function new ()
	{
		super();
		
		graphic = text = new Text("00:00:01", {color: 0xBECFD2});
		x = 960 - text.width - 10;
		y = 500 + (40 - text.height) / 2;
		
		start = -1 * Date.now().getTime() + DateTools.hours(11) - DateTools.minutes(10);
	}
	
	public override function update ()
	{
		super.update();
		
		text.text = DateTools.format(Date.fromTime(start + Date.now().getTime()), "%H:%M:%S");
	}
}
