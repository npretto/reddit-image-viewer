package;

import massive.munit.Assert;
import massive.munit.async.AsyncFactory;

/**
* Auto generated ExampleTest for MassiveUnit. 
* This is an example test class can be used as a template for writing normal and async tests 
* Refer to munit command line tool for more information (haxelib run munit)
*/
class UrlParserTest 
{
	
	public function new() 
	{
		
	}
	
	@BeforeClass
	public function beforeClass():Void
	{
	}
	
	@AfterClass
	public function afterClass():Void
	{
	}
	
	@Before
	public function setup():Void
	{
	}
	
	@After
	public function tearDown():Void
	{
	}
	
	
	@Test
	public function testUrlParsing():Void
	{
		var params = new UrlParams();
		params.fromPath("#aww+gifs?after=3d92jd");
		Assert.areEqual(params.subs.length, 2);
		Assert.areEqual(params.get("after"), "3d92jd");
		
		params.fromPath("#aww+gifs?blabla=3d92jd&limit=35");
		
		Assert.areEqual(params.get("before"), null);		
		Assert.areEqual(params.get("limit"), "35");
	}
	
	@Test
	public function testUrlParamsToString():Void
	{
		var params = new UrlParams();
		Assert.areEqual(params.toString(), "#");
		params.subs = ["aww"];
		Assert.areEqual(params.toString(), "#aww");
		params.subs = ["aww","gifs"];
		Assert.areEqual(params.toString(), "#aww+gifs");
		params.set("before", "t3_f3d2d3");
		Assert.areEqual(params.toString(), "#aww+gifs?before=t3_f3d2d3");
		params.set("limit", "35");
		Assert.areEqual(params.toString(), "#aww+gifs?before=t3_f3d2d3&limit=35");
		
	}
	

	


}