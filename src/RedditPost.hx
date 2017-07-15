package;

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

	public function new(date:Date, permalink:String, title:String, sub:String, author:String) 
	{
		this.permalink = permalink;
		this.author = author;
		this.sub = sub;
		this.title = title;
		this.date = date;	
	}
	
	public static function fromJSON(data):RedditPost
	{
		var permalink = data.permalink;
		var subreddit = data.subreddit;
		var author = data.author;
		var title = data.title;
		
		var date = Date.fromTime(data.created_utc*1000);
		
		return new RedditPost(date, permalink, title, subreddit, author);
	}
	
	public function renderToHtml():String
	{
		return ' published on ${date} <a href="https://reddit.com/$permalink"> $title</a> at <strong>$sub</strong>';
	}
	
}