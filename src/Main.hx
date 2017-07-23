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
		Browser.window.scroll(0, 0);
		
		if (Browser.location.hash.length < 1)
			Browser.window.location.hash = "#aww+gifs";
			
		
		var hash = Browser.location.hash;
		
		var params = new UrlParams();

		if (params.fromPath(hash))
		{
			trace(params);
			trace(params.toString());
			
			var viewer = new RedditViewer();
			
			if (params.exists("from"))
			{
				trace(">>>>>>>>>>>>>THIS IS A FROM PAGE");
				viewer.getPost(params.get("from")).then(function(post:RedditPost){
					Browser.document.getElementById("big-view").innerHTML = "";
					Browser.document.getElementById("big-view").appendChild(post.renderToHtml(true));
				});
			}
			
			viewer.loadSubreddits(params.subs, params.exists("from") ? params.get("from") : params.get("after"))
				.then(function(images){
					trace("THEN:");
					trace(images);
					Browser.document.getElementById("main").innerHTML = ""; //probably not the best way?
					addTo(images, Browser.document.getElementById("main"));
				});
		}else{
			trace("params not ok");
		}
		
		
		untyped Browser.window.goTo = function(id:String)
		{
			trace(id);
			Browser.window.location.hash = params.getUrlFor("from", id);
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