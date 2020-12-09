package 
{
	import starling.display.Quad;
	/**
	 * ...
	 * @author Vendrie
	 */
	public class Enemy extends Quad
	{
		public var active : Boolean = false;
		
		public var speedX : int;
		public var speedY : int;
		
		public var insideStage : Boolean = false;
		
		public var level : int;
		public var EnemyEatCount : int;
		
		public function Enemy(width:Number, height:Number, color:uint=0xffffff) 
		{
			super(width, height, color);
		}
		
	}

}