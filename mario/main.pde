// --- プレイヤー ---
float playerX = 100;
float playerY = 300;
float playerSize = 30;
float playerSpeedX = 0;
float playerSpeedY = 0;
boolean onGround = false;
PImage playerImg;

// --- スクロール ---
float scrollX = 0;
float gravity = 0.8;
float jumpPower = -15;

// --- 地面 ---
float groundY = 350;

// --- 敵・ブロック・ゴール ---
Enemy[] enemies;
Block[] blocks;
float goalX = 1800;
boolean gameClear = false;

void setup() {
  size(800, 400);

  enemies = new Enemy[2];
  enemies[0] = new Enemy(600, groundY - 30, 500, 700);
  enemies[1] = new Enemy(1200, groundY - 30, 1100, 1300);

  blocks = new Block[10];
  blocks[0] = new Block(300, groundY - 60);
  blocks[1] = new Block(340, groundY - 60);
  blocks[2] = new Block(800, groundY - 120);
  blocks[3] = new Block(1000, groundY - 60);
  blocks[4] = new Block(1400, groundY - 90);
  blocks[5] = new Block(1450, groundY - 90);
  blocks[6] = new Block(1600, groundY - 30);
  blocks[7] = new Block(1600, groundY - 60);
  blocks[8] = new Block(1600, groundY - 90);
  blocks[9] = new Block(1600, groundY - 120);
  
  playerImg = loadImage("emika.png");
}

void draw() {
  background(135, 206, 235); // 空色

  updatePlayer();
  scrollX = playerX - 100;
  
  // 画像描画（画像の中心がプレイヤー座標に来るよう調整）
  imageMode(CENTER);
  image(playerImg, playerX - scrollX, playerY, playerSize, playerSize);


  // 地面
  fill(50, 200, 70);
  rect(-scrollX, groundY, 2000, height - groundY);

  // ブロック
  onGround = false;
  for (Block b : blocks) {
    b.show(scrollX);
    b.checkCollisionWithResponse();
  }

  // 重力
  playerSpeedY += gravity;
  playerY += playerSpeedY;

  // 地面衝突
  if (playerY + playerSize / 2 >= groundY) {
    playerY = groundY - playerSize / 2;
    playerSpeedY = 0;
    onGround = true;
  }


  
  

  // 敵
  for (Enemy e : enemies) {
    e.move();
    e.show(scrollX);
    if (e.checkCollision(playerX, playerY, playerSize)) {
      println("ゲームオーバー！");
      restartGame();  // 衝突時にゲームをリスタート
    }
  }

  // ゴール
  fill(255);
  rect(goalX - scrollX, groundY - 120, 10, 120);
  fill(255, 0, 0);
  ellipse(goalX - scrollX + 5, groundY - 120, 20, 20);

  if (playerX >= goalX) {
    fill(0, 0, 0, 180);
    textSize(40);
    text("CLEAR!", width / 2 - 80, height / 2);
    gameClear = true;
    restartGame();  // 衝突時にゲームをリスタート
  }
}

void keyPressed() {
  if (keyCode == RIGHT) {
    playerSpeedX = 5;
  } else if (keyCode == LEFT) {
    playerSpeedX = -5;
  } else if (key == ' ' && onGround) {
    playerSpeedY = jumpPower;
    onGround = false;
  }
}

void keyReleased() {
  if (keyCode == RIGHT || keyCode == LEFT) {
    playerSpeedX = 0;
  }
}

void restartGame() {
  playerX = 100;
  playerY = 300;
  playerSpeedX = 0;
  playerSpeedY = 0;
  onGround = false;
  gameClear = false;

  // 敵を初期化
  enemies[0] = new Enemy(600, groundY - 30, 500, 700);
  enemies[1] = new Enemy(1200, groundY - 30, 1100, 1300);

  loop(); // draw() 再開
}

void mousePressed() {
  if (!gameClear) loop();
}
