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
