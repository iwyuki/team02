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

// --- 地面の高さ ---
float groundY = 350;

// --- 敵 ---
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
}

void draw() {
  background(135, 206, 235);

  // プレイヤー位置更新
  updatePlayer();

  // スクロール処理
  scrollX = playerX - 100;

  // 地面描画
  fill(50, 200, 70);
  rect(-scrollX, groundY, 2000, height - groundY);

  // ブロック処理
  onGround = false; // 一度リセットして判定を再確認
  for (Block b : blocks) {
    b.show(scrollX);
    b.checkCollisionWithResponse();
  }

  // プレイヤー物理処理
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

  // 敵の処理
  for (Enemy e : enemies) {
    e.move();
    e.show(scrollX);
    if (e.checkCollision(playerX, playerY, playerSize)) {
      println("ゲームオーバー！");
      noLoop();
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
    noLoop();
  }
}

void updatePlayer() {
  playerX += playerSpeedX;
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

void mousePressed() {
  if (!gameClear) loop();
}

// --- 敵クラス ---
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
    return (px + psize / 2 > x &&
            px - psize / 2 < x + size &&
            py + psize / 2 > y &&
            py - psize / 2 < y + size);
  }
}

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

  // 衝突していたら押し戻し処理
  void checkCollisionWithResponse() {
    float px = playerX;
    float py = playerY;
    float r = playerSize / 2;

    if (px + r > x && px - r < x + size &&
        py + r > y && py - r < y + size) {

      float overlapLeft = px + r - x;
      float overlapRight = x + size - (px - r);
      float overlapTop = py + r - y;
      float overlapBottom = y + size - (py - r);

      // 最小の重なり方向で補正
      float minOverlap = min(min(overlapLeft, overlapRight), min(overlapTop, overlapBottom));

      if (minOverlap == overlapTop) {
        // 上から乗った
        playerY = y - r;
        playerSpeedY = 0;
        onGround = true;
      } else if (minOverlap == overlapBottom) {
        // 下からぶつかった
        playerY = y + size + r;
        if (playerSpeedY < 0) playerSpeedY = 0;
      } else if (minOverlap == overlapLeft) {
        // 左からぶつかった
        playerX = x - r;
        if (playerSpeedX > 0) playerSpeedX = 0;
      } else if (minOverlap == overlapRight) {
        // 右からぶつかった
        playerX = x + size + r;
        if (playerSpeedX < 0) playerSpeedX = 0;
      }
    }
  }
}
