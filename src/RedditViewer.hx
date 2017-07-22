package;

import haxe.Http;
import haxe.Json;
import js.Browser;
import js.Lib;
import js.Promise;

/**
 * ...
 * @author npretto
 */
class RedditViewer 
{
	var images:Array<RedditPost>;
	
	public function new(){
		images = new Array();
	}
	
	public function loadSubreddits(subs:Array<String>,after:Null<String>=null):Promise<Array<RedditPost>>
	{
		return loadSubreddit(subs.join("+"),after);
	}
	
	public function getPost(id:String):Promise<RedditPost>
	{
		var images = new Array<RedditPost>();
		var url = 'https://www.reddit.com/${id.substr(3)}.json';
		trace('requesting $url');
		var req = new Http(url);
		req.request();
		
		return new Promise(function(resolve, reject) {
			req.onData = function(data){
				trace(">>>>>>>>>>>>single post data");
				trace(data);
				untyped Browser.window.data =  Json.parse(data);
				resolve(RedditPost.fromJSON(Json.parse(data)[0].data.children[0].data));
			}
			req.onError = function(error)
			{
				reject(error);
			}
		});
	}
	
	function loadSubreddit(sub:String,after:Null<String>=null):Promise<Array<RedditPost>>
	{
		var images = new Array<RedditPost>();
		var url = 'https://www.reddit.com/r/$sub.json?limit=36${after == null ? "" : "&after="+after}';
		trace('requesting $url');
		var req = new Http(url);
		req.request();
		
		return new Promise(function(resolve, reject) {
			req.onData = function(data){
				resolve(parseJson(Json.parse(data)));
			}
			req.onError = function(error)
			{
				reject(error);
			}
		});
	}
	
	function parseJson(json):Array<RedditPost>
	{
		trace(json);
		var posts:Array<RedditPost> = new Array<RedditPost>();
		
		for (post in cast(json.data.children,Array<Dynamic>))
		{
			posts.push(RedditPost.fromJSON(post.data));
		}
		
		
		return posts;
	}
	
	
}