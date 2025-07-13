// Bullet.pde

class Bullet {
  float x, y;
  float size = 15; // 弾のサイズ
  float speed;

  Bullet(float x, float y, float speed) {
    this.x = x;
    this.y = y;
    this.speed = speed;
  }

  void update() {
    x += speed;
  }

  void show(float scroll) {
    fill(255, 100, 0); // 弾の色
    ellipse(x - scroll, y, size, size);
  }

  // 弾と敵の衝突判定
  boolean checkCollisionWithEnemy(Enemy e) {
    float r1 = size / 2;
    float r2 = e.size / 2;
    float distCentersSq = (x - e.x) * (x - e.x) + (y - e.y) * (y - e.y);
    return distCentersSq < (r1 + r2) * (r1 + r2);
  }

  // 弾と矩形ブロックの衝突判定 (Block, QuestionBlock共通)
  boolean checkCollisionWithBlock(float blockX, float blockY, float blockSize) {
    float bulletLeft = x - size / 2;
    float bulletRight = x + size / 2;
    float bulletTop = y - size / 2;
    float bulletBottom = y + size / 2;

    float blockLeft = blockX;
    float blockRight = blockX + blockSize;
    float blockTop = blockY;
    float blockBottom = blockY + blockSize;

    return bulletRight > blockLeft && bulletLeft < blockRight &&
           bulletBottom > blockTop && bulletTop < blockBottom;
  }
}
