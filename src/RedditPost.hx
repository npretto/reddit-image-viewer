package;

import Embed.DirectImg;
import Embed.DirectVideo;
import Embed.GIFv;


/**
 * ...
 * @author npretto
 */
class RedditPost 
{
	public var permalink:String;
	public var author:String;
	public var sub:String;
	public var title:String;
	public var redditUrl:String;
	public var date:Date;
	public var embed:Null<Embed>;
	public var url:String;


	public function new(date:Date, permalink:String, title:String, sub:String, author:String, url:String, embed:Null<Embed>) 
	{
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
		var permalink = data.permalink;
		var subreddit = data.subreddit;
		var author = data.author;
		var title = data.title;
		var date = Date.fromTime(data.created_utc * 1000);
		
		var url:String = data.url;
		var embed:Embed = null;
		
		if (url.length > 5)
		{
			trace('>>> $url');
			var fileExt = url.substr( -4);
			trace(fileExt);
			if ([".png", ".gif", ".jpg"].indexOf(fileExt) >= 0)
			{
				embed = new DirectImg(url);
				trace('DirectImg($url)');
			}
			if (["webm", ".mp4"].indexOf(fileExt) >= 0)
			{
				embed = new DirectVideo(url);
				trace('DirectVideo($url)');
			}
			if (["gifv"].indexOf(fileExt) >= 0)
			{
				embed = new GIFv(url);
				trace('GIFv($url)');
			}

		}

		return new RedditPost(date, permalink, title, subreddit, author, url, embed);
	}
	
	public function renderToHtml():String
	{
		return '
		<div class="post">
			<div class="title"><h3>$title</h3></div>
			
			<div class="embed">
				${renderEmbed()}
			</div>
			
			<div class="footer">
				<a target="_blank" href="http://www.reddit.com$permalink"> view on reddit </a>
				<p class="time-ago">${timeAgo(date)}</p>
			</div>
		</div>
		
		';

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