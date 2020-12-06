package 
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.Color;
	/**
	 * ...
	 * @author Vendrie
	 */
	public class Game extends Sprite
	{
		private var enemyAr : Vector.<Enemy> = new Vector.<Enemy>();
		
		private var timer : int = 100;
		
		private var maxSpeed : int = 5;
		
		private var player: Player;
		private var background : Quad;
		
		private var sentuhX : Number;
		private var sentuhY : Number;
		private var movePlayer : Boolean = false;
		
		private var enemyArColor : Array = [Color.RED, Color.GREEN, Color.WHITE];
		
		public function Game() 
		{
			background = new Quad(1024, 600, 0);
			addChild(background);
			
			var tempEnemy : Enemy;
			for (var i : int = 0; i < 10; i++)
			{
				tempEnemy = new Enemy(30, 30, Color.RED);
				tempEnemy.pivotX = tempEnemy.width / 2;
				tempEnemy.pivotY = tempEnemy.height / 2;
				tempEnemy.x = -100;
				tempEnemy.level = 1;
				tempEnemy.touchable = false;
				addChild(tempEnemy);
				enemyAr.push(tempEnemy);
			}
			
			player = new Player(30, 30, Color.BLUE);
			player.pivotX = player.width / 2;
			player.pivotY = player.height / 2;
			player.x = 512;
			player.y = 300;
			player.touchable = false;
			player.level = 1;
			player.speed = 5;
			addChild(player);
			
			this.addEventListener(EnterFrameEvent.ENTER_FRAME, enterFrame);
			this.addEventListener(TouchEvent.TOUCH, touchGame);
		}
		
		private function touchGame(e:TouchEvent):void 
		{
			var sentuh : Touch = e.touches[0];
			
			if (sentuh.phase == TouchPhase.MOVED)
			{
				movePlayer = true;
				sentuhX = sentuh.globalX;
				sentuhY = sentuh.globalY;
			} else {
				movePlayer = false;
			}
		}
		
		private function enterFrame(e:EnterFrameEvent):void 
		{
			timer--;
			if (timer <= 0)
			{
				timer = 100;
				spawnEnemy();
			}
			
			for (var i : int = 0; i < 10; i++)
			{
				if (enemyAr[i].active == true)
				{
					if (enemyAr[i].y - enemyAr[i].height / 2 > 0 &&
						enemyAr[i].y + enemyAr[i].height / 2 < 600 &&
						enemyAr[i].x - enemyAr[i].width / 2 > 0 &&
						enemyAr[i].x + enemyAr[i].width / 2 < 1024)
						{
							enemyAr[i].insideStage = true;
						}
					
					enemyAr[i].x += enemyAr[i].speedX;
					enemyAr[i].y += enemyAr[i].speedY;
					
					if (enemyAr[i].insideStage == true)
					{
						if (enemyAr[i].y - enemyAr[i].height / 2 <= 0 || enemyAr[i].y + enemyAr[i].height / 2 >= 600)
						{
							enemyAr[i].speedY *= -1;
						}
						
						if (enemyAr[i].x - enemyAr[i].width / 2 <= 0 || enemyAr[i].x + enemyAr[i].width / 2 >= 1024)
						{
							enemyAr[i].speedX *= -1;
						}
					}
				}
			}
			
			
			//MOVE PLAYER
			if (movePlayer)
			{
				var angle:Number = Math.atan2(sentuhY - player.y, sentuhX - player.x);
				var xstep:Number = Math.cos(angle) * player.speed;
				var ystep:Number = Math.sin(angle) * player.speed;
				
				player.x += xstep;
				player.y += ystep;
			}
		}
		
		private function spawnEnemy():void 
		{
			for (var i : int = 0; i < 10; i++)
			{
				if (enemyAr[i].active == false)
				{
					enemyAr[i].active = true;
					enemyAr[i].level = (Math.random() * 2) + 1;
					enemyAr[i].color = enemyArColor[enemyAr[i].level - 1];
					var spawnSide : int = Math.random() * 4;
					var randSpeed : int = (Math.random() * (maxSpeed - 2)) + 2;
					//0 = top
					//1 = bottom
					//2 = left
					//3 = right
					if (spawnSide == 0)
					{
						enemyAr[i].x = Math.random() * 900 + 50;
						enemyAr[i].y = -50;
						enemyAr[i].speedX = randSpeed;
						enemyAr[i].speedY = randSpeed;
					}
					else if (spawnSide == 1)
					{
						enemyAr[i].x = Math.random() * 900 + 50;
						enemyAr[i].y = 650;
						enemyAr[i].speedX = randSpeed;
						enemyAr[i].speedY = -(randSpeed);
					}
					else if (spawnSide == 2)
					{
						enemyAr[i].x = -50;
						enemyAr[i].y = Math.random() * 500 + 50;
						enemyAr[i].speedX = randSpeed;
						enemyAr[i].speedY = randSpeed;
					}
					else if (spawnSide == 3)
					{
						enemyAr[i].x = 1074;
						enemyAr[i].y = Math.random() * 500 + 50;
						enemyAr[i].speedX = -(randSpeed);
						enemyAr[i].speedY = randSpeed;
					}
					
					break;
				}
			}
		}
		
	}

}