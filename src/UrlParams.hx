package;
import haxe.ds.StringMap;
import js.html.svg.AnimatedBoolean;

/**
 * ...
 * @author npretto
 */
class UrlParams extends StringMap<String>
{
	public var subs:Array<String> = new Array();
	
	public function new() 
	{
		super();
	}
	
	
	public function fromPath(path:String):Bool
	{
		for (key in keys())
		{
			set(key, "");
		}
		
		if (path == null || path.length == 0)
		{
			return false;
		}
		
		var split = path.split("?");
		
		var subsString = split[0];
		
		if (subsString.charAt(0) == "#")
		{
			subsString = subsString.substr(1);
			subs = subsString.split("+");
		}else{
			return false;
		}
		
		
		if (split.length > 1)
		{
			var paramsString = split[1];
			if (paramsString.charAt(0) == "?")
			{
				paramsString.substr(1);
			}
			for (param in paramsString.split("&"))
			{
				var tmp = param.split("=");
				set(tmp[0], tmp[1]);
			}
		}
		
		return true;
	}
	
	
	public override function toString():String
	{
		var str = "?";
		
		for (key in keys())
		{
			str += key + "=" + get(key);
		}
		
		
		
		return "#" + subs.join("+")+str;
	}
	
	
}