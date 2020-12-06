package 
{
	import starling.display.Quad;
	/**
	 * ...
	 * @author Vendrie
	 */
	public class Player extends Quad
	{
		public var level : int;
		public var speed : int;
		
		public function Player(width:Number, height:Number, color:uint=0xffffff ) 
		{
			super(width, height, color);
		}
		
	}

}