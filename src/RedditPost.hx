package;

import Embed.DirectImg;
import Embed.DirectVideo;
import Embed.GIFv;
import Embed.Gfycat;
import js.Browser;
import js.html.Element;

using StringTools;


/**
 * ...
 * @author npretto
 */
class RedditPost 
{
	public var id:String;
	public var permalink:String;
	public var author:String;
	public var sub:String;
	public var title:String;
	public var redditUrl:String;
	public var date:Date;
	public var embed:Null<Embed>;
	public var url:String;


	public function new(date:Date, permalink:String, title:String, sub:String, author:String, url:String, embed:Null<Embed>,id:String) 
	{
		this.id = id;
		this.embed = embed;
		this.permalink = permalink;
		this.author = author;
		this.sub = sub;
		this.title = title;
		this.date = date;
		this.url = url;
	}
	
	public static function fromJSON(data):RedditPost
	{
		//trace(data);
		var permalink = data.permalink;
		var subreddit = data.subreddit;
		var author = data.author;
		var title = data.title;
		var date = Date.fromTime(data.created_utc * 1000);
		
		var url:String = data.url;
		var embed:Embed = null;
		var id:String = data.name;
		
		if (url.length > 5)
		{
			//trace('>>> $url');
			var fileExt = url.substr( -4);
			//trace(fileExt);
			if ([".png", ".gif", ".jpg"].indexOf(fileExt) >= 0 || url.indexOf("i.reddituploads.com")>=0)
			{
				embed = new DirectImg(url);
				//trace('DirectImg($url)');
			}else if (["webm", ".mp4"].indexOf(fileExt) >= 0)
			{
				embed = new DirectVideo(url);
				//trace('DirectVideo($url)');
			}else if(["gifv"].indexOf(fileExt) >= 0)
			{
				embed = new GIFv(url);
				//trace('GIFv($url)');
			}else if (url.indexOf("gfycat.com") >= 0)
			{
				embed = new Gfycat(url);
	
			}

		}

		return new RedditPost(date, permalink, title, subreddit, author, url, embed,id);
	}
	
	public function renderToHtml(?bigView = false):Element
	{
		var el:Element = Browser.document.createDivElement();
		if (bigView)
		{
			el.className = "col-md-12 big-view";
		}else{
			el.className = "col-md-4";
		}
		el.innerHTML = '
		<div class=" post card">
			<div class="title">
				<h3>
					<a href="javascript:goTo(\'$id\')">
						$title
					</a>
				</h3>
			</div>
			
			<div class="embed">
				${renderEmbed()}
			</div>
			
			<div class="footer">
				<a target="_blank" href="//www.reddit.com$permalink"> view post on /r/$sub </a>
				<p class="time-ago">${timeAgo(date)}</p>
			</div>
		
		</div>
		';
		return el;

	}
	
	public function renderEmbed():String
	{
		
		if (embed != null)
			return embed.render();
		else
			return "not embeddable: "+url;
	}
	
	
	function timeAgo(date:Date) {
		//https://stackoverflow.com/a/3177838/2670415 because i'm lazy and also don't reinvent the wheel
		var seconds = Math.floor((Date.now().getTime() - date.getTime())/1000);
		var interval = Math.floor(seconds / 31536000);

		if (interval > 1) {
			return interval + "y";
		}
		interval = Math.floor(seconds / 2592000);
		if (interval > 1) {
			return interval + "m";
		}
		interval = Math.floor(seconds / 86400);
		if (interval > 1) {
			return interval + "d";
		}
		interval = Math.floor(seconds / 3600);
		if (interval > 1) {
			return interval + "h";
		}
		interval = Math.floor(seconds / 60);
		if (interval > 1) {
			return interval + "m";
		}
		return Math.floor(seconds) + "s";
	}
}