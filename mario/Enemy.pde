class Enemy {
  float x, y;
  float size = 70;
  float speed = 1.5;
  float leftBound, rightBound;
  PImage img;  // 敵画像

  Enemy(float x, float y, float leftBound, float rightBound, PImage img) {
    this.x = x;
    this.y = y;
    this.leftBound = leftBound;
    this.rightBound = rightBound;
    this.img = img;
  }

  void move() {
    x += speed;
    if (x < leftBound || x > rightBound) {
      speed *= -1;
    }
  }

  void show(float scroll) {
    if (img != null) {
      imageMode(CORNER);
      image(img, x - scroll, y, size, size);
    } else {
      fill(0);
      rect(x - scroll, y, size, size);
    }
  }

  boolean checkCollision(float px, float py, float psize) {
    return (px + psize / 2 > x &&
            px - psize / 2 < x + size &&
            py + psize / 2 > y &&
            py - psize / 2 < y + size);
  }
}
