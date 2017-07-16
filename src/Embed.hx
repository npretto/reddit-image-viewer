package;
	
using StringTools;

/**
 * ...
 * @author npretto
 */
class Embed 
{

	public function new() 
	{
		
	}
	
	public function render():String
	{
		return '<div> BASE EMBED </div>';
	}
	
}


class DirectImg extends Embed
{
	var url:String;
	public function new(url:String){
		super();
		this.url = url;
	}
	
	
	override public function render():String 
	{
		return '<img src="$url" />';
	}

}


class GIFv extends Embed
{
	var url:String;
	public function new(url:String){
		super();
		this.url = url.replace(".gifv","");
	}
	
	
	override public function render():String 
	{
		return '
		<video id="video" controls="" loop="" class="gfyVid" height="auto" style="max-width:100%" autoplay="" muted="muted">
			<source id="mp4source" src="$url.mp4">
		</video>
	';

	}

}

class DirectVideo extends Embed
{
	var url:String;
	public function new(url:String){
		super();
		this.url = url;
	}
	
	
	override public function render():String 
	{
		return '
		<video class="preview vsc-initialized" preload="auto" autoplay="autoplay" muted="muted" loop="loop" webkit-playsinline="">
			<source src="$url">
		</video>';

	}

}