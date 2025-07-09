// --- プレイヤー ---
float playerX = 100;
float playerY = 300;
float playerSize = 30;
float playerSpeedX = 0;
float playerSpeedY = 0;
boolean onGround = false;

// --- スクロール ---
float scrollX = 0;
float gravity = 0.8;
float jumpPower = -15;

<<<<<<< HEAD
// 地面
float groundY = 350;

// 敵情報（複数可）
=======
// --- 地面の高さ ---
float groundY = 350;

// --- 敵 ---
>>>>>>> faa380a10b51a99cfc20c6db680d6e45cfbb2cbd
Enemy[] enemies;

// --- ブロック ---
Block[] blocks;

// --- ゴール地点 ---
float goalX = 1800;
boolean gameClear = false;

void setup() {
  size(800, 400);

  // 敵を生成
  enemies = new Enemy[2];
  enemies[0] = new Enemy(600, groundY - 30, 500, 700);
  enemies[1] = new Enemy(1200, groundY - 30, 1100, 1300);

  // ブロックを生成
  blocks = new Block[10];
  blocks[0] = new Block(300, groundY - 60);   // 空中
  blocks[1] = new Block(340, groundY - 60);
  blocks[2] = new Block(800, groundY - 120);  // 高い場所
  blocks[3] = new Block(1000, groundY - 60);
  blocks[4] = new Block(1400, groundY - 90);
  blocks[5] = new Block(1450, groundY - 90);
  blocks[6] = new Block(1600, groundY - 30);  // 土管風
  blocks[7] = new Block(1600, groundY - 60);
  blocks[8] = new Block(1600, groundY - 90);
  blocks[9] = new Block(1600, groundY - 120);
}

void draw() {
<<<<<<< HEAD
  background(135, 206, 235); // 空色
  // プレイヤーの移動
=======
  background(135, 206, 235); // 空

  // プレイヤー位置更新
>>>>>>> faa380a10b51a99cfc20c6db680d6e45cfbb2cbd
  updatePlayer();
  // スクロール処理
  scrollX = playerX - 100;

<<<<<<< HEAD
  // 地面
=======
  // 地面描画
>>>>>>> faa380a10b51a99cfc20c6db680d6e45cfbb2cbd
  fill(50, 200, 70);
  rect(-scrollX, groundY, 2000, height - groundY);

<<<<<<< HEAD
  // プレイヤーの物理挙動
=======
  // ブロック描画
  for (Block b : blocks) {
    b.show(scrollX);
    if (b.checkCollision(playerX, playerY, playerSize)) {
      playerY = b.y - playerSize / 2;
      playerSpeedY = 0;
      onGround = true;
    }
  }

  // プレイヤー物理処理
>>>>>>> faa380a10b51a99cfc20c6db680d6e45cfbb2cbd
  playerSpeedY += gravity;
  playerY += playerSpeedY;

  // 地面との衝突
  if (playerY + playerSize / 2 >= groundY) {
    playerY = groundY - playerSize / 2;
    playerSpeedY = 0;
    onGround = true;
  }

  // プレイヤー描画
  fill(255, 0, 0);
  ellipse(playerX - scrollX, playerY, playerSize, playerSize);

  // 敵描画と移動
  for (Enemy e : enemies) {
    e.move();
    e.show(scrollX);
    if (e.checkCollision(playerX, playerY, playerSize)) {
      println("ゲームオーバー！");
<<<<<<< HEAD
      noLoop(); // ゲームストップ
=======
      noLoop();
>>>>>>> faa380a10b51a99cfc20c6db680d6e45cfbb2cbd
    }
  }

  // ゴール描画
  fill(255);
  rect(goalX - scrollX, groundY - 120, 10, 120);
  fill(255, 0, 0);
  ellipse(goalX - scrollX + 5, groundY - 120, 20, 20);

  // ゴール判定
  if (playerX >= goalX) {
    fill(0, 0, 0, 180);
    textSize(40);
    text("CLEAR!", width / 2 - 80, height / 2);
    gameClear = true;
    noLoop();
  }
}

<<<<<<< HEAD
// 移動処理
=======
void updatePlayer() {
  playerX += playerSpeedX;
}

>>>>>>> faa380a10b51a99cfc20c6db680d6e45cfbb2cbd
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

<<<<<<< HEAD
// 毎フレームプレイヤーの位置更新
void updatePlayer() {
  playerX += playerSpeedX;
}

// 敵クラス
=======
void mousePressed() {
  if (!gameClear) loop(); // 再開（失敗時用）
}

// --- 敵クラス ---
>>>>>>> faa380a10b51a99cfc20c6db680d6e45cfbb2cbd
class Enemy {
  float x, y;
  float size = 30;
  float speed = 1.5;
  float leftBound, rightBound;

  Enemy(float x, float y, float leftBound, float rightBound) {
    this.x = x;
    this.y = y;
    this.leftBound = leftBound;
    this.rightBound = rightBound;
  }

  void move() {
    x += speed;
    if (x < leftBound || x > rightBound) {
      speed *= -1;
    }
  }

  void show(float scroll) {
    fill(0);
    rect(x - scroll, y, size, size);
  }

  boolean checkCollision(float px, float py, float psize) {
    return (px + psize / 2 > x && px - psize / 2 < x + size &&
            py + psize / 2 > y && py - psize / 2 < y + size);
  }
}

<<<<<<< HEAD
void mousePressed() {
  // ゲームの初期化
  playerX = 100;
  playerY = 300;
  playerSpeedX = 0;
  playerSpeedY = 0;
  onGround = false;

  // 敵を再生成
  enemies[0] = new Enemy(600, groundY - 30);
  enemies[1] = new Enemy(900, groundY - 30);
  enemies[2] = new Enemy(1300, groundY - 30);

  loop(); // 再スタート
=======
// --- ブロッククラス ---
class Block {
  float x, y;
  float size = 40;

  Block(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void show(float scroll) {
    fill(200, 150, 0);
    rect(x - scroll, y, size, size);
  }

  boolean checkCollision(float px, float py, float psize) {
    // プレイヤーが上から乗った場合のみ
    return (px + psize / 2 > x && px - psize / 2 < x + size &&
            py + psize / 2 >= y && py + psize / 2 <= y + 10 &&
            playerSpeedY >= 0);
  }
>>>>>>> faa380a10b51a99cfc20c6db680d6e45cfbb2cbd
}
