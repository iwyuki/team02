// Boss.pde

class Boss {
  float x, y;
  float size;
  PImage img;
  float initialY; // ボスの初期Y座標（地面からの高さ）
  float gravity = 0.8;
  float jumpPower = -12; // プレイヤーより少し低めのジャンプ力
  float speedX = 0;
  float speedY = 0;
  boolean onGround = false;
  int health = 5; // ボスの体力
  long lastJumpTime; // 最後にジャンプした時間
  float jumpInterval = 1500; // ジャンプ間隔（ミリ秒）
  long lastShotTime; // 最後に弾を撃った時間
  float shotInterval = 1000; // 弾の発射間隔（ミリ秒）

  ArrayList<BossBullet> bossBullets; // ボスが発射する弾のリスト

  Boss(float x, float y, float s, PImage i) {
    this.x = x;
    this.y = y;
    this.size = s;
    this.img = i;
    this.initialY = y; // 初期Y座標を保存
    this.lastJumpTime = millis(); // 現在時刻で初期化
    this.lastShotTime = millis(); // 現在時刻で初期化
    this.bossBullets = new ArrayList<BossBullet>();
  }

  void show(float scrollX) {
    imageMode(CENTER);
    image(img, x - scrollX, y, size, size);

    // ボスが発射する弾の描画 (更新と画面外チェックはmain.pdeで実施)
    for (BossBullet bb : bossBullets) {
      bb.show(scrollX);
    }
  }

  void update(float playerX, float playerY) {
    // 重力
    speedY += gravity;
    y += speedY;

    // 地面または足場との衝突判定
    if (y + size / 2 >= groundY) {
      y = groundY - size / 2;
      speedY = 0;
      onGround = true;
    } else {
      onGround = false;
    }

    // プレイヤーへの追尾（X方向）
    float targetSpeed = 0.05; // ボスの移動速度
    if (playerX > x) {
      speedX = targetSpeed;
    } else if (playerX < x) {
      speedX = -targetSpeed;
    } else {
      speedX = 0;
    }
    x += speedX;

    // ジャンプ追尾
    if (onGround && millis() - lastJumpTime > jumpInterval) {
      // プレイヤーがボスより高い位置にいる場合にジャンプ
      if (playerY < y - size / 4) { // プレイヤーがボスの頭より上ならジャンプ
        speedY = jumpPower;
        onGround = false;
        lastJumpTime = millis();
      }
    }

    // 弾の発射
    if (millis() - lastShotTime > shotInterval) {
      shootBullet(playerX, playerY);
      lastShotTime = millis();
    }
  }

  void shootBullet(float playerX, float playerY) {
    float bulletSpeed = 6;
    float angle = atan2(playerY - y, playerX - x); // プレイヤーの方向へ
    bossBullets.add(new BossBullet(x, y, cos(angle) * bulletSpeed, sin(angle) * bulletSpeed));
  }

  // 土管との衝突判定と反応（新しいメソッド）
  boolean checkCollisionWithPipe(Pipe p) {
    // ボスが土管に乗り上げた場合の判定
    boolean hittingPipeX = (x + size / 2 > p.x - p.width / 2 && x - size / 2 < p.x + p.width / 2);
    boolean hittingPipeY = (y + size / 2 <= p.y + speedY && y + size / 2 + speedY >= p.y);

    if (hittingPipeX && hittingPipeY) {
      y = p.y - size / 2; // 土管の上に位置を調整
      speedY = 0; // 落下速度をリセット
      onGround = true; // 着地状態にする
      return true;
    }
    // 土管の側面や下からの衝突も考慮に入れる場合は、別途ロジックを追加
    return false;
  }

  boolean checkCollisionWithPlayer(float pX, float pY, float pSize) {
    // ボス本体とプレイヤーの衝突判定
    return dist(x, y, pX, pY) < (size / 2) + (pSize / 2);
  }

  void takeDamage() {
    health--;
    println("Boss Health: " + health);
  }

  boolean isDefeated() {
    return health <= 0;
  }
}

// ボスが発射する弾のクラス
class BossBullet {
  float x, y;
  float size = 20;
  float speedX, speedY;

  BossBullet(float x, float y, float sx, float sy) {
    this.x = x;
    this.y = y;
    this.speedX = sx;
    this.speedY = sy;
  }

  void update() {
    x += speedX;
    y += speedY;
  }

  void show(float scrollX) {
    fill(255, 0, 0); // 赤い弾
    ellipse(x - scrollX, y, size, size);
  }

  boolean checkCollisionWithPlayer(float pX, float pY, float pSize) {
    return dist(x, y, pX, pY) < (size / 2) + (pSize / 2);
  }

  boolean isOffScreen(float scrollX) {
    return x - scrollX < -50 || x - scrollX > width + 50 || y < -50 || y > height + 50;
  }
}
