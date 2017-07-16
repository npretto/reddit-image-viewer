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
			Browser.window.location.hash="#wordporn+gifs";
			
		var subs = Browser.location.hash.substr(1).split("+");
		
		var viewer = new RedditViewer();
		viewer.loadSubreddits(subs)
			.then(function(images){
				trace("THEN:");
				trace(images);
				Browser.document.getElementById("main").innerHTML = ""; //probably not the best way?
				addTo(images, Browser.document.getElementById("main"));
			});
	}
	
	
	public static function addTo(images:Array<RedditPost>,element:Element)
	{
		
		for (img in images)
		{
			var el = Browser.document.createElement("div");
			el.innerHTML = img.renderToHtml();
			element.appendChild(el);
		}
		
	}	
	

}