package;
import js.Browser;
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
		var viewer = new RedditViewer();
		viewer.loadSubreddits(["worldporn","gifs"])
			.then(function(images){
				trace("THEN:");
				trace(images);
				Browser.document.getElementById("main").appendChild(showAsUL(images));
			});
	}
	
	
	public static function showAsUL(images:Array<RedditPost>):Node
	{
		var ul = Browser.document.createUListElement();
		
		for (img in images)
		{
			var el = Browser.document.createElement("LI");
			el.innerHTML = img.renderToHtml();
			ul.appendChild(el);
		}
		
		return ul;
	}	
}