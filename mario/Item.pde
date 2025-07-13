// Item.pde

class Item {
  float x, y;
  float size = 40; // アイテムのサイズ
  PImage img;
  float initialY; // 初期Y座標（出現アニメーション用）
  float spawnSpeed = -5; // 出現時の上昇速度
  float currentSpeedY = 0; // アイテムの落下速度
  float gravity = 0; // アイテムにかかる重力

  Item(float x, float y, PImage itemImage) {
    this.x = x;
    this.y = y;
    this.initialY = y;
    this.img = itemImage;
  }

  void update() {
    if (y > initialY - size + 20) { // 一定の高さまで上昇
      y += spawnSpeed;
    } else {
      // 一定の高さに達したら落下開始
      currentSpeedY += gravity;
      y += currentSpeedY;
    }

    // 地面との衝突判定 (アイテムが地面に落ちたら停止)
    if (y + size / 2 >= groundY) {
      y = groundY - size / 2;
      currentSpeedY = 0;
    }
  }

  void show(float scroll) {
    imageMode(CENTER);
    image(img, x - scroll, y, size, size);
  }

  // プレイヤーとアイテムの衝突判定
  boolean checkCollisionWithPlayer() {
    float px = playerX;
    float py = playerY;
    float pr = playerSize / 2;
    float ir = size / 2;

    float distCentersSq = (px - x) * (px - x) + (py - y) * (py - y);
    return distCentersSq < (pr + ir) * (pr + ir);
  }
}
