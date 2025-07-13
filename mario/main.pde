// --- プレイヤー ---
float playerX = 100;
float playerY = 300;
float playerSize = 50;
float playerSpeedX = 0;
float playerSpeedY = 0;
boolean onGround = false;
PImage playerImg;
PImage enemyImg1;

// --- スクロール ---
float scrollX = 0;
float gravity = 0.8;
float jumpPower = -16;

// --- 地面 ---
float groundY = 350;

// --- 敵・ブロック・ゴール ---
Enemy[] enemies;
BlockManager blockManager;
Pipe[] pipes;
float goalX = 6000;
boolean gameClear = false;

void setup() {
  size(800, 400);

  enemyImg1 = loadImage("kurosio.png");

  enemies = new Enemy[2];
  enemies[0] = new Enemy(600, groundY - 65, 500, 700, enemyImg1);
  enemies[1] = new Enemy(1200, groundY - 65, 1100, 1300, enemyImg1);

  // 画面上に自由な位置に土管を置ける
  pipes = new Pipe[4];
  pipes[0] = new Pipe(1000, groundY - 75);
  pipes[1] = new Pipe(1800, groundY - 125);
  pipes[2] = new Pipe(1400, groundY - 100);
  pipes[3] = new Pipe(2200, groundY - 125);

  blockManager = new BlockManager();

  playerImg = loadImage("emika.png");
}

void draw() {
  background(135, 206, 235); // 空色

  updatePlayer();
  scrollX = playerX - 100;

  // 画像描画（画像の中心がプレイヤー座標に来るよう調整）
  imageMode(CENTER);
  image(playerImg, playerX - scrollX, playerY, playerSize, playerSize);

  boolean playerOnPipe = false;
  for (Pipe p : pipes) {
    p.show(scrollX);
    if (p.checkCollisionWithResponse()) {
      playerOnPipe = true;
    }
  }

  // 地面
  fill(50, 200, 70);
  rect(-scrollX, groundY, 2400, height - groundY);
  rect(2500 - scrollX, groundY, 340, height - groundY);
  rect(3040 - scrollX, groundY, 2000, height - groundY); 

  // ブロック
  boolean playerOnBlock = false;
  for (Block b : blockManager.blocks) {
    b.show(scrollX);
    if (b.checkCollisionWithResponse()) {
      playerOnBlock = true;
    }
  }

  // プレイヤーがブロックや土管の上にいるか
  onGround = playerOnBlock || playerOnPipe;

  // 重力・移動
  playerSpeedY += gravity;
  playerY += playerSpeedY;

  // 地面判定範囲（地面の横範囲を指定）
  boolean onSolidGround = (playerX >= 0 && playerX <= 2400) || (playerX >= 2500 && playerX <= 3200);

  // 地面衝突判定
  if (playerY + playerSize / 2 >= groundY) {
    if (onSolidGround) {
      playerY = groundY - playerSize / 2;
      playerSpeedY = 0;
      onGround = true;
    } else {
      // 穴の上なので落ちる
      onGround = false;
    }
  } else {
    onGround = false;
  }

  // 穴に落ちたらゲームオーバー
  if (playerY + playerSize / 2 - 100 > height) {
    println("ゲームオーバー！（落下）");
    restartGame();
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
  enemies[0] = new Enemy(600, groundY - 65, 500, 700,enemyImg1);
  enemies[1] = new Enemy(1200, groundY - 65, 1100, 1300,enemyImg1);

  loop(); // draw() 再開
}

void mousePressed() {
  if (!gameClear) loop();
}
