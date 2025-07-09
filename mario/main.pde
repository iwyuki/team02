// プレイヤー情報
float playerX = 100;
float playerY = 300;
float playerSize = 30;
float playerSpeedX = 0;
float playerSpeedY = 0;
boolean onGround = false;

// スクロール用オフセット
float scrollX = 0;

// 重力とジャンプ
float gravity = 0.8;
float jumpPower = -15;

// 地面の高さ
float groundY = 350;

// 敵情報
Enemy[] enemies;

void setup() {
  size(800, 400);
  enemies = new Enemy[3];
  enemies[0] = new Enemy(600, groundY - 30);
  enemies[1] = new Enemy(900, groundY - 30);
  enemies[2] = new Enemy(1300, groundY - 30);
}

void draw() {
  background(135, 206, 235); // 空色

  // プレイヤー位置を更新
  updatePlayer();

  // スクロール処理
  scrollX = playerX - 100;

  // 地面の描画
  fill(50, 200, 70);
  rect(-scrollX, groundY, width * 2, height - groundY);

  // プレイヤーの重力処理
  playerSpeedY += gravity;
  playerY += playerSpeedY;

  // 地面との衝突判定
  if (playerY + playerSize / 2 >= groundY) {
    playerY = groundY - playerSize / 2;
    playerSpeedY = 0;
    onGround = true;
  }

  // プレイヤー描画
  fill(255, 0, 0);
  ellipse(playerX - scrollX, playerY, playerSize, playerSize);

  // 敵の描画と当たり判定
  for (Enemy e : enemies) {
    e.update(scrollX);
    if (e.checkCollision(playerX, playerY, playerSize)) {
      println("ゲームオーバー！");
      noLoop(); // 停止
    }
  }
}

// プレイヤーの位置更新
void updatePlayer() {
  playerX += playerSpeedX;
}

// キーが押されたとき
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

// キーが離されたとき
void keyReleased() {
  if (keyCode == RIGHT || keyCode == LEFT) {
    playerSpeedX = 0;
  }
}

// 敵クラス
class Enemy {
  float x, y;
  float size = 30;

  Enemy(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void update(float scroll) {
    fill(0);
    rect(x - scroll, y, size, size);
  }

  boolean checkCollision(float px, float py, float psize) {
    return (px + psize / 2 > x && px - psize / 2 < x + size &&
            py + psize / 2 > y && py - psize / 2 < y + size);
  }
}

// クリックで再開（デバッグ用）
void mousePressed() {
  loop();
}
