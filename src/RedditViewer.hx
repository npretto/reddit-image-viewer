package;

import haxe.Http;
import haxe.Json;
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
	
	public function loadSubreddits(subs:Array<String>):Promise<Array<RedditPost>>
	{
		return loadSubreddit(subs.join("+"));
	}
	
	function loadSubreddit(sub:String):Promise<Array<RedditPost>>
	{
		var images = new Array<RedditPost>();
		var req = new Http('https://www.reddit.com/r/$sub.json?limit=36');
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