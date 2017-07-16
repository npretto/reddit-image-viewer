package;
	
using StringTools;

/**
 * ...
 * @author npretto
 */
class Embed 
{

	var url:String;
	public function new(url:String){
		this.url = url.replace("http://","//").replace("https://","//");
	}
	
	public function render():String
	{
		return '<div> BASE EMBED </div>';
	}
	
}


class DirectImg extends Embed
{
	public function new(url:String){
		super(url);
	}
	
	
	override public function render():String 
	{
		return '<img src="$url" />';
	}

}


class GIFv extends Embed
{
	public function new(url:String){
		super(url);
		this.url = url.replace(".gifv","");
	}
	
	
	override public function render():String 
	{
		return '
		<video controls="" preload="auto" autoplay="" muted="muted" loop="loop">
			<source src="$url.mp4">
		</video>
	';

	}

}

class DirectVideo extends Embed
{
	public function new(url:String){
		super(url);
	}
	
	
	override public function render():String 
	{
		return '
		<video controls="" preload="auto" autoplay="" muted="muted" loop="loop">
			<source src="$url">
		</video>';

	}

}

class Gfycat extends Embed
{
	public function new(url:String){
		super(url);
	}
	
	
	override public function render():String 
	{
		return '
			<iframe src="${url.replace("gfycat.com","gfycat.com/ifr")}" frameborder = "0" scrolling = "no" allowfullscreen >
			</iframe>
		';

	}

}