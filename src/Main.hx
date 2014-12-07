import com.haxepunk.Engine;
import com.haxepunk.HXP;

class Main extends Engine
{
	public function new ()
	{
		super(960, 540, 60);
	}
	
	override public function init ()
	{
#if debug
		HXP.console.enable();
#end
		HXP.defaultFont = "font/Timeless-Bold.ttf";
		HXP.scene = new Desktop();
	}

	public static function main() { new Main(); }
}
