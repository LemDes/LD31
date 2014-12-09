import com.haxepunk.Entity;
import com.haxepunk.graphics.Text;

class TimeLeft extends Entity
{
	var text : Text;	
	var start : Float;
	public var leftTime : Bool = true;
	public var submitted = false;
	
	public function new ()
	{
		start = Date.now().getTime() - DateTools.minutes(50) + DateTools.seconds(1);
		text = new Text("10:00", {color: 0, size: 32});
		
		super(800, 233, text);
		
		layer = 20000;
	}
	
	public override function update ()
	{
		super.update();
		
		if (submitted)
		{
			text.color = 0x00FF00;
			return;
		}
		
		if (text.text != "00:00")
			text.text = DateTools.format(Date.fromTime(start - Date.now().getTime()), "%M:%S");
		else
		{
			text.color = 0xFF0000;
			leftTime = false;
		}
	}
}
