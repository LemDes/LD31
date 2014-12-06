import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;

class Icon extends Entity
{
	public var img_normal : Image;
	public var img_hover : Image;
	var cb : Void->Void;
	
	public function new (name:String, x:Int, y:Int, cb:Void->Void)
	{
		this.cb = cb;
		
		img_normal = new Image('graphics/icons/$name.png');
		img_hover = new Image('graphics/icons/${name}_hover.png');
		
		super(x, y, img_normal);
		
		setHitboxTo(img_normal);
	}
	
	public override function update ()
	{
		super.update();
		
		var mx = Input.mouseX;
		var my = Input.mouseY;
		
		if (x <= mx && mx <= x + width && y <= my && my <= y + height)
		{
			graphic = img_hover;
			
			if (Input.mouseReleased)
			{
				cb();
			}
		}
		else
		{
			graphic = img_normal;
		}
	}
}
