package;
import haxe.xml.Parser.XmlParserException;
import js.Browser;
import js.html.Element;
import js.html.Node;
import js.html.UListElement;

/**
 * ...
 * @author npretto
 */
class Main 
{

	public static function main() 
	{
		Browser.window.onhashchange = doStuff;
		doStuff();
	}
	
	static private function doStuff():Void 
	{
		if (Browser.location.hash.length < 1)
			Browser.window.location.hash = "#aww+gifs";
			
		
		var hash = Browser.location.hash;
		
		var params = new UrlParams();

		if (params.fromPath(hash))
		{
			trace(params);
			trace(params.toString());
			
			var viewer = new RedditViewer();
			viewer.loadSubreddits(params.subs,params.get("after"))
				.then(function(images){
					trace("THEN:");
					trace(images);
					Browser.document.getElementById("main").innerHTML = ""; //probably not the best way?
					addTo(images, Browser.document.getElementById("main"));
				});
		}else{
			trace("params not ok");
		}
		
	}
	
	
	public static function addTo(images:Array<RedditPost>,element:Element)
	{
		
		for (img in images)
		{
			element.appendChild(img.renderToHtml());
		}
		
	}	
	

}