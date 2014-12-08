package windows;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Graphiclist;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import com.haxepunk.utils.Input;

import openfl.geom.Rectangle;

class Window extends Entity
{
	public var appName(default,null):String;
	public var fileName:String;
	public var rect(default,null):Rectangle;
	
	public var bar:Image;
	public var text:Text;
	
	public var titlebarHeight(default,null):Int = 27;
	private var reduceIcon:Icon;
	private var closeIcon:Icon;
	
	public var drag : { x:Float, y:Float };	
	var delta : { x:Float, y:Float };	
	
	public function new(rect:Rectangle)
	{		
		super((960-rect.width)/2, (500-rect.height)/2);
		this.rect = rect;
		graphic = new Graphiclist();
		makeTitleBar();		
		makeMainFrame();
		type="window";
		width = Std.int(rect.width);
		height = Std.int(rect.height);
		Desktop.minLayer -= 1;
		layer = Desktop.minLayer;
	}
	
	public override function added ()
	{
		closeIcon = new Icon("close", Std.int(x+rect.width-20), Std.int(y+4), function () close());
		reduceIcon = new Icon("reduce", Std.int(x+rect.width-45), Std.int(y+4), function () hide());
		HXP.scene.add(closeIcon);
		HXP.scene.add(reduceIcon);
	}
	
	public function makeTitleBar()
	{
		var g = cast(graphic, Graphiclist);
		
		var s = new Image("graphics/shadow.png", new Rectangle(0, 0, rect.width, 21));
		s.y = -10;
		g.add(s);
		
		var s = new Image("graphics/shadow.png", new Rectangle(0, 0, rect.width, 21));
		s.scaleY = -1;
		s.y = rect.height + 10;
		g.add(s);
		
		var s = new Image("graphics/shadow_vertical.png", new Rectangle(0, 0, 21, rect.height));
		s.x = -10;
		g.add(s);
		
		var s = new Image("graphics/shadow_vertical.png", new Rectangle(0, 0, 21, rect.height));
		s.scaleX = -1;
		s.x = rect.width + 10;
		g.add(s);
		
		var s = new Image("graphics/shadow_corner.png");
		s.x = -10;
		s.y = -10;
		g.add(s);
		
		var s = new Image("graphics/shadow_corner.png");
		s.scaleY = -1;
		s.x = -10;
		s.y = rect.height + 10;
		g.add(s);
		
		var s = new Image("graphics/shadow_corner.png");
		s.scaleX = -1;
		s.scaleY = -1;
		s.x = rect.width + 10;
		s.y = rect.height + 10;
		g.add(s);
		
		var s = new Image("graphics/shadow_corner.png");
		s.scaleX = -1;
		s.x = rect.width + 10;
		s.y = -10;
		g.add(s);
		
		bar = Image.createRect(Std.int(rect.width), Std.int(rect.height), 0xDDDAD8);
		g.add(bar);
		
		var appText = appName;
		if (fileName != null && fileName != "")
			appText += " - " + fileName;
		text = new Text(appText, 0, 0, 0, titlebarHeight-10, {color:0});
		text.x = Std.int((rect.width - text.width)/2);
		text.y = Std.int(bar.y+2);
		g.add(text);
	}
	
	public override function update ()
	{
		super.update();
		
		var mx : Float = Input.mouseX;
		var my : Float = Input.mouseY;
		
		if (Input.mousePressed && clicked(mx, my))
		{			
			//~ if (layer != Desktop.minLayer)
				bringToFront();
			
			if (x <= mx && mx <= x + width - 45 && y <= my && my <= y + titlebarHeight)
			{
				drag = { x: mx, y: my };
			}
		}
		
		if (Input.mouseReleased)
		{
			drag = null;
		}
		
		if (drag != null)
		{
			my = Math.min(my, 514-titlebarHeight);
			delta = { x: mx - drag.x, y: my - drag.y };
			drag = { x: mx, y: my };
		
			makeDrag();
		}
	}
	
	function clicked (mx:Float, my:Float) : Bool
	{
		return HXP.scene.collidePoint("window", mx, my) == this;
	}
	
	function makeDrag ()
	{
		addDelta(this, delta.x, delta.y);			
		addDelta(closeIcon, delta.x, delta.y);			
		addDelta(reduceIcon, delta.x, delta.y);
	}
	
	function addDelta (e:Entity, dx:Float, dy:Float)
	{
		e.x += dx;
		e.y += dy;
	}
	
	public function makeMainFrame()
	{
	}
	
	public function close()
	{
		Desktop.close(this);
		
		HXP.scene.remove(closeIcon);
		HXP.scene.remove(reduceIcon);
		HXP.scene.remove(this);
	}
	
	public function show()
	{
		closeIcon.visible = reduceIcon.visible = visible = true;
	}
	
	public function hide()
	{
		closeIcon.visible = reduceIcon.visible = visible = false;
	}
	
	public function bringToFront()
	{
		layer = Desktop.minLayer - 1;
		reduceIcon.layer = Desktop.minLayer - 1;
		closeIcon.layer = Desktop.minLayer - 1;
		
		Desktop.minLayer -= 1;
	}
}
