import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.*;
import com.haxepunk.utils.Input;

class Icon extends Entity
{
	public var img_normal : Image;
	public var img_hover : Image;
	var g_normal : Graphiclist;
	var g_hover : Graphiclist;
	var cb : Void->Void;
	var text : Bool;
	
	public function new (name:String, x:Int, y:Int, cb:Void->Void, ?text:String, ?maxWidth:Int)
	{
		this.cb = cb;
		
		img_normal = new Image('graphics/icons/$name.png');
		img_hover = new Image('graphics/icons/${name}_hover.png');
		
		if (text != null)
		{
			g_normal = new Graphiclist();
			g_normal.add(img_normal);
			g_normal.add(new Text(text, 0, img_normal.height + 5, maxWidth, 0, {color: 0, wordWrap: true}));
			
			g_hover = new Graphiclist();
			g_hover.add(img_hover);
			g_hover.add(new Text(text, 0, img_normal.height + 5, maxWidth, 0, {color: 0x00FF00, wordWrap: true}));
			
			this.text = true;
			
			super(x, y, g_normal);
		}
		else
		{
			this.text = false;
			
			super(x, y, img_normal);
		}
		
		setHitboxTo(img_normal);
		type = "icon";
		layer = Desktop.minLayer;
	}
	
	public override function update ()
	{
		super.update();
		
		var mx = Input.mouseX;
		var my = Input.mouseY;
		
		if (x <= mx && mx <= x + width && y <= my && my <= y + height && !Desktop.inDrag() && HXP.scene.collidePoint("icon", mx, my) == this)
		{
			graphic = text ? g_hover : img_hover;
			
			if (Input.mouseReleased)
			{
				cb();
			}
		}
		else
		{
			graphic = text ? g_normal : img_normal;
		}
	}
}
